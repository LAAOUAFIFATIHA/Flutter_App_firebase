import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Analyse.dart';
import 'addImg.dart';
import 'loginPage.dart';
import 'notification.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Home", style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),)),
            backgroundColor: Colors.black38,
            actions: [
              //  the notification
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
              ),

              // log out
              IconButton(icon: Icon(Icons.logout),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginpage()),
                  );
                },
              ),
            ],
          ),

          body: Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: Card(
                  color: Colors.grey[200], // Light blue background
                  elevation: 5, // Adds a shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),


                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // SizedBox( height:  300),

                        Icon(
                          Icons.person, // Static icon
                          color: Colors.black38, // Change color if needed
                          size: 300, // Adjust size
                        ),
                        Text("welcome to assiste a ..."),

                        SizedBox(height: 30,),

                        Card(

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push( context, MaterialPageRoute(builder: (context) => Analyse()),
                              );
                            },
                            // decoration
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Button background color
                              foregroundColor: Colors.white, // Text color
                              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                              shape: BeveledRectangleBorder( // Rectangular shape
                                borderRadius: BorderRadius.circular(8),
                              ),// Button size (width & height)
                            ),

                            child: const Text("Analyse" , style: TextStyle(fontSize: 19 ,color: Colors.black54), ),

                          ),

                        ),

                        // add image

                        Card(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push( context, MaterialPageRoute(builder: (context) => Addimg()),
                              );
                            },
                            //   decorate the button
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Button background color
                              foregroundColor: Colors.white, // Text color
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                              shape: BeveledRectangleBorder( // Rectangular shape
                                borderRadius: BorderRadius.circular(8),
                              ),// Button size (width & height)
                            ),

                            child: const Text("Add image" ,  style: TextStyle(fontSize: 18 , color: Colors.black54), // Text size
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
