import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/home.dart';
import 'package:chemical/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHidden = true;
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
                  child: Text("Chemical App",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 20),),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
}
