import 'package:flutter/material.dart';
import 'home.dart';
import 'assist.dart';
import 'mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云',
      theme: ThemeData(
        //应用的主题，蓝色主题
        primarySwatch: Colors.blue,
      ),
      //应用首页
      home: MyHomePage(title: '首页'),
      routes: {

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> pages = List();

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
        }
      ),
    );
  }
}



