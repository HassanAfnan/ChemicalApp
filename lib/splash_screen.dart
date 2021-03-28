import 'dart:async';

import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/home.dart';
import 'package:chemical/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
          (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
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
            SpinKitRipple(color: Colors.indigo,)
          ),
        ],
      ),
    );
  }
}
