import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//有状态的widget
  class News extends StatefulWidget{
    String type;
    News({Key,key,@required this.type}):super(key:key);//构造函数
    @override
    State<StatefulWidget> createState() => new _NewRoute(type: type);

  }


  class _NewRoute extends State<News>{
    int count;
    String type;
    List<dynamic> newsArray = [];

    _NewRoute({this.type});


    @override
    void initState() {
      super.initState();
      getNews();
    }

    @override
  void dispose() {
    super.dispose();
  }

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
    @override
  void didUpdateWidget(News oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
//    print(newsArray[0]['picInfo'][0]['url']);
  }

    @override
    Widget build(BuildContext context) {
      return _renderItem();
    }

    Widget _buildItem( dynamic newsItem){
//              print(newsItem['picInfo'][0]['url']);
              return Card(
                child:Container(
                  child:Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                          padding: EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(newsItem['title']),
                              Container(
                                margin: EdgeInsets.only(top: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      "来源：${newsItem['source']}",
                                      style: TextStyle(
                                          color: Colors.deepOrange
                                      ),
                                    ),)

                                  ],
                                ),
                              )
                            ],
                          )
                      )
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(4.0),bottomRight: Radius.circular(4.0)),
                        child:SizedBox(
                          width: 150.0,
                          height: 100.0,
                          child: Image.network(newsItem['picInfo'].length>0?newsItem['picInfo'][0]['url']:'http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                      )
                    ],
                  ) ,
                )
              );

    }

    Future<List> getNews() async {
      String url ='https://www.apiopen.top/journalismApi';
      http.Response response = await http.get(url);
      var result = json.decode(response.body);
//          print(newsToJson['data']['tech'].runtimeType);
      if(this.mounted){
        this.setState((){
          newsArray.addAll(result['data'][type]);
        });
      }

    }

    Widget _renderItem(){
      if(newsArray.length!= 0){
        return ListView.builder(
            itemCount: newsArray.length,
            itemBuilder: (BuildContext context ,int index){
              return _buildItem(newsArray[index]);
            }
        );
      }else{
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  }
