import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = List<ListItem>.generate(
        100,
        (index) => index % 6 == 0
            ? HeadItem("head $index")
            : MessageItem("sender $index", "body $index"));

    return new MaterialApp(
      title: "MultiListView",
      home: Scaffold(
          appBar: AppBar(title: Text("MultiListView")),
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is HeadItem) {
                  return ListTile(
                      title: Text(item.head,
                          style: Theme.of(context).textTheme.headline));
                } else if (item is MessageItem) {
                  return ListTile(
                    title: Text(item.sender),
                    subtitle: Text(item.body),
                  );
                }
              })),
    );
  }
}

abstract class ListItem {}

class HeadItem implements ListItem {
  final String head;

  HeadItem(this.head);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
