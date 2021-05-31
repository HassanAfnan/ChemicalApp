import 'package:chemical/SignUp.dart';
import 'package:chemical/admin.dart';
import 'package:chemical/admin_dashboard.dart';
import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/ranges.dart';
import 'package:chemical/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  String _email, _password;
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 100),
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
                    _email = value;
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
                    _password = value;
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
          WidgetAnimator(
           progress ? Padding(
             padding: const EdgeInsets.only(left:180.0,right:180.0),
             child: CircularProgressIndicator(backgroundColor: Colors.indigo,),
           ) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                onPressed: (){
                   signIn();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
          SizedBox(height: 40,),
          WidgetAnimator(
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Container(
                      child: Text("Don't have account? Sign Up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
  void signIn() async {
    CircularProgressIndicator(backgroundColor: Colors.indigo,);
    final _auth = FirebaseAuth.instance;
    String role;
    if(_email == null || _password == null) {
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
        final fuser = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        DocumentReference documentReference = Firestore.instance.collection("Users").document(_email);
        documentReference.get().then((datasnapshot) async {
          String role = datasnapshot.data()["Role"];
          String name = datasnapshot.data()["Name"];
          if(role == "User" && fuser != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', _email);
            prefs.setString('name', name);
            prefs.setString('role','User');
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
          }
          else if(role == "Admin" && fuser != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', _email);
            prefs.setString('name', name);
            prefs.setString('role','Admin');
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
          }
          else{
            setState(() {
              progress = false;
            });
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Warning"),
                  content: Text("Invalid email and password"),
                )
            );
          }
        });
      }catch(e){
        setState(() {
          progress = false;
        });
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
