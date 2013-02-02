Load("gen/MyappClient.gen.k");

void f() {
    /* Client Side */
    MyappClient client = new MyappClient("http://127.0.0.1/masa/req.php");
    NodeId Id = client.GetNodeId(1);
    System.p(Id);
}

f();
