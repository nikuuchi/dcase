#include "io.h"
#include "../../kjson/kjson/kjson.c"
#include <stdlib.h>

typedef struct Jsonq {
    JSON Root;
    JSONMemoryPool mpool;
    int64_t LastNodeId;
} Jsonq;

Jsonq *Jsonq_Open(int argc, char const *argv[]);
void Jsonq_Loadfile(Jsonq *jsonq, int argc, const char *argv[]);
void Jsonq_Merge(Jsonq *jsonq, JSON json);
void Jsonq_Close(Jsonq *jsonq);

#define LEN(STRING) (sizeof(STRING) - 1)

#define HASH_(STRING)     HASH_##STRING
#define HASH_DECL(STRING) static unsigned HASH_(STRING) = -1

HASH_DECL(insert);
HASH_DECL(remove);
HASH_DECL(replace);

static void HASH_INIT()
{
#define HASH_SET(STRING) HASH_(STRING) = HASH(#STRING, LEN(#STRING))
    HASH_SET(insert);
    HASH_SET(remove);
    HASH_SET(replace);
#undef HASH_SET
}

static bool EndsWith(const char *str, size_t slen, const char *end, size_t elen)
{
    return strncmp(str + slen - elen, end, elen) == 0;
}

#define JSON_GET(JSON, STRING) JSON_get(JSON, STRING, LEN(STRING))

static inline JSONString *ToJSONString(JSON json)
{
    if(IsStr(json.val)) {
        return toStr(json.val);
    }
    return NULL;
}

static void Error(const char *message, const char *filename, unsigned line)
{
    fprintf(stderr, "[%s:%d] %s\n", filename, line, message);
    exit(EXIT_FAILURE);
}

static bool JSON_FindById(JSON json, const char *Key, size_t Len, int32_t Id)
{
    JSON Field = JSON_get(json, Key, Len);
    return (JSON_isValid(Field) && IsInt32(Field.val) && toInt32(Field.val) == Id);
}

typedef struct JSONArray_iterator {
    JSON      *Itr, *End;
    JSONArray *Array;
} JSONArray_iterator;

static JSON JSON_FindCurrentNode(JSON NodeList, JSON node)
{
    while(true) {
        JSON NextId = JSON_GET(node, "NextNodeId");
        if(JSON_isValid(NextId) && JSONInt_get(NextId) == -1) {
            return node;
        }
        JSONArray_iterator Itr;
        JSON_ARRAY_EACH(NodeList, Itr.Array, Itr.Itr, Itr.End) {
            JSON json = *(Itr.Itr);
            JSON ThisId = JSON_GET(json, "ThisNodeId");
            if(NextId.bits == ThisId.bits) {
                node = json;
                break;
            }
        }
    }
    assert(0 && "unreachable");
    return JSON_NOP();
}

static void Jsonq_Insert(Jsonq *jsonq, JSON branch, JSON NodeList)
{
    /* json = [ $NODE, $NODE, $NODE ] */
    assert(IsAry(branch.val));
    JSONArray_iterator Itr, Itr2;
    JSON_ARRAY_EACH(branch, Itr.Array, Itr.Itr, Itr.End) {
        JSON json = *(Itr.Itr);
        int32_t Id = JSON_getInt(json, "ThisNodeId", LEN("ThisNodeId"));
        JSON_ARRAY_EACH(NodeList, Itr2.Array, Itr2.Itr, Itr2.End) {
            JSON node = *(Itr2.Itr);
            bool IsValid = JSON_FindById(node, "ParentNodeId", LEN("ParentNodeId"), Id);
            if(!IsValid) {
                continue;
            }
            JSONObject_remove(&jsonq->mpool, node, "ParentNodeId", LEN("ParentNodeId"));
            JSON NewId = JSONInt_new(&jsonq->mpool, ++jsonq->LastNodeId);
            JSONObject_set(&jsonq->mpool, node, "ThisNodeId", LEN("ThisNodeId"), NewId);
            JSONArray_append(&jsonq->mpool, branch, node);

            JSON child = JSON_GET(json, "Children");
            JSONArray_append(&jsonq->mpool, child, NewId);
        }
    }
}

struct Link {
    JSON  OldId;
    JSON  NewId;
};

static struct Link *Jsonq_ReplaceNode(Jsonq *jsonq, JSON branch, unsigned Idx, JSON json, JSON NodeList, struct Link *Links)
{
    json = JSON_FindCurrentNode(branch, json);
    JSON JsonId = JSON_GET(json, "ThisNodeId");
    int32_t Id  = JSON_getInt(json, "ThisNodeId", LEN("ThisNodeId"));
    struct Link *Cur = Links;
    JSONArray_iterator Itr;
    JSON_ARRAY_EACH(NodeList, Itr.Array, Itr.Itr, Itr.End) {
        JSON node = *(Itr.Itr);
        bool IsValid = JSON_FindById(node, "PrevNodeId", LEN("PrevNodeId"), Id);
        if(!IsValid) {
            continue;
        }
        JSON NewId = JSONInt_new(&jsonq->mpool, ++jsonq->LastNodeId);
        JSONObject_set(&jsonq->mpool, node, "ThisNodeId", LEN("ThisNodeId"), NewId);
        JSONObject_set(&jsonq->mpool, json, "NextNodeId", LEN("NextNodeId"), NewId);
        JSONArray_append(&jsonq->mpool, branch, node);
        Cur[0].OldId = JsonId;
        Cur[0].NewId = NewId;
        Cur++;
    }
    return Cur;
}

static void Jsonq_ReplaceChildren(Jsonq *jsonq, JSON json, struct Link *Links, unsigned LinkSize)
{
    int32_t Idx = 0;
    JSON child = JSON_GET(json, "Children");
    JSONArray_iterator Itr;
    JSON_ARRAY_EACH(child, Itr.Array, Itr.Itr, Itr.End) {
        Idx++;
        JSON Id = *(Itr.Itr);
        unsigned j;
        for(j = 0; j < LinkSize; j++) {
            if(Id.bits == Links[j].OldId.bits) {
                JSONArray_set(child, Idx-1, Links[j].NewId);
            }
        }
    }
}

static void Jsonq_Replace(Jsonq *jsonq, JSON branch, JSON NodeList)
{
    /* json = [ $NODE, $NODE, $NODE ] */
    assert(IsAry(branch.val));
    JSONArray_iterator Itr;
    unsigned Idx = 0, len = JSON_length(NodeList);

    struct Link Links[len], *Cur = Links;

    JSON_ARRAY_EACH(branch, Itr.Array, Itr.Itr, Itr.End) {
        JSON json = *(Itr.Itr);
        Idx++;
        Cur = Jsonq_ReplaceNode(jsonq, branch, Idx, json, NodeList, Cur);
    }
    JSON_ARRAY_EACH(branch, Itr.Array, Itr.Itr, Itr.End) {
        JSON json = *(Itr.Itr);
        Jsonq_ReplaceChildren(jsonq, json, Links, len);
    }
}

static void Jsonq_op(Jsonq *jsonq, JSON command, JSON BranchName, JSON NodeList)
{
    JSONString *op;
    if((op = ToJSONString(command))) {
        JSON branch = JSONObject_get(jsonq->Root, toStr(BranchName.val));
        if(!JSON_isValid(branch)) {
            Error("invalid branch name", __func__, __LINE__);
        }

        if(JSONString_hashCode(op) == HASH_(insert)) {
            Jsonq_Insert(jsonq, branch, NodeList);
        }
        else if(JSONString_hashCode(op) == HASH_(replace)) {
            //fprintf(stderr, "replace %s\n", JSONString_get(BranchName));
            Jsonq_Replace(jsonq, branch, NodeList);
        }
        else if(JSONString_hashCode(op) == HASH_(remove)) {
            fprintf(stderr, "remove %s\n", JSONString_get(BranchName));
            Error("Not Implemented", __func__, __LINE__);
        }
    }
}

static void Jsonq_merge_commits(Jsonq *jsonq, JSON json)
{
    JSON commits = JSON_GET(json, "commit");
    JSONArray_iterator Itr;
    JSON_ARRAY_EACH(commits, Itr.Array, Itr.Itr, Itr.End) {
        JSON obj = *(Itr.Itr);
        JSON branch   = JSON_GET(obj, "branch-name");
        JSON command  = JSON_GET(obj, "command");
        JSON NodeList = JSON_GET(obj, "node-list");
        Jsonq_op(jsonq, command, branch, NodeList);
    }
    JSONObject_remove(&jsonq->mpool, json, "commit", LEN("commit"));
}

#define MAX(A, B) (((A) > (B)) ? (A) : (B))

static void Jsonq_merge_object(Jsonq *jsonq, JSON json)
{
    JSON Key, Val;
    JSONObject_iterator Itr;
    JSON_OBJECT_EACH(json, Itr, Key, Val) {
        JSONArray_iterator Itr;
        JSON_ARRAY_EACH(Val, Itr.Array, Itr.Itr, Itr.End) {
            JSON node = *(Itr.Itr);
            int32_t Id = JSON_getInt(node, "ThisNodeId", LEN("ThisNodeId"));
            jsonq->LastNodeId = MAX(jsonq->LastNodeId, Id);
        }
        JSONObject_setObject(&jsonq->mpool, jsonq->Root, Key, Val);
    }
}

void Jsonq_Merge(Jsonq *jsonq, JSON json)
{
    Jsonq_merge_commits(jsonq, json);
    Jsonq_merge_object(jsonq, json);
    JSON_free(json);
}

static JSON LoadJsonFile(Jsonq *jsonq, const char *filepath)
{
    FILE *fp = fopen(filepath, "rb");
    if(!fp) {
        return JSONError_new(&jsonq->mpool, "File Not Found");
    }

    fseek(fp, 0, SEEK_END);
    size_t len = (size_t) ftell(fp);
    fseek(fp, 0, SEEK_SET);
    char *text = (char *) malloc(len + 1);
    assert(len == fread(text, 1, len, fp));
    text[len] = '\0';
    JSON json = parseJSON(&jsonq->mpool, text, text + len);
    fclose(fp);
    free(text);
    return json;
}

void Jsonq_Loadfile(Jsonq *jsonq, int argc, const char *argv[])
{
    int i;
    for(i = 0; i < argc; i++) {
        const char *file = argv[i];
        if(EndsWith(file, strlen(file), ".json", 5)) {
            JSON json = LoadJsonFile(jsonq, file);
            if(IsError(json.val)) {
                Error(JSONError_get(json), __func__, __LINE__);
            }
            Jsonq_Merge(jsonq, json);
        }
    }
}

Jsonq *Jsonq_Open(int argc, char const *argv[])
{
    Jsonq *jsonq = (Jsonq *) malloc(sizeof(*jsonq));
    jsonq->LastNodeId = 0;
    JSONMemoryPool_Init(&jsonq->mpool);
    HASH_INIT();
    jsonq->Root = JSONObject_new(&jsonq->mpool, 0);
    Jsonq_Loadfile(jsonq, argc, argv);
    return jsonq;
}

struct Jsonq_Visitor {
    void (*Visit)(struct Jsonq_Visitor *visitor, JSON json);
    JSON  CurrentRoot;
    long  indent_level;
};

static void DumpJson(struct Jsonq_Visitor *visitor, JSON json)
{
    JSON Desc  = JSON_GET(json, "Description");
    int32_t i, Id = JSON_getInt(json, "ThisNodeId", LEN("ThisNodeId"));
    for(i = 0; i < visitor->indent_level; i++) {
        fprintf(stderr, "  ");
    }
    fprintf(stderr, "[Id : %d] Description:\"%s\"\n", Id, JSONString_get(Desc));
}

static void DumpJsonVerbose(struct Jsonq_Visitor *visitor, JSON json)
{
    int32_t Id = JSON_getInt(json, "ThisNodeId", LEN("ThisNodeId"));
    JSON NextId = JSON_GET(json, "NextNodeId");
    JSON PrevId = JSON_GET(json, "PrevNodeId");
    JSON Desc   = JSON_GET(json, "Description");
    fprintf(stderr, "  [Id : %d]\n", Id);
    if(JSON_isValid(NextId) && JSONInt_get(NextId) != -1) {
        fprintf(stderr, "    Next : %d\n", JSONInt_get(NextId));
    }
    if(JSON_isValid(PrevId) && JSONInt_get(PrevId) != -1) {
        fprintf(stderr, "    Prev : %d\n", JSONInt_get(PrevId));
    }
    fprintf(stderr, "    Description:\"%s\"\n", JSONString_get(Desc));
    fprintf(stderr, "    Child : [");
    JSON child = JSON_get(json, "Children", LEN("Children"));
    JSONArray_iterator Itr2;
    JSON_ARRAY_EACH(child, Itr2.Array, Itr2.Itr, Itr2.End) {
        JSON cid = *(Itr2.Itr);
        if(JSON_isValid(cid))
            fprintf(stderr, "%d,", JSONInt_get(cid));
    }
    fprintf(stderr, "]\n\n");
}

static void Jsonq_visit(Jsonq *jsonq, JSON json, struct Jsonq_Visitor *visitor)
{
    JSON child = JSON_get(json, "Children", LEN("Children"));
    visitor->Visit(visitor, json);
    JSONArray_iterator Itr;
    JSON_ARRAY_EACH(child, Itr.Array, Itr.Itr, Itr.End) {
        JSONArray_iterator Itr2;
        JSON_ARRAY_EACH(visitor->CurrentRoot, Itr2.Array, Itr2.Itr, Itr2.End) {
            JSON node = *(Itr2.Itr);
            int32_t Id0 = JSONInt_get(*(Itr.Itr));
            int32_t Id1 = JSON_getInt(node, "ThisNodeId", LEN("ThisNodeId"));
            if(Id0 == Id1) {
                visitor->indent_level += 1;
                Jsonq_visit(jsonq, node, visitor);
                visitor->indent_level -= 1;
            }
        }
    }
}

static void Jsonq_DumpCurrentTree(Jsonq *jsonq)
{
    JSON Key, Val;
    JSONObject_iterator Itr;
    struct Jsonq_Visitor visitor = {DumpJson, {}, 0};
    JSON_OBJECT_EACH(jsonq->Root, Itr, Key, Val) {
        fprintf(stderr, "branch %s:\n", JSONString_get(Key));
        visitor.indent_level = 0;
        visitor.CurrentRoot  = Val;
        Jsonq_visit(jsonq, JSONArray_get(Val, 0), &visitor);
    }
}

static void Jsonq_dump(Jsonq *jsonq, bool verbose)
{
    Jsonq_DumpCurrentTree(jsonq);
    if(!verbose) return;
    JSON Key, Val;
    JSONObject_iterator Itr;
    struct Jsonq_Visitor visitor = {0, {}, 0};
    JSON_OBJECT_EACH(jsonq->Root, Itr, Key, Val) {
        fprintf(stderr, "branch %s:\n", JSONString_get(Key));
        JSONArray_iterator Itr;
        JSON_ARRAY_EACH(Val, Itr.Array, Itr.Itr, Itr.End) {
            DumpJsonVerbose(&visitor, *(Itr.Itr));
        }
    }
}

void Jsonq_Close(Jsonq *jsonq)
{
    JSON_free(jsonq->Root);
    JSONMemoryPool_Delete(&jsonq->mpool);
    free(jsonq);
}

JSON Jsonq_match(Jsonq *jsonq, JSONString *string, bool exact);

int main(int argc, char const *argv[])
{
    Jsonq *jsonq = Jsonq_Open(argc, argv);
    Jsonq_dump(jsonq, true);
    Jsonq_Close(jsonq);
    return 0;
}
