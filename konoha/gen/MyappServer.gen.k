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
  String Description;
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
class Strategy extends Node {
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
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
  CommiterName String = ConvetToCommiterName(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CloseProcessContext (Json request) {
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
  pId ProcessId = ConvetTopId(request.get("ProcessId"));
  Justification String = ConvetToJustification(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.MergeProcessContext (Json request) {
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
  targetProc ProcessId = ConvetTotargetProc(request.get("ProcessId"));
  mergeProc ProcessId = ConvetTomergeProc(request.get("ProcessId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetProcessContextIds (Json request) {
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
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
  Id NodeId = ConvetToId(request.get("NodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNodeTree (Json request) {
  Id NodeId = ConvetToId(request.get("NodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNodeId (Json request) {
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetNodeTreeWithTimeLine (Json request) {
  Id NodeId = ConvetToId(request.get("NodeId"));
  timeStart TimeLineId = ConvetTotimeStart(request.get("TimeLineId"));
  timeEnd TImeLineId = ConvetTotimeEnd(request.get("TImeLineId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Replace (Json request) {
  OldNodeId NodeId = ConvetToOldNodeId(request.get("NodeId"));
  NewNodeTree Node = ConvetToNewNodeTree(request.get("Node"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Add (Json request) {
  ParentNodeId NodeId = ConvetToParentNodeId(request.get("NodeId"));
  ChildNodeTree Node = ConvetToChildNodeTree(request.get("Node"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.DeleteLink (Json request) {
  ParentNodeId NodeId = ConvetToParentNodeId(request.get("NodeId"));
  TargetNode Node = ConvetToTargetNode(request.get("Node"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.NewLink (Json request) {
  ParentNodeId NodeId = ConvetToParentNodeId(request.get("NodeId"));
  TargetNodeId NodeId = ConvetToTargetNodeId(request.get("NodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Create (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindNodeFrom (Json request) {
  NodeIdSearchFrom NodeId = ConvetToNodeIdSearchFrom(request.get("NodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindNodeByDescription (Json request) {
  SearchText String = ConvetToSearchText(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.FindContextByProperty (Json request) {
  SearchText String = ConvetToSearchText(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetContext (Json request) {
  Id NodeId = ConvetToId(request.get("NodeId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Support (Json request) {
  EvidenceNodeId NodeId = ConvetToEvidenceNodeId(request.get("NodeId"));
  Pid ProcessId = ConvetToPid(request.get("ProcessId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.Rebuttal (Json request) {
  EvidenceNodeId NodeId = ConvetToEvidenceNodeId(request.get("NodeId"));
  Pid ProcessId = ConvetToPid(request.get("ProcessId"));
  Diagnosis String = ConvetToDiagnosis(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetAllTimeLine (Json request) {
  Id ArgumentId = ConvetToId(request.get("ArgumentId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetTimeLineByProcessId (Json request) {
  Id ProcessId = ConvetToId(request.get("ProcessId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.GetTimeLine (Json request) {
  timeBegin TimeLineId = ConvetTotimeBegin(request.get("TimeLineId"));
  timeEnd TimeLineId = ConvetTotimeEnd(request.get("TimeLineId"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateGoal (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateEvidence (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateStrategy (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateContext (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateDscriptEvidence (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  script String = ConvetToscript(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.CreateDscriptContext (Json request) {
  Description String = ConvetToDescription(request.get("String"));
  script String = ConvetToscript(request.get("String"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.AddChildren (Json request) {
  ThisNode Node = ConvetToThisNode(request.get("Node"));
  Child Node = ConvetToChild(request.get("Node"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
void MyappServer.AddHistory (Json request) {
  NewNode Node = ConvetToNewNode(request.get("Node"));
  OldNode Node = ConvetToOldNode(request.get("Node"));
  Json request = createMessage("FIXME");
  emitResponse(request);
}
