
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AssistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeAppState();
  }
}

class _MyHomeAppState extends State<AssistPage>{
  List subjects = [];
  String title = '';



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child:getBody(),
      )
    );
  }

  @override
  void initState() {
    loadData();
  }



  loadData() async {
    String loadRUL = "https://api.douban.com/v2/movie/in_theaters";
    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);
    if(this.mounted){
      setState(() {
        title = result['title'];
        print('title: $title');
        subjects = result['subjects'];
      });
    }

  }


  getItem(var subject) {
//    演员列表
    var avatars = List.generate(subject['casts'].length, (int index) =>
            Container(
                margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(!subject['casts'][index]['avatars']['medium'].isEmpty?subject['casts'][index]['avatars']['medium']:subject['images']['medium']),
                  radius: 15,
                )
            )

,
    );
    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0, height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    电影名称
                    Text(
                      subject['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      maxLines: 1,
                    ),
//                    豆瓣评分
                    Text(
                      '豆瓣评分：${subject['rating']['average']}',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
//                    类型
                    Text(
                        "类型：${subject['genres'].join("、")}"
                    ),
//                    导演
                    Text(
                        '导演：${subject['directors'][0]['name']}'
                    ),
//                    演员
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text('主演：'),
                          Row(
                            children: avatars,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
    return Card(
      child: row,
    );
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }


}