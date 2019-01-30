import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_refresh/flutter_refresh.dart';
import 'commonWebPage.dart';

//有状态的widget
  class News extends StatefulWidget{
    String type;
    News({Key,key,@required this.type}):super(key:key);//构造函数
    @override
    State<StatefulWidget> createState() => new _NewRoute(type: type);

  }


  class _NewRoute extends State<News> with AutomaticKeepAliveClientMixin{
    int count;
    String type;
    List<dynamic> newsArray = [];
    ScrollController _scrollController = new ScrollController();


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

    @override
    // TODO: implement wantKeepAlive
    bool get wantKeepAlive => true;



    Widget _buildItem( dynamic newsItem){
//              print(newsItem['picInfo'][0]['url']);
              return InkWell(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new CommonWebPages(
                      url:newsItem['link'],
                      title: newsItem['title'],
                      )
                  ));
                },
                child: Card(
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
                ),
              );
                


    }

     getNews() async {
      String url ='https://www.apiopen.top/journalismApi';

      try{
        http.Response response = await http.get(url);
        var result = json.decode(response.body);
        print(result);
        if(this.mounted){
          this.setState((){
            newsArray = result['data'][type];
          });
        }
      }catch(e){
        print('服务端错误');
      }



    }

    //下拉刷新加载
    Future<Null> onHeaderRefresh(){
      return new Future.delayed(Duration(seconds: 2),(){
        setState(() {
          getNews();
        });

      });
    }

    Future<Null> _loadRefresh(){
        return Future.delayed(Duration(seconds: 2),(){
          setState(() {
            getNews();
          });
        });
    }



    Widget _renderItem(){
      if(newsArray.length!= 0){
//        return RefreshIndicator(
//            child: ListView.builder(
//                itemCount: newsArray.length,
//                itemBuilder: (BuildContext context ,int index){
//                return _buildItem(newsArray[index]);
//            }
//          ),
//            onRefresh: _loadRefresh //刷新回掉
//        );
        return Refresh(
          onHeaderRefresh: onHeaderRefresh,
          child: ListView.builder(
              itemCount: newsArray.length,
              itemBuilder: (BuildContext context ,int index){
                return _buildItem(newsArray[index]);
              }
          ) ,
        );

      }else{
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  }
