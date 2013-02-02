Import("Syntax.JavaStyleClass");
Import("Syntax.CStyleBitwiseOperator");
Import("Syntax.CStyleWhile");
Import("Syntax.CStyleFor");
Import("Syntax.GlobalVariable");
Import("Syntax.Null");
Import("Syntax.StringInterpolation");
Import("JavaScript.Array");
Import("Java.String");
Import("JavaScript.String");
Import("MiniKonoha.Syntax");
Import("MiniKonoha.NameSpace");
Import("Type.Json");
Import("Type.File");

Json TypeMap = new Json();
TypeMap.setString("int", "int");
TypeMap.setString("String", "String");

Json ConstMap = new Json();

File output = stdout;
String AppName = "MyRpc";
String AppType = "JsonRPCClient";

class IDLCodeGenerator {
    String ext = ".output";
    IDLCodeGenerator() {}
    void emit(String str) {
        global.output.println(str);
    }
    @Virtual void init() {}
    @Virtual void emitAlias(String NewType, String OldType) {}
    @Virtual void emitMethod(String ReturnType, String MethodName, Json Param) {}
    @Virtual void emitType(String TypeName, String SuperType, Json TypeDecl) {}
}

IDLCodeGenerator gen = null;

int ParseAlias(Node node, Symbol sym, Token[] tokenList, int beginIdx, int opIdx, int endIdx) {
    if (endIdx - beginIdx != 3) {
        return -1;
    }
    /* alias Type1 Type2 */
    node.AddParsedObject("OldType", tokenList[beginIdx+1]);
    node.AddParsedObject("NewType", tokenList[beginIdx+2]);
    return endIdx;
}

Node TypeAlias(Node node, NameSpace ns, Object o) {
    String OldTypeName = node.getToken("OldType", null).GetParsedText();
    String NewTypeName = node.getToken("NewType", null).GetParsedText();
    if (global.TypeMap.getString(NewTypeName) != "") {
        return node.Message(ErrTag, "Already Defined TypeName '${NewTypeName}'");
    }
    global.TypeMap.setString(NewTypeName, OldTypeName);
    global.gen.emitAlias(NewTypeName, OldTypeName);
    node.done();
    return node;
}

Node TypeAttribute(Node node, NameSpace ns, Object o) {
    String TypeName = node.getToken("First",  null).GetParsedText();
    String VarName  = node.getToken("Second", null).GetParsedText();
    Json json = new Json();
    json.setString(VarName, TypeName);
    return node.SetConstValue(json);
}

int ParseArray(Node node, Symbol sym, Token[] tokenList, int beginIdx, int opIdx, int endIdx) {
    if (endIdx - beginIdx != 3) {
        return -1;
    }
    /* Array Type1 Type2 */
    node.AddParsedObject("OldType", tokenList[beginIdx+1]);
    node.AddParsedObject("NewType", tokenList[beginIdx+2]);
    return endIdx;
}

Node TypeArray(Node node, NameSpace ns, Object o) {
    String OldTypeName = node.getToken("OldType", null).GetParsedText();
    String NewTypeName = node.getToken("NewType", null).GetParsedText();
    if (global.TypeMap.getString(NewTypeName) != "") {
        return node.Message(ErrTag, "Already Defined TypeName '${NewTypeName}'");
    }
    global.TypeMap.setString(NewTypeName, "Array[${OldTypeName}]");
    global.gen.emitAlias(NewTypeName, "Array[${OldTypeName}]");
    node.done();
    return node;
}

Node TypeType(Node node, NameSpace ns, Object o) {
    String NewTypeName = node.getToken("$Symbol", null).GetParsedText();
    String SuperType   = node.getToken("extends", null).GetParsedText();
    Node tnode = node.TypeCheckNode("$Block", Object, TypeCheckPolicy_AllowEmpty|TypeCheckPolicy_AllowVoid);
    Array[Node] NodeList = tnode.GetNodeList();
    int i = 0;

    Json type = new Json();
    if (SuperType != "") {
        Json sup  = global.TypeMap.get(SuperType);
        String[] supKeys = sup.Keys();
        while (i < supKeys.getlength()) {
            String key = supKeys[i];
            type.setString(key, sup.getString(key));
            i = i + 1;
        }
    }

    i = 0;
    while (i < NodeList.getlength()) {
        Node Cur = NodeList[i];
        assert(Cur.GetType() == KNode_Const);
        Json json = Cur.getConstValue() as Json;
        String[] keys = json.Keys();
        int j = 0;
        while (j < keys.getlength()) {
            String key = keys[j];
            if (type.hasKey(key)) {
                return node.Message(ErrTag, "Already Defined Field '${key}'");
            }
            type.setString(key, json.getString(key));
            j = j + 1;
        }
        i = i + 1;
    }
    global.gen.emitType(NewTypeName, SuperType, type);
    node.done();
    if (global.TypeMap.get(NewTypeName).toString() != "{}") {
        return node.Message(ErrTag, "Already Defined TypeName '${NewTypeName}'");
    }
    global.TypeMap.set(NewTypeName, type);

    return node;
}

Node TypeMethod(Node node, NameSpace ns, Object o) {
    String MethodName = node.getToken("$Symbol", null).GetParsedText();
    String ReturnType = node.getToken("Return", null).GetParsedText();
    Json Param = node.getParsedObject("$IDLParam") as Json;
    //if (Param != null) {
    //}
    global.gen.emitMethod(ReturnType, MethodName, Param);
    node.done();
    return node;
}

int ParseParam(Node node, Symbol sym, Token[] tokenList, int beginIdx, int opIdx, int endIdx) {
    Token[] a = [];
    int i = beginIdx;
    Json json = new Json();
    while (i + 1 < endIdx) {
        Token tk0 = tokenList[i+0];
        Token tk1 = tokenList[i+1];
        /* case: Type Field */
        if (tk0.Is("$Symbol") || tk0.Is("$Type")) {
            if(tk1.Is("$Symbol")) {
                json.setString(tk0.GetParsedText(), tk1.GetParsedText());
            }
        }
        i = i + 3;
    }
    node.AddParsedObject("$IDLParam", json);
    return endIdx;
}

void DefineSyntax() {
    Syntax AliasSyntax = new Syntax("alias");
    AliasSyntax.SetParseFunc(Precedence_Statement, 0, ParseAlias);
    AliasSyntax.SetTypeFunc(TypeAlias);
    DefineSyntax(AliasSyntax);

    Syntax AttributeSyntax = new Syntax("attribute");
    AttributeSyntax.SetParseFunc(Precedence_Statement, 0, GetPatternParseFunc());
    AttributeSyntax.SetTypeFunc(TypeAttribute);
    DefineSyntax(AttributeSyntax);
    AttributeSyntax.SetPattern("\"attribute\" First: $Symbol Second: $Symbol");

    Syntax ArraySyntax = new Syntax("array");
    ArraySyntax.SetParseFunc(Precedence_Statement, 0, ParseArray);
    ArraySyntax.SetTypeFunc(TypeArray);
    DefineSyntax(ArraySyntax);

    Syntax TypeSyntax = new Syntax("Type");
    TypeSyntax.SetParseFunc(Precedence_Statement, 0, GetPatternParseFunc());
    TypeSyntax.SetTypeFunc(TypeType);
    TypeSyntax.SetPattern("Type $Symbol [ \"extends\" extends: $Symbol] $Block");
    DefineSyntax(TypeSyntax);

    Syntax MethodSyntax = new Syntax("api");
    MethodSyntax.SetParseFunc(Precedence_Statement, 0, GetPatternParseFunc());
    MethodSyntax.SetTypeFunc(TypeMethod);
    DefineSyntax(MethodSyntax);
    MethodSyntax.SetPattern("\"api\" Return: $Symbol $Symbol \"(\"$IDLParam\")\"");

    Syntax ParamSyntax = new Syntax("$IDLParam");
    ParamSyntax.SetParseFunc(Precedence_Statement, 0, ParseParam);
    DefineSyntax(ParamSyntax);
}

DefineSyntax();

class KonohaCodeGen extends IDLCodeGenerator {
    KonohaCodeGen() {
        ext = "k";
    }
    void init() {
        emit("Import(\"MiniKonoha.NameSpace\");");
        emit("Import(\"JavaScript.Array\");");
        emit("Import(\"JavaStyle.Object\");");
        emit("Import(\"Syntax.JavaStyleClass\");");
        emit("Load(\"../JsonRpc.k\");");
        emit("class ${global.AppName} extends ${global.AppType} {}");
    }
    void emitAlias(String NewType, String OldType) {
        emit("const ${NewType}=${OldType};");
        emit("@Public ${NewType} ConvertTo${NewType}(Json json) {");
        if (OldType.startsWith("Array")) {
            String ElemType = OldType.replace("Array[", "").replace("]", "");
            emit("  ${NewType} a = [];");
            emit("  int i, length = json.getSize();");
            emit("  for (i=0; i < length; i = i + 1) {");
            emit("      a.add(ConvertTo${ElemType}(json.get(i)));");
            emit("  }");
            emit("  return a;");
        } else {
            emit("    return json.to${OldType}();");
        }
        emit("}");
    }
    void emitMethod(String ReturnType, String MethodName, Json Param) {
        String[] keys = Param.Keys();
        if (global.AppType == "JsonRPCClient") {
            String ParamInfo = "";
            int i = 0;
            for (i=0; i < keys.getlength(); i = i + 1) {
                String k = keys[i];
                if (i != 0) {
                    ParamInfo = ParamInfo + ",";
                }
                ParamInfo = ParamInfo + k + " " + Param.getString(k);
            }
            emit("${ReturnType} ${global.AppName}.${MethodName} (${ParamInfo}) {");
            emit("  Json[] param = [];");
            for (i=0; i < keys.getlength(); i = i + 1) {
                String k = keys[i];
                emit("  param.add(${Param.getString(k)}.toJson());");
            }
            emit("  Json request  = createMessage(\"${MethodName}\", param);");
            emit("  Json response = emitRequest(request);");
            emit("  return ConvertTo${ReturnType}(response.get(\"result\"));");
            emit("}");
        } else {
            emit("void ${global.AppName}.${MethodName} (Json request) {");
            int i = 0;
            for (i=0; i < keys.getlength(); i = i + 1) {
                String k = keys[i];
                String p = Param.getString(k);
                emit("  ${k} ${p} = ConvetTo${k}(request.get(\"${p}\"));");
            }
            emit("  Json request = createMessage(\"FIXME\");");
            emit("  emitResponse(request);");
            emit("}");
        }
    }
    Array[String] FilterSuperClassField(String Deriverd, String Base) {
    }
    void emitType(String TypeName, String SuperType, Json TypeDecl) {
        String Extends = "";
        if (SuperType != "") {
            Extends = "extends ${SuperType}";
        }
        emit("class ${TypeName} ${Extends} {");
        int i = 0;
        String[] keys = TypeDecl.Keys();

        Json sup = global.TypeMap.get(SuperType);
        for (i=0; i < keys.getlength(); i = i + 1) {
            String k = keys[i];
            if (sup.hasKey(k) == false) {
                emit("  ${TypeDecl.getString(k)} ${k};");
            }
        }
        emit("}");
    }
}

class JSCodeGen extends IDLCodeGenerator {
    JSCodeGen() {
        ext = "js";
    }
    void init() {
    }
    void emitMethod(String ReturnType, String MethodName, Json Param) {
        int i = 0;
        String[] keys = Param.Keys();
        String ParamInfo = "";

        if (global.AppType != "JsonRPCClient") {
            return;
        }

        for (i=0; i < keys.getlength(); i = i + 1) {
            String k = keys[i];
            if (i != 0) {
                ParamInfo = ParamInfo + ",";
            }
            ParamInfo = ParamInfo + Param.getString(k);
        }
        emit("${global.AppName}.${MethodName} = function(${ParamInfo}) {");
        emit("  var param    = [${ParamInfo}];");
        emit("  var request  = createMessage(\"${MethodName}\", param);");
        emit("  var response = emitRequest(request);");
        emit("  return response.result;");
        emit("}");

    }
    void emitType(String TypeName, String SuperType, Json TypeDecl) {
        String Extends = "";
        emit("var ${TypeName} = (function() {");
        emit("  function ${TypeName}() {}");
        if (SuperType != "") {
            emit("  ${TypeName}.prototype = ${SuperType};");
        }
        int i = 0;
        String[] keys = TypeDecl.Keys();
        Json sup  = global.TypeMap.get(SuperType);
        while (i < keys.getlength()) {
            String k = keys[i];
            if (!sup.hasKey(k)) {
                emit("  ${TypeName}.${k} = undefined;");
            }
            i = i + 1;
        }
        emit("  return ${TypeName};");
        emit("})();");
    }
}

void SetUpCodeGen() {
    int i = 0;
    for (i=0; i < SCRIPT_ARGV.getlength(); i = i + 1) {
        String arg = SCRIPT_ARGV[i];
        if (arg == "format=js") {
            global.gen = new JSCodeGen();
        }
    }
    if (global.gen == null) {
        global.gen = new KonohaCodeGen();
    }
    for (i=0; i < SCRIPT_ARGV.getlength(); i = i + 1) {
        String arg = SCRIPT_ARGV[i];
        if (arg.startsWith("app=")) {
            String FullName = arg.substring("app=".getlength());
            if (FullName.endsWith("Client")) {
                global.AppType = "JsonRPCClient";
            } else {
                global.AppType = "JsonRPCServer";
            }
            global.AppName = FullName;
            global.output = new File("gen/${FullName}.gen.${global.gen.ext}", "w");
        }
    }
    global.gen.init();
}

SetUpCodeGen();
