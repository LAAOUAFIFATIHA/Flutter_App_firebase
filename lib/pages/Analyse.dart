import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'home.dart';

class Analyse extends StatefulWidget {
  const Analyse({super.key});

  @override
  State<Analyse> createState() => _AnalyseState();
}

class _AnalyseState extends State<Analyse> {
  List<Map<String, dynamic>> set_of_img = [];
  Map<int, Future<String>?> imageUrls = {};
  bool flag =true ;

  Future<String> getImageUrl(String path) async {
    try {
      String downloadURL = await FirebaseStorage.instance.ref("images/$path.png").getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error getting image URL: $e");
      return "";
    }
  }

  Future<List<Map<String, dynamic>>> fetchImages() async {
    try {
      CollectionReference imagesCollection = FirebaseFirestore.instance.collection('images');
      QuerySnapshot snapshot = await imagesCollection.get();

      return snapshot.docs.map((doc) {
        print("the data is  goooooood ");
        return {
          "name": doc["name"],
          "date": doc["date"],
        };
      }).toList();
    } catch (e) {
      print("Error fetching images: $e");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImages().then((images) {
      setState(() {
        set_of_img = images;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Analyse", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
            backgroundColor: Colors.black26,
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
              )
            ],
          ),

          body: (set_of_img.isEmpty)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: set_of_img.length,
            itemBuilder: (context, index) {

              var name = set_of_img[index]['name'] ?? 'Unknown';
              var date = set_of_img[index]['date'] ?? 'Unknown';

              print("ooooooooooooooooooooooooook");

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: "$name\n",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "Date: $date",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      flag? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            imageUrls[index] = getImageUrl('$name'+'$date');
                          });
                        },
                        child: const Text("Image"),
                      ):SizedBox(),

                      const SizedBox(height: 10),

                      if (imageUrls[index] != null)
                        FutureBuilder<String>(
                          future: imageUrls[index],
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text("Failed to load image");
                            } else {

                                flag = false ; ///// not functional OOH latterrrr

                              return Image.network(snapshot.data!);
                            }
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
