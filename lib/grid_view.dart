import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "gridView";

    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(50, (index) {
            return Center(
                child: Text("Item $index",
                    style: Theme.of(context).textTheme.headline));
          }),
        ),
      ),
    );
  }
}
