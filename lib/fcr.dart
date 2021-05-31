import 'package:chemical/add_fcr.dart';
import 'package:flutter/material.dart';

class Fcr extends StatefulWidget {
  const Fcr({Key key}) : super(key: key);

  @override
  _FcrState createState() => _FcrState();
}

class _FcrState extends State<Fcr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FCR Page"),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddFCR()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("Add Value",style: TextStyle(color: Colors.white,),
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80,bottom: 80),
                        child: Text("All FCR",style: TextStyle(color: Colors.white,),
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
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
}
