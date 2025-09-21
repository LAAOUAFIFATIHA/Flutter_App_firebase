import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';

class Addimg extends StatefulWidget {
  const Addimg({super.key});

  @override
  State<Addimg> createState() => _AddimgState();
}

class _AddimgState extends State<Addimg> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(
              title: Center(child: Text("add image", style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),)),
              backgroundColor: Colors.black26,
              actions: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => Home()));
                  },
                )
              ]

          ),
          body: Center(
            child: Text("add some thing to the data base"),
          ),
        )
    );
  }
}
