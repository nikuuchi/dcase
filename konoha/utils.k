Import("JavaScript.String");
Import("Type.File");
Import("Type.Bytes");
Import("MiniKonoha.NameSpace");
import("MiniKonoha.Sql");
Import("Syntax.CStyleWhile");
Import("Syntax.JavaStyleClass");
Import("Syntax.JavaNewArray");

String readFile(String path) {
    FILE file = new FILE(path, "rb");
    int len = 0;
    String tmp = "";
    while (true) {
        int ch = file.getc();
        if (ch == -1) {
            break;
        }
        len = len + 1;
    }
    file.close();

    if (len == 0) {
        return "";
    }

    Bytes buf = new Bytes(len+1);
    file = new FILE(path, "r");
    file.read(buf, 0, len);
    file.close();
    String res = new String(buf, 0, len);
    return res;
}

