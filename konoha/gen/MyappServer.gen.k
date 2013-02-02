Import("MiniKonoha.NameSpace");
Import("JavaScript.Array");
Import("JavaStyle.Object");
Import("Syntax.JavaStyleClass");
Load("../JsonRpc.k");
class MyappServer extends JsonRPCServer {}
const ArgumentId=int;
@Public ArgumentId ConvertToArgumentId(Json json) {
    return json.toint();
}
const NodeId=int;
@Public NodeId ConvertToNodeId(Json json) {
    return json.toint();
}
const NodeType=int;
@Public NodeType ConvertToNodeType(Json json) {
    return json.toint();
}
const NodeIdList=Array[NodeId];
@Public NodeIdList ConvertToNodeIdList(Json json) {
  NodeIdList a = [];
  int i, length = json.getSize();
  for (i=0; i < length; i = i + 1) {
      a.add(ConvertToNodeId(json.get(i)));
  }
  return a;
}
const StringMap=Array[String];
@Public StringMap ConvertToStringMap(Json json) {
  StringMap a = [];
  int i, length = json.getSize();
  for (i=0; i < length; i = i + 1) {
      a.add(ConvertToString(json.get(i)));
  }
  return a;
}
const NodeList=Array[Object];
@Public NodeList ConvertToNodeList(Json json) {
  NodeList a = [];
  int i, length = json.getSize();
  for (i=0; i < length; i = i + 1) {
      a.add(ConvertToObject(json.get(i)));
  }
  return a;
}
class Node  {
  NodeId ThisNodeId;
  NodeId PrevNodeId;
  ArgumentId BelongedArgumentId;
  NodeList Children;
  StringMap Attributes;
  NodeId NextNodeId;
}
class Goal extends Node {
}
class Evidence extends Node {
}
class Stategy extends Node {
}
class Context extends Node {
}
class DscriptEvidence extends Evidence {
  String script;
}
class DscriptContext extends Context {
  String script;
}
class TopGoal extends Goal {
  NodeId TopGoalNodeId;
  ArgumentId ThisArgumentId;
}
void MyappServer.GetRootArgument (Json request) {
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNode (Json request) {
  NodeId Id = ConvetToNodeId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNodeTree (Json request) {
  NodeId Id = ConvetToNodeId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNodeId (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Replace (Json request) {
  NodeId OldNodeId = ConvetToNodeId(request.get("OldNodeId"));
  Node NewNodeTree = ConvetToNode(request.get("NewNodeTree"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Add (Json request) {
  NodeId ParentNodeId = ConvetToNodeId(request.get("ParentNodeId"));
  Node ChildNodeTree = ConvetToNode(request.get("ChildNodeTree"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.DeleteLink (Json request) {
  NodeId ParentNodeId = ConvetToNodeId(request.get("ParentNodeId"));
  Node TargetNode = ConvetToNode(request.get("TargetNode"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.NewLink (Json request) {
  NodeId ParentNodeId = ConvetToNodeId(request.get("ParentNodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Create (Json request) {
  String Description = ConvetToString(request.get("Description"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindNodeFrom (Json request) {
  NodeId NodeIdSearchFrom = ConvetToNodeId(request.get("NodeIdSearchFrom"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindNodeByDescription (Json request) {
  String SearchText = ConvetToString(request.get("SearchText"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindContextByProperty (Json request) {
  String SearchText = ConvetToString(request.get("SearchText"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
