import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';

import 'news.dart';
import 'eventBus.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState()=> _HomePageState();
}


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  String barcode = "";

  static dynamic myTabDataSources = [
    {
      'type':'toutiao',
      'des':'头条'
    },
    {
      'type':'tech',
      'des':'科技'
    },
    {
      'type':'auto',
      'des':'汽车'
    },
    {
      'type':'money',
      'des':'财经'
    },
    {
      'type':'sports',
      'des':'体育'
    },
    {
      'type':'dy',
      'des':'野史'
    },
    {
      'type':'war',
      'des':'军事'
    }
  ];

   List<Tab> myTabs = List.generate(myTabDataSources.length, (int index)=>
      Tab(
          child: Text(myTabDataSources[index]['des']),
      ),
  );

   List<Widget> tabViews = List.generate(myTabDataSources.length, (int index)=>
      Container(
        child: new News(type:myTabDataSources[index]['type'])
      )
   );

  TabController _tabController;

  @override
  void initState() {
    _tabController=new TabController(length: myTabs.length, vsync: this);
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: new AppBar(
            elevation:0,
            leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
              Scaffold.of(context).openDrawer();
            }),
            title: Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              height: 30,
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      Icons.search,
                      color: Colors.grey,
                  ),
                  Text(
                      '搜索要闻',
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 14
                      ),
                  )
                ],),
            ),
            actions: <Widget>[
              InkWell(
                  onTap:scan,
                  child:Column(children: <Widget>[
                  Expanded(child: IconButton(icon: Icon(Icons.scanner,color: Colors.white,), onPressed: null)),
                  Expanded(child: Text(
                  '扫码',
                  style: TextStyle(
                      fontSize: 13
                  ),
                ),)
              ],
              )
              )

            ],
          centerTitle: false,
          titleSpacing:0,
          bottom: TabBar(
            isScrollable: true,
            tabs: myTabs,
            controller: _tabController,
          )
        ),
        body:
        TabBarView(
                controller:_tabController,
                children: tabViews,
              ),

      );


  }

  Widget _typeGrid (){
    return GridView(
      primary: false,
      shrinkWrap: true,
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing:3.0,mainAxisSpacing:5.0,childAspectRatio: .7),
      children: <Widget>[
        Image.network(
            'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
            fit:BoxFit.cover
        ),
        Image.network(
            'http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',
            fit:BoxFit.cover
        ),
        Image.network(
            'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
            fit:BoxFit.cover
        ),
        Image.network(
            'http://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg',
            fit:BoxFit.cover
        ),
        new Image.network('http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',fit: BoxFit.cover),
        new Image.network('http://img5.mtime.cn/mt/2018/11/17/162028.94879602_135X190X4.jpg',fit: BoxFit.cover),
        new Image.network('http://img5.mtime.cn/mt/2018/11/19/165350.52237320_135X190X4.jpg',fit: BoxFit.cover),
        new Image.network('http://img5.mtime.cn/mt/2018/11/16/115256.24365160_180X260X4.jpg',fit: BoxFit.cover),
        new Image.network('http://img5.mtime.cn/mt/2018/11/20/141608.71613590_135X190X4.jpg',fit: BoxFit.cover),
      ],
    );
  }


  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}


