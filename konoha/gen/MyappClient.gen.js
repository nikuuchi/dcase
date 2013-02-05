var MyappClient = (function() {
  function MyappClient() {}
  MyappClient.prototype = JsonRPCClient;
  return MyappClient;
})();
var Node = (function() {
  function Node() {}
  Node.ThisNodeId = undefined;
  Node.PrevNodeId = undefined;
  Node.BelongedArgumentId = undefined;
  Node.Children = undefined;
  Node.Attributes = undefined;
  Node.NextNodeId = undefined;
  return Node;
})();
var TimeLine = (function() {
  function TimeLine() {}
  TimeLine.UnixTime = undefined;
  TimeLine.OldNodeId = undefined;
  TimeLine.NewNodeId = undefined;
  return TimeLine;
})();
var Goal = (function() {
  function Goal() {}
  Goal.prototype = Node;
  return Goal;
})();
var Evidence = (function() {
  function Evidence() {}
  Evidence.prototype = Node;
  return Evidence;
})();
var Stategy = (function() {
  function Stategy() {}
  Stategy.prototype = Node;
  return Stategy;
})();
var Context = (function() {
  function Context() {}
  Context.prototype = Node;
  return Context;
})();
var DscriptEvidence = (function() {
  function DscriptEvidence() {}
  DscriptEvidence.prototype = Evidence;
  DscriptEvidence.script = undefined;
  return DscriptEvidence;
})();
var DscriptContext = (function() {
  function DscriptContext() {}
  DscriptContext.prototype = Context;
  DscriptContext.script = undefined;
  return DscriptContext;
})();
var TopGoal = (function() {
  function TopGoal() {}
  TopGoal.prototype = Goal;
  TopGoal.TopGoalNodeId = undefined;
  TopGoal.ThisArgumentId = undefined;
  return TopGoal;
})();
MyappClient.OpenProcessContext = function(Id,CommiterName) {
  var param    = [Id,CommiterName];
  var request  = createMessage("OpenProcessContext", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.CloseProcessContext = function(Id,pId,Justification) {
  var param    = [Id,pId,Justification];
  var request  = createMessage("CloseProcessContext", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.MergeProcessContext = function(Id,mergeProc) {
  var param    = [Id,mergeProc];
  var request  = createMessage("MergeProcessContext", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetProcessContextIds = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetProcessContextIds", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetRootArgument = function() {
  var param    = [];
  var request  = createMessage("GetRootArgument", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetArgumentsIdList = function() {
  var param    = [];
  var request  = createMessage("GetArgumentsIdList", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetNode = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetNode", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetNodeTree = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetNodeTree", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetNodeId = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetNodeId", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetNodeTree = function(Id,timeStart,timeEnd) {
  var param    = [Id,timeStart,timeEnd];
  var request  = createMessage("GetNodeTree", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.Replace = function(OldNodeId,NewNodeTree) {
  var param    = [OldNodeId,NewNodeTree];
  var request  = createMessage("Replace", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.Add = function(ParentNodeId,ChildNodeTree) {
  var param    = [ParentNodeId,ChildNodeTree];
  var request  = createMessage("Add", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.DeleteLink = function(ParentNodeId,TargetNode) {
  var param    = [ParentNodeId,TargetNode];
  var request  = createMessage("DeleteLink", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.NewLink = function(ParentNodeId) {
  var param    = [ParentNodeId];
  var request  = createMessage("NewLink", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.Create = function(Description) {
  var param    = [Description];
  var request  = createMessage("Create", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.FindNodeFrom = function(NodeIdSearchFrom) {
  var param    = [NodeIdSearchFrom];
  var request  = createMessage("FindNodeFrom", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.FindNodeByDescription = function(SearchText) {
  var param    = [SearchText];
  var request  = createMessage("FindNodeByDescription", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.FindContextByProperty = function(SearchText) {
  var param    = [SearchText];
  var request  = createMessage("FindContextByProperty", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetContext = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetContext", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.Support = function(EvidenceNodeId,Pid) {
  var param    = [EvidenceNodeId,Pid];
  var request  = createMessage("Support", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.Rebuttal = function(EvidenceNodeId,Pid,Diagnosis) {
  var param    = [EvidenceNodeId,Pid,Diagnosis];
  var request  = createMessage("Rebuttal", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetAllTimeLine = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetAllTimeLine", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetTimeLineByProcessId = function(Id) {
  var param    = [Id];
  var request  = createMessage("GetTimeLineByProcessId", param);
  var response = emitRequest(request);
  return response.result;
}
MyappClient.GetTimeLine = function(timeEnd) {
  var param    = [timeEnd];
  var request  = createMessage("GetTimeLine", param);
  var response = emitRequest(request);
  return response.result;
}
