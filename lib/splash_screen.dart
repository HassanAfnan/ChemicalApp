import 'dart:async';
import 'package:chemical/admin_dashboard.dart';
import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/login.dart';
import 'package:chemical/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          () => checkUser()
    );
  }
  Future<void> checkUser() async{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    var sessionEmail = prefs.getString('email');
    var sessionRole = prefs.getString('role');
    if(sessionEmail == null){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
    else if(sessionRole == "User"){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
    }
    else if(sessionRole == "Admin"){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
    }
    else{
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
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
                  child: Text("AS SAMMAK FARM",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 20),),
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
