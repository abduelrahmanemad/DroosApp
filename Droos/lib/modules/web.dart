import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/const.dart';

class WebViewScreen extends StatelessWidget{
  final String url;
  WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam',style: TextStyle(color: darkText),),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }

}