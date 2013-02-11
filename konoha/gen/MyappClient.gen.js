var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
}
var MyappClient = (function() {
  function MyappClient() {}
  return MyappClient;
})(JsonRPCClient);
var Node = (function() {
  function Node() {
    _super.call(this);
    this.ThisNodeId = 0;
    this.PrevNodeId = 0;
    this.BelongedArgumentId = 0;
    this.Children = undefined;
    this.Attributes = undefined;
    this.NextNodeId = 0;
  }
  return Node;
})();
var TimeLine = (function() {
  function TimeLine() {
    _super.call(this);
    this.UnixTime = 0;
    this.OldNodeId = undefined;
    this.NewNodeId = undefined;
  }
  return TimeLine;
})();
var Goal = (function(Node) {
  function Goal() {
    _super.call(this);
  }
  __extends.call(Goal, this);
  return Goal;
})(Node);
var Evidence = (function(Node) {
  function Evidence() {
    _super.call(this);
  }
  __extends.call(Evidence, this);
  return Evidence;
})(Node);
var Stategy = (function(Node) {
  function Stategy() {
    _super.call(this);
  }
  __extends.call(Stategy, this);
  return Stategy;
})(Node);
var Context = (function(Node) {
  function Context() {
    _super.call(this);
  }
  __extends.call(Context, this);
  return Context;
})(Node);
var DscriptEvidence = (function(Evidence) {
  function DscriptEvidence() {
    _super.call(this);
    this.script = "";
  }
  __extends.call(DscriptEvidence, this);
  return DscriptEvidence;
})(Evidence);
var DscriptContext = (function(Context) {
  function DscriptContext() {
    _super.call(this);
    this.script = "";
  }
  __extends.call(DscriptContext, this);
  return DscriptContext;
})(Context);
var TopGoal = (function(Goal) {
  function TopGoal() {
    _super.call(this);
    this.TopGoalNodeId = 0;
    this.ThisArgumentId = 0;
  }
  __extends.call(TopGoal, this);
  return TopGoal;
})(Goal);
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
