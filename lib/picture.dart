import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PictureInfo {
//  {
//  "albumId": 1,
//  "id": 1,
//  "title": "accusamus beatae ad facilis cum similique qui sunt",
//  "url": "https://via.placeholder.com/600/92c952",
//  "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//  }

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PictureInfo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory PictureInfo.fromJson(Map<String, dynamic> json) {
    PictureInfo pictureInfo = PictureInfo(
        albumId: json["albumId"] as int,
        id: json["id"] as int,
        title: json["title"] as String,
        url: json["url"] as String,
        thumbnailUrl: json["thumbnailUrl"] as String);
    return pictureInfo;
  }
}

List<PictureInfo> parsePic(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<PictureInfo>((json) => PictureInfo.fromJson(json)).toList();
}

Future<List<PictureInfo>> requestPic(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/photos');
  return compute(parsePic, response.body);
}


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "picture",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("picture")),
      body: FutureBuilder<List<PictureInfo>>(
        future: requestPic(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PictureList(pics: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PictureList extends StatelessWidget {
  final List<PictureInfo> pics;

  PictureList({Key key, this.pics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: pics.length,
      itemBuilder: (context, index) {
        return Image.network(pics[index].thumbnailUrl);
      },
    );
  }
}
