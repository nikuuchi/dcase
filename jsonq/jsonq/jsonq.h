#ifndef JSONQ_H
#define JSONQ_H

#include "../../kjson/kjson/kjson.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct Jsonq {
    JSON Root;
    JSONMemoryPool mpool;
    int64_t LastNodeId;
} Jsonq;

Jsonq *Jsonq_Open(int argc, char const *argv[]);
void Jsonq_Loadfile(Jsonq *jsonq, int argc, const char *argv[]);
void Jsonq_Merge(Jsonq *jsonq, JSON json);
void Jsonq_Close(Jsonq *jsonq);
JSON Jsonq_Find(Jsonq *jsonq, JSON Query);

#ifdef __cplusplus
} /* extern "C" */
#endif
#endif /* end of include guard */
