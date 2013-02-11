Import("MiniKonoha.NameSpace");
Import("JavaScript.Array");
Import("JavaStyle.Object");
Import("Syntax.JavaStyleClass");
Load("../JsonRpc.k");
class MyappClient extends JsonRPCClient {}
const NodeId=int;
@Public NodeId ConvertToNodeId(Json json) {
    return json.toint();
}
const ArgumentId=int;
@Public ArgumentId ConvertToArgumentId(Json json) {
    return json.toint();
}
const TimeLineId=int;
@Public TimeLineId ConvertToTimeLineId(Json json) {
    return json.toint();
}
const ProcessId=int;
@Public ProcessId ConvertToProcessId(Json json) {
    return json.toint();
}
const ProcessContext=StringMap;
@Public ProcessContext ConvertToProcessContext(Json json) {
    return json.toStringMap();
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
const ProcessIdList=Array[ProcessId];
@Public ProcessIdList ConvertToProcessIdList(Json json) {
  ProcessIdList a = [];
  int i, length = json.getSize();
  for (i=0; i < length; i = i + 1) {
      a.add(ConvertToProcessId(json.get(i)));
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
class TimeLine  {
  int UnixTime;
  NodeIdList OldNodeId;
  NodeIdList NewNodeId;
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
ProcessId MyappClient.OpenProcessContext (ArgumentId Id,String CommiterName) {
  Json[] param = [];
  param.add(Id.toJson());
  param.add(CommiterName.toJson());
  Json request  = createMessage("OpenProcessContext", param);
  Json response = emitRequest(request);
  return ConvertToProcessId(response.get("result"));
}
ProcessId MyappClient.CloseProcessContext (ArgumentId Id,ProcessId pId,String Justification) {
  Json[] param = [];
  param.add(Id.toJson());
  param.add(pId.toJson());
  param.add(Justification.toJson());
  Json request  = createMessage("CloseProcessContext", param);
  Json response = emitRequest(request);
  return ConvertToProcessId(response.get("result"));
}
ProcessId MyappClient.MergeProcessContext (ArgumentId Id,ProcessId mergeProc) {
  Json[] param = [];
  param.add(Id.toJson());
  param.add(mergeProc.toJson());
  Json request  = createMessage("MergeProcessContext", param);
  Json response = emitRequest(request);
  return ConvertToProcessId(response.get("result"));
}
ProcessIdList MyappClient.GetProcessContextIds (ArgumentId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetProcessContextIds", param);
  Json response = emitRequest(request);
  return ConvertToProcessIdList(response.get("result"));
}
Node MyappClient.GetRootArgument () {
  Json[] param = [];
  Json request  = createMessage("GetRootArgument", param);
  Json response = emitRequest(request);
  return ConvertToNode(response.get("result"));
}
NodeIdList MyappClient.GetArgumentsIdList () {
  Json[] param = [];
  Json request  = createMessage("GetArgumentsIdList", param);
  Json response = emitRequest(request);
  return ConvertToNodeIdList(response.get("result"));
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
NodeList MyappClient.GetNodeTree (NodeId Id,TimeLineId timeStart,TImeLineId timeEnd) {
  Json[] param = [];
  param.add(Id.toJson());
  param.add(timeStart.toJson());
  param.add(timeEnd.toJson());
  Json request  = createMessage("GetNodeTree", param);
  Json response = emitRequest(request);
  return ConvertToNodeList(response.get("result"));
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
NodeId MyappClient.NewLink (NodeId TargetNodeId) {
  Json[] param = [];
  param.add(TargetNodeId.toJson());
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
ContextJson MyappClient.GetContext (NodeId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetContext", param);
  Json response = emitRequest(request);
  return ConvertToContextJson(response.get("result"));
}
void MyappClient.Support (NodeId EvidenceNodeId,ProcessId Pid) {
  Json[] param = [];
  param.add(EvidenceNodeId.toJson());
  param.add(Pid.toJson());
  Json request  = createMessage("Support", param);
  Json response = emitRequest(request);
  return ConvertTovoid(response.get("result"));
}
void MyappClient.Rebuttal (NodeId EvidenceNodeId,ProcessId Pid,String Diagnosis) {
  Json[] param = [];
  param.add(EvidenceNodeId.toJson());
  param.add(Pid.toJson());
  param.add(Diagnosis.toJson());
  Json request  = createMessage("Rebuttal", param);
  Json response = emitRequest(request);
  return ConvertTovoid(response.get("result"));
}
TimeLineList MyappClient.GetAllTimeLine (ArgumentId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetAllTimeLine", param);
  Json response = emitRequest(request);
  return ConvertToTimeLineList(response.get("result"));
}
TimeLineList MyappClient.GetTimeLineByProcessId (ProcessId Id) {
  Json[] param = [];
  param.add(Id.toJson());
  Json request  = createMessage("GetTimeLineByProcessId", param);
  Json response = emitRequest(request);
  return ConvertToTimeLineList(response.get("result"));
}
TimeLineList MyappClient.GetTimeLine (TimeLineId timeEnd) {
  Json[] param = [];
  param.add(timeEnd.toJson());
  Json request  = createMessage("GetTimeLine", param);
  Json response = emitRequest(request);
  return ConvertToTimeLineList(response.get("result"));
}
Goal MyappClient.CreateGoal (String Description) {
  Json[] param = [];
  param.add(Description.toJson());
  Json request  = createMessage("CreateGoal", param);
  Json response = emitRequest(request);
  return ConvertToGoal(response.get("result"));
}
Evidence MyappClient.CreateEvidence (String Description) {
  Json[] param = [];
  param.add(Description.toJson());
  Json request  = createMessage("CreateEvidence", param);
  Json response = emitRequest(request);
  return ConvertToEvidence(response.get("result"));
}
Stategy MyappClient.CreateStategy (String Description) {
  Json[] param = [];
  param.add(Description.toJson());
  Json request  = createMessage("CreateStategy", param);
  Json response = emitRequest(request);
  return ConvertToStategy(response.get("result"));
}
Context MyappClient.CreateContext (String Description) {
  Json[] param = [];
  param.add(Description.toJson());
  Json request  = createMessage("CreateContext", param);
  Json response = emitRequest(request);
  return ConvertToContext(response.get("result"));
}
DscriptEvidence MyappClient.CreateDscriptEvidence (String script) {
  Json[] param = [];
  param.add(script.toJson());
  Json request  = createMessage("CreateDscriptEvidence", param);
  Json response = emitRequest(request);
  return ConvertToDscriptEvidence(response.get("result"));
}
DscriptContext MyappClient.CreateDscriptContext (String script) {
  Json[] param = [];
  param.add(script.toJson());
  Json request  = createMessage("CreateDscriptContext", param);
  Json response = emitRequest(request);
  return ConvertToDscriptContext(response.get("result"));
}
void MyappClient.AddChildren (Node child) {
  Json[] param = [];
  param.add(child.toJson());
  Json request  = createMessage("AddChildren", param);
  Json response = emitRequest(request);
  return ConvertTovoid(response.get("result"));
}
void MyappClient.AddHistory (Node OldNode) {
  Json[] param = [];
  param.add(OldNode.toJson());
  Json request  = createMessage("AddHistory", param);
  Json response = emitRequest(request);
  return ConvertTovoid(response.get("result"));
}
