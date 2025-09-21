import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("Notification"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          },
              icon: Icon(Icons.home))
        ],
      ),
      body: Column(
        children: [
          Text("ffff")
        ],
      ),
    );
  }
}
