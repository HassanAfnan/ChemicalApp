import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text("About"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Your About Us page should be:",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Informative. It doesn’t always have to tell your whole story, but it should at least",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
          Text("provide people with an idea of .",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Contain social proof, testimonials, and some personal information that visitors can",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
          Text("relate to, such as education, family, etc.",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Useful.",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Engaging.",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Easy to navigate.",style: TextStyle(fontWeight: FontWeight.bold)),
          Text("• Accessible on any device.",style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
