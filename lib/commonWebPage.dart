import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonWebPages extends StatefulWidget{

  String url;
  String title;

  CommonWebPages({Key,key,@required this.url,@required this.title}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _webpages();
  }
}


class _webpages extends State<CommonWebPages>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url:widget.url,
      appBar:new AppBar(
        title: Text(widget.title)
      ),
      withZoom:true,
      withLocalStorage: true,
      withJavascript: true,
        hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: Text('正在加载。。。'),
        ),
      )
    );
  }



}
