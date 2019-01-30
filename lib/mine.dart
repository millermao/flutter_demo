import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'eventBus.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _LoginPage();
}

class _LoginPage extends State<MinePage> {

  Timer _timer; //倒计时的计数器
  int _seconds =60; //当前倒计时的秒数

  String _verifyStr = '获取验证码';

  StreamSubscription subscription;

  var subject = new BehaviorSubject<String>();


 //触发事件
  void _fireB(){
    eventBus.fire(new MyEvent('我是个人中心'));
  }

  //启动倒计时
  void _startTimer(){
    _timer = Timer.periodic(
       Duration(seconds: 1),
        (timer){
          if(_seconds==0){
            _cancelTimer();
            _seconds = 60;
            setState(() {

            });
            return;
          }
          _seconds--;
          _verifyStr ='已发送${_seconds}s';
          setState(() {

          });
          if(_seconds==0){
            _verifyStr='重新发送';
          }

        }
    );
  }

  //取消倒计时
  void _cancelTimer(){
    _timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(arrangeWidth());

//    subject.add("Item1");

     eventBus.on<MyEvent>().listen((MyEvent data){
      print('${data.text}');
    });

    subject.listen((item) => print("$item 第1个"));

    subject.add("Item1");
    subject.add("Item2");
    subject.add("Item3");
    subject.add("Item4");

    subject.listen((item) => print("$item 第2个"));

    subject.add("Item5");
    subject.add("Item6");
    subject.close();

  }

  arrangeWidth(){

    var screenWidth = window.physicalSize.width/window.devicePixelRatio;
    return (screenWidth-3*10)/4;
//  return 100.0;

  }

  //登陆按钮
  void _login(){
    print('正在登陆');

  }

  List<Widget> _buildGridTitleList(int count){
    return  List.generate(count, (int index)=>
        Container(
          color: Colors.lightBlue,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child:Image.network(
                    'http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',
                    fit: BoxFit.cover,
                  )
                ),
              Expanded(
                  flex: 1,
                  child: Text('你啊好你啊好',style: TextStyle(color: Colors.white,fontSize: 12.0),)
              )
            ],
          )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        title: Text('个人中心'),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

//          InkWell(
//            child: Text(
//              '$_verifyStr'
//            ),
//            onTap: (){
//              _startTimer();
//            },
//          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 50,
              margin: EdgeInsets.only(bottom: 15.0),
              child: Image.network('http://img5.mtime.cn/mt/2018/11/20/141608.71613590_135X190X4.jpg',fit: BoxFit.cover,),
            )
          ],
        ),

          Row(
            children: <Widget>[
              Expanded(
                flex:1,
                child: Container(
                  padding: EdgeInsets.only(right: 10.0),
                child: Text(
                    '用户名:',
                    textAlign: TextAlign.right,
                ),
              )),

              Expanded(
                  flex:4,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '请输入用户名'
                    ),
                  )

              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex:1,
                  child: Container(
                    padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                      '密码:',
                      textAlign: TextAlign.right,
                  ),
              )),
              Expanded(
                  flex:4,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: '请输入密码'
                    ),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20.0),
                child:RaisedButton(
                  onPressed: (){
                    _fireB();

                  },
                  child: Text('登陆'),
                ),
              )
            ],
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: <Widget>[
//              Container(
//                color: Colors.red,
//                width:100,
//                height: 100,
//                child: Text('一'),
//              ),
//              Container(
//                color: Colors.blue,
//                width:100,
//                height: 100,
//                child: Text('一'),
//              ),
//              Container(
//                color: Colors.amber,
//                width:100,
//                height: 100,
//                child: Text('一'),
//              )
//            ],
//          )

        ],
      )
    );
  }
  
  
}

