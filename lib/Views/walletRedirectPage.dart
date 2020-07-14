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
    return "<html><head><title>Merchant Checkout Page</title></head>" +
        "<body><center><h1>Please do not refresh this page...</h1>" +
        "</center>" +
        "<form method='get' action='https://securegw-stage.paytm.in/order/process' name='f1'>" +
        "<input type='hidden' name='MID' value='mFqCiP95310391184453' >" +
        "<input type='hidden' name='WEBSITE' value='WEBSTAGING' >" +
        "<input type='hidden' name='CHANNEL_ID' value='WEB' >" +
        "<input type='hidden' name='INDUSTRY_TYPE_ID' value='Retail' >" +
        "<input type='hidden' name='ORDER_ID' value='ORDER_111' >" +
        "<input type='hidden' name='CUST_ID' value='Cust_111' >" +
        "<input type='hidden' name='TXN_AMOUNT' value='111' >" +
        "<input type='hidden' name='CALLBACK_URL' value='http://10.0.2.2:5000/connect-59a1f/us-central1/customFunctions/payment' >" +
        "<input type='hidden' name='EMAIL' value='Cust_111@gmail.com' ><input type='hidden' name='MOBILE_NO' value='1111111111' >" +
        "<input type='hidden' name='CHECKSUMHASH' value='qqPKF6e8TwE9Bb4cSogV0FFuQggCUJxTVgaR9wZGEdEdPURe3kefAFsk3CxSKqOjmpd72i9CejA4dTMK6jewelepD8E23njeddotGQALj10=' ></form>" +
        "<script type='text/javascript'>" +
        "document.f1.submit();" +
        "</script></body></html>";
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
