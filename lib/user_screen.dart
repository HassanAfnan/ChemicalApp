import 'package:chemical/about.dart';
import 'package:chemical/fcr.dart';
import 'package:chemical/history.dart';
import 'package:chemical/home.dart';
import 'package:chemical/login.dart';
import 'package:chemical/new_tank.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Screen"),
        actions: [
          IconButton(icon:Icon(Icons.exit_to_app) , onPressed:(){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("AS SAMMAK FARM"),
                content: Text("Do you want to logout?"),
                actions: [
                  FlatButton(
                    child: Text("Yes"),
                    onPressed:  () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('email');
                      prefs.remove('pic');
                      prefs.remove('name');
                      _signOut(context);
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed:  () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      color: Colors.indigo,
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(
                        )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("All Tanks",style: TextStyle(color: Colors.white,),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      color: Colors.indigo,
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Fcr()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("FCR",style: TextStyle(color: Colors.white,),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      color: Colors.indigo,
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("About",style: TextStyle(color: Colors.white,),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pop();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }
}
