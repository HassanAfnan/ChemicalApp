import 'package:chemical/admin.dart';
import 'package:chemical/admin_history.dart';
import 'package:chemical/all_tanks.dart';
import 'package:chemical/all_users.dart';
import 'package:chemical/login.dart';
import 'package:chemical/new_tank.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Dashboard"),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("Add Range",style: TextStyle(color: Colors.white,),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
            Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewTanks()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("Add Tanks",style: TextStyle(color: Colors.white,),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
            Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllUsers()));
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
            Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHistory()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("History",style: TextStyle(color: Colors.white,),
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
