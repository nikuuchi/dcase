Import("MiniKonoha.NameSpace");
Import("JavaScript.Array");
Import("JavaStyle.Object");
Import("Syntax.JavaStyleClass");
Load("../JsonRpc.k");
class MyappServer extends JsonRPCServer {}
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
void MyappServer.OpenProcessContext (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  String CommiterName = ConvetToString(request.get("CommiterName"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CloseProcessContext (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  ProcessId pId = ConvetToProcessId(request.get("pId"));
  String Justification = ConvetToString(request.get("Justification"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.MergeProcessContext (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  ProcessId mergeProc = ConvetToProcessId(request.get("mergeProc"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetProcessContextIds (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetRootArgument (Json request) {
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetArgumentsIdList (Json request) {
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
void MyappServer.GetNodeTree (Json request) {
  NodeId Id = ConvetToNodeId(request.get("Id"));
  TimeLineId timeStart = ConvetToTimeLineId(request.get("timeStart"));
  TImeLineId timeEnd = ConvetToTImeLineId(request.get("timeEnd"));
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
void MyappServer.GetContext (Json request) {
  NodeId Id = ConvetToNodeId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Support (Json request) {
  NodeId EvidenceNodeId = ConvetToNodeId(request.get("EvidenceNodeId"));
  ProcessId Pid = ConvetToProcessId(request.get("Pid"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Rebuttal (Json request) {
  NodeId EvidenceNodeId = ConvetToNodeId(request.get("EvidenceNodeId"));
  ProcessId Pid = ConvetToProcessId(request.get("Pid"));
  String Diagnosis = ConvetToString(request.get("Diagnosis"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetAllTimeLine (Json request) {
  ArgumentId Id = ConvetToArgumentId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetTimeLineByProcessId (Json request) {
  ProcessId Id = ConvetToProcessId(request.get("Id"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetTimeLine (Json request) {
  TimeLineId timeEnd = ConvetToTimeLineId(request.get("timeEnd"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
