Import("Lib.Curl");
Import("MiniKonoha.Map");
Import("JavaScript.Array");
Import("Syntax.JavaStyleClass");
Import("Syntax.CStyleFor");
Import("Syntax.StringInterpolation");

class HttpClient {
    String url = "";
    @Virtual String perform() { return ""; }
    @Virtual String post(Map[String] fields) { return ""}
    @Virtual String get(Map[String] fields)  { return ""}
}

class CurlHttpClient extends HttpClient {
    Curl curl;
    CurlHttpClient(String url) {
        this.url = url;
        this.curl = new Curl();
        this.curl.setOpt(CURLOPT_URL, url);
    }
    String perform() {
        return curl.receiveString();
    }
    String CreateParam(Map[String] map) {
        int i = 0;
        String[] keys = map.keys();
        String param = "";
        for (i=0; i < keys.getlength(); i = i + 1) {
            if (i != 0) {
                param = param + "&";
            }
            String key = keys[i];
            /* FIXME Escaping key and value */
            param = param + "${key}=${map.get(key)}";
        }
        return param;
    }
    String post(Map[String] fields) {
        curl.setOpt(CURLOPT_POST, true);
        String param = CreateParam(fields);
        curl.setOpt(CURLOPT_POSTFIELDS, param);
        return perform();
    }
    String get(Map[String] fields) {
        curl.setOpt(CURLOPT_GET, true);
        if (fields.getSize() > 0) {
            String param = CreateParam(fields);
            curl.setOpt(CURLOPT_URL, url+"?"+param);
        }
        return perform();
    }
}

// TestCase
void test0() {
    HttpClient client = new CurlHttpClient("http://localhost/masa/req.php");
    Map[String] map = new Map[String]();
    map.set("a", "100");
    map.set("b", "1000");
    System.p(client.post(map));
}
