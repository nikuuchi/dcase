Load("../gen/MyappClient.gen.k");

Node Node.new() {
  this.ThisNodeId = -1;
  this.PrevNodeId = -1;
  this.NextNodeId = -1;
  this.BelongedArgumentId = -1;
  this.Children = [];
  this.Description = "";
  this.Attributes = null; /* FIXME */
  return this;
}

/* Custom API */
Goal MyappClient.CreateGoal (String Description) {
  Goal goal = new Goal();
  goal.Description = Description;
  return goal;
}
Evidence MyappClient.CreateEvidence (String Description) {
  Evidence evidence = new Goal();
  evidence.Description = Description;
  return evidence;
}
Strategy MyappClient.CreateStrategy (String Description) {
  Strategy strategy = new Strategy();
  strategy.Description = Description;
  return strategy;
}
Context MyappClient.CreateContext (String Description) {
  Context context = new Context();
  context.Description = Description;
  return context;
}
DscriptEvidence MyappClient.CreateDscriptEvidence (String Description, String script) {
  Evidence evidence = new Goal();
  evidence.Description = Description;
  evidence.script = script;
  return evidence;
}
DscriptContext MyappClient.CreateDscriptContext (String Description, String script) {
  DscriptContext context = new DscriptContext();
  context.Description = Description;
  context.script = script;
  return context;
}
void MyappClient.AddChildren (Node ThisNode, Node Child) {
}
void MyappClient.AddHistory (Node NewNode, Node OldNode) {
}
void f() {
    /* Client Side */
    MyappClient client = new MyappClient("http://127.0.0.1/masa/req.php");
    NodeId Id = client.GetNodeId(1);
    System.p(Id);
}

f();
