import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Entity {
//  "userId": 1,
//  "id": 1,
//  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"

  final int userId;
  final int id;
  final String title;
  final String body;

  //这个构造方法，需要加{}，否则factory方法会报错
  Entity({this.userId, this.id, this.title, this.body});

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"]);
  }
}

/**
 * 网络请求方法
 */
Future<Entity> fetchPost() async {
  String url = "https://jsonplaceholder.typicode.com/posts/1";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Entity.fromJson(json.decode(response.body));
  } else {
    throw Exception("http failure");
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Future<Entity> entity;

  @override
  void initState() {
    super.initState();
    entity = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "http",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("http")),
        body: Center(
          child: FutureBuilder<Entity>(
            future: entity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else {
                return Text("${snapshot.error}");
              }
              //默认返回一个加载圈
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
