import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';


class Moviedes extends StatefulWidget{

  String id;
  String title;

  Moviedes({Key key, this.id, this.title}):super(key:key);

  @override
  State<StatefulWidget> createState() => _Moviestate(id:id,title:title);
}


class _Moviestate extends State<Moviedes> {

  String id;
  String title;
  Map movieDes;
  List move = [1,2,3];
  _Moviestate({Key key,this.id,this.title});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMoviesDes();
  }

  _getMoviesDes()async{
    String url = 'https://api.douban.com/v2/movie/subject/';
    try{
      http.Response response = await http.get('${url}${id}');
      var results = json.decode(response.body);
//      print(results);
      if(this.mounted){
        setState(() {
          movieDes = results;
        });
      }
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        title: Text('${title}'),
        centerTitle: true,
      ),
      body:renderDes(),
    );
  }


  Widget renderDes(){
    if(movieDes!=null){
      return moviesDeslayout();
    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }

  }

  Widget moviesDeslayout(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                movieDes['images']['large']
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                BlendMode.dstATop
            )
        )
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0,sigmaY: 10.0),
          child: ListView(
        children: <Widget>[
          Container(
            margin:EdgeInsets.only(bottom: 20,top: 15),
            alignment: Alignment.center,
            child: Image.network(
              movieDes['images']['large'],
              width: 300.0,
              height: 400.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin:EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex:1,
                    child: Text(
                        '电影名：',
                        textAlign: TextAlign.right
                    )),
                Expanded(
                    flex:3,
                    child: Text(movieDes['title'])
                )
              ],
            ),
          ),
          Container(
            margin:EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex:1,
                    child: Text(
                        '类型：',
                        textAlign: TextAlign.right
                    )),
                Expanded(
                    flex:3,
                    child: Text(movieDes['genres'].join('、'))
                )
              ],
            ),
          ),
          Container(
            margin:EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex:1,
                    child: Text(
                        '导演：',
                        textAlign: TextAlign.right
                    )),
                Expanded(
                    flex:3,
                    child: Text(movieDes['casts'][0]['name'])
                )
              ],
            ),
          ),
          Container(
            margin:EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex:1,
                    child: Text(
                        '国家：',
                        textAlign: TextAlign.right
                    )),
                Expanded(
                    flex:3,
                    child: Text(movieDes['countries'].join('/'))
                )
              ],
            ),
          ),
          Container(
            margin:EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex:1,
                    child: Text(
                        '豆瓣评分：',
                        textAlign: TextAlign.right
                    )),
                Expanded(
                    flex:3,
                    child: Text(
                      '${movieDes['rating']['average']}',
                      style: TextStyle(
                          color: Colors.red
                      ),
                    )
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      '概述：',
                      textAlign: TextAlign.right,

                    )),
                Expanded(
                    flex:6,
                    child: Text(movieDes['summary'])
                )
              ],
            ),
          )

        ],
      )
      )
    );

  }


}