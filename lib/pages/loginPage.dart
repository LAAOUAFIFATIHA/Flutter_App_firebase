import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

final _formKey = GlobalKey<FormState>();

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void dilog_error(){
  //    show a dialog msg
  }

  void log( String name , String pass ) async{
  //   check if the name and password are correct
    CollectionReference login_ref = FirebaseFirestore.instance.collection('LOGIN');
    QuerySnapshot snapshot = await login_ref.get();
    // print('errrrrrrrrrrrrrrrrrrrrrrer here'+snapshot.docs.isEmpty.toString());

    bool isLoggedIn = false;

    // GET ALL TEH DOCUMMENT FROM THE DATABASE
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print("the content iss hhhhhhh"+data['name']);
      if (data['name'] == name && data['password'] == pass) {
        isLoggedIn = true;
        break;
      }
    }
    //    if correct log into the home page
    if (isLoggedIn) {
      print("Login successful! name: $name");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
    } else {
      print("Incorrect username or password.");
      // Show error message to the user
    }


  //   test
    print("name: $name , pass: $pass");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Center(child: Text("Login page" , style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
        
                    Icon(Icons.security , size: 200,color: Colors.black54, ),
        
                    SizedBox(height: 20,),
        
        
                    TextFormField(
                      controller: _userNamecontroller, // Use the controller to manage text input
                      decoration: InputDecoration(
                          labelText: 'User name',
                          border: OutlineInputBorder( ),
                          prefixIcon: Icon(Icons.person , color: Colors.blueAccent,),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
                      ),
                      validator: (_userNamecontroller) {
                        if (_userNamecontroller == null || _userNamecontroller.isEmpty) {
                          return "Enter your user name please";
                        }
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(_userNamecontroller)) {
                      return "Enter a valid username (letters only)";
                      }
                        return null; // Return null if the input is valid
                      },
                    ),
        
                    SizedBox(height: 50,),
        
                    TextFormField (
                      controller: _passwordcontroller, // Use the controller to manage text input
                      decoration: InputDecoration(
                          labelText: 'password',
                          border: OutlineInputBorder( ),
                          prefixIcon: Icon(Icons.lock , color: Colors.blueAccent,),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your password please";
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
        
                   // const  Row(
                   //    mainAxisAlignment: MainAxisAlignment.end,
                   //    children: [
                   //      Text(
                   //        "Forget password",
                   //        style: TextStyle(
                   //          fontSize: 16,
                   //          fontWeight: FontWeight.w500,
                   //          color: Colors.blueAccent,
                   //          decoration: TextDecoration.underline,
                   //        ),
                   //      ),
                   //    ],
                   //  ),
        
                    SizedBox(height: 20,),
        
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          log(_userNamecontroller.text , _passwordcontroller.text );
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                      },
                      child: Text("Login" , style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: BeveledRectangleBorder( // Rectangular shape
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 125.0), // Padding inside the button
                      ),
                    ),
        
                    SizedBox(height: 50,),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("welcome" , style: TextStyle( fontWeight: FontWeight.bold  ,color: Colors.blue),))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
