import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/home.dart';
import 'package:chemical/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHidden = true;
  bool progress = false;
  String name;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50),
          WidgetAnimator(Image.asset("images/icon.png",height: 150,width: 150,)),
          SizedBox(height: 20,),
          WidgetAnimator(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("AS SAMMAK FARM",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 20),),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          WidgetAnimator(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0)), // set rounded corner radius
                ),
                child: TextField(
                  onChanged: (value){
                    name = value;
                  },
                  cursorColor: Colors.indigo,
                  style: TextStyle(
                      color:Colors.indigo
                  ),
                  decoration: InputDecoration(
                    prefixText: "     ",
                    hintStyle: TextStyle(
                        color: Colors.indigo
                    ),
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          WidgetAnimator(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0)), // set rounded corner radius
                ),
                child: TextField(
                  onChanged: (value){
                    email = value;
                  },
                  cursorColor: Colors.indigo,
                  style: TextStyle(
                      color:Colors.indigo
                  ),
                  decoration: InputDecoration(
                    prefixText: "     ",
                    hintStyle: TextStyle(
                        color: Colors.indigo
                    ),
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          WidgetAnimator(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0)), // set rounded corner radius
                ),
                child: TextField(
                  onChanged: (value){
                    password = value;
                  },
                  cursorColor: Colors.indigo,
                  style: TextStyle(
                      color: Colors.indigo
                  ),
                  obscureText: isHidden,
                  decoration: InputDecoration(
                      prefixText: "    ",
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                          color: Colors.indigo
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        color: Colors.indigo,
                        onPressed: (){
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                      )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          progress? Padding(
            padding: const EdgeInsets.only(left:180.0,right:180.0),
            child: CircularProgressIndicator(backgroundColor: Colors.indigo,),
          ) :WidgetAnimator(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                onPressed: (){
                  signUp();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          WidgetAnimator(
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      child: Text("Already have account? Sign In",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
  void signUp() async {
    if(name == null || email == null || password == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Warning"),
            content: Text("Fields cannot be empty"),
          )
      );
    }
    else{
      try{
        setState(() {
          progress = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        DocumentReference documentReference = Firestore.instance.collection("Users").document(email);
        Map<String, dynamic> users = {
          "Name": name,
          "Email": email,
          "Role": "User",
        };
        documentReference.setData(users).whenComplete(() {
          print("$email created") ;
        }).then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', name);
          prefs.setString('email', email);
          prefs.setString('role', "User");
        });
        setState(() {
          progress = false;
        });
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
      }catch(e){
        setState(() {
          progress = false;
        });
        print(e);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Warning"),
              content: Text("Invalid email and password"),
            )
        );
      }
    }
  }
}
