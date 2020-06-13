// import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/models/walletControler.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WalletRedirectPage extends StatefulWidget {
  final String amount;
  WalletRedirectPage({this.amount});
  @override
  _WalletRedirectPageState createState() => _WalletRedirectPageState();
}

class _WalletRedirectPageState extends State<WalletRedirectPage> {
  WebViewController _webcontroller;
  String _loadHTML() {
    return '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
    <center>
        <h1>Please do not refresh this page...</h1>
    </center>
    <form method="post" action="https://securegw-stage.paytm.in/order/process" name="f1"><input type='hidden' name='MID'
            value='mFqCiP95310391184453'><input type='hidden' name='WEBSITE' value='WEBSTAGING'><input type='hidden'
            name='CHANNEL_ID' value='WEB'><input type='hidden' name='INDUSTRY_TYPE_ID' value='Retail'><input
            type='hidden' name='ORDER_ID' value='ORDER_111'><input type='hidden' name='CUST_ID' value='${ORDER_DATA["custID"]}'><input
            type='hidden' name='TXN_AMOUNT' value='${widget.amount}'><input type='hidden' name='CALLBACK_URL'
            value='$PAYMENT_URL'><input type='hidden' name='EMAIL'
            value='${ORDER_DATA["custEmail"]}'><input type='hidden' name='MOBILE_NO' value='${ORDER_DATA["custPhone"]}'><input type='hidden'
            name='CHECKSUMHASH'
            value='2+F8djikxv+kpQgL3YYUUmdXAF4nsyAJoBisxnbZWUAr+JOPd8IhP2oPmIMJgHLWvgItZzVTgpc0cGcwF7dZP9Cf4E8tV+vlrbPTYRmj/gg='>
    </form>
    <script type="text/javascript">document.f1.submit();</script>
</body>
</html>
''';
// <ul>
// <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
// <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
// </ul>
    //  "<input type='hidden' name='custID' value='${ORDER_DATA["custID"]}'/>"+
    //  "<input type='hidden' name='amount' value='${widget.amount}'/>"+
    //  "<input type='hidden' name='custEmail' value='${ORDER_DATA["custEmail"]}'/>"+
    //  "<input type='hidden' name='custPhone' value='${ORDER_DATA["custPhone"]}'/>";
  }

  void dispose() {
    _webcontroller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebView(
        debuggingEnabled: false,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _webcontroller = controller;
          _webcontroller.loadUrl(
              Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                  .toString());
        },
      ),
    ));
  }
}
