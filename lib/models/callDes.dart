class CallDes {
  final String callId;
  final String modelNo;
  final String issues;
  CallDes({this.callId,this.modelNo,this.issues});

}
class CallHistoryList{
  List<CallDes> callList;
  CallHistoryList({this.callList});
}