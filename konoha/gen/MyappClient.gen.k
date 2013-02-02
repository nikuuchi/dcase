Import("MiniKonoha.NameSpace");
Import("JavaScript.Array");
Import("JavaStyle.Object");
Import("Syntax.JavaStyleClass");
Load("../JsonRpc.k");
class MyappClient extends JsonRPCClient {}
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
Node MyappClient.GetRootArgument () {
  Json[] param = [];
  Json request  = createMessage("GetRootArgument", param);
  Json response = emitRequest(request);
  return ConvertToNode(response.get("result"));
}
Node MyappClient.GetNode (NodeId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetNode", param);
  Json response = emitRequest(request);
  return ConvertToNode(response.get("result"));
}
NodeList MyappClient.GetNodeTree (NodeId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetNodeTree", param);
  Json response = emitRequest(request);
  return ConvertToNodeList(response.get("result"));
}
NodeId MyappClient.GetNodeId (ArgumentId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetNodeId", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeId MyappClient.Replace (NodeId OldNodeId,Node NewNodeTree) {
  Json[] param = [];
  param.add(OldNodeId.toJson());
  param.add(NewNodeTree.toJson());
  Json request  = createMessage("Replace", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeId MyappClient.Add (NodeId ParentNodeId,Node ChildNodeTree) {
  Json[] param = [];
  param.add(ParentNodeId.toJson());
  param.add(ChildNodeTree.toJson());
  Json request  = createMessage("Add", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeId MyappClient.DeleteLink (NodeId ParentNodeId,Node TargetNode) {
  Json[] param = [];
  param.add(ParentNodeId.toJson());
  param.add(TargetNode.toJson());
  Json request  = createMessage("DeleteLink", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeId MyappClient.NewLink (NodeId ParentNodeId) {
  Json[] param = [];
  param.add(ParentNodeId.toJson());
  Json request  = createMessage("NewLink", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeId MyappClient.Create (String Description) {
  Json[] param = [];
  param.add(Description.toJson());
  Json request  = createMessage("Create", param);
  Json response = emitRequest(request);
  return ConvertToNodeId(response.get("result"));
}
NodeIdList MyappClient.FindNodeFrom (NodeId NodeIdSearchFrom) {
  Json[] param = [];
  param.add(NodeIdSearchFrom.toJson());
  Json request  = createMessage("FindNodeFrom", param);
  Json response = emitRequest(request);
  return ConvertToNodeIdList(response.get("result"));
}
NodeIdList MyappClient.FindNodeByDescription (String SearchText) {
  Json[] param = [];
  param.add(SearchText.toJson());
  Json request  = createMessage("FindNodeByDescription", param);
  Json response = emitRequest(request);
  return ConvertToNodeIdList(response.get("result"));
}
NodeIdList MyappClient.FindContextByProperty (String SearchText) {
  Json[] param = [];
  param.add(SearchText.toJson());
  Json request  = createMessage("FindContextByProperty", param);
  Json response = emitRequest(request);
  return ConvertToNodeIdList(response.get("result"));
}
