import 'package:flutter/material.dart';
import 'home.dart';
import 'assist.dart';
import 'mine.dart';
import 'package:event_bus/event_bus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyHomePageState();

}

class MyHomePageState extends State<MyApp> {
  int _currentIndex = 0;
  List<Widget> pages = List();

  EventBus eventBus = new EventBus();

  @override
  void initState() {
    pages
      ..add(HomePage())
      ..add(AssistPage())
      ..add(MinePage());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '娱乐细纹',
      theme: ThemeData(
        //应用的主题，蓝色主题
          primarySwatch:Colors.blue
      ),
      //应用首页
      home: myHome(),
      routes: {
      },
    );
  }


  Widget myHome() {
    return Scaffold(
      body:pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon:Icon(Icons.home),
              title:Text('首页'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              title: Text('助手'),
          ),
          BottomNavigationBarItem(icon:Icon(Icons.people),title: Text('我的'))
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
        drawer: new Drawer(
          child:ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color:Colors.yellow
                    ),
                    child: null
                )
            ],
          ),
        )
    );
  }
}



