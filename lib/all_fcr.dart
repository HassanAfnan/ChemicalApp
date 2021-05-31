import 'package:flutter/material.dart';

class AllFCR extends StatefulWidget {
  const AllFCR({Key key}) : super(key: key);

  @override
  _AllFCRState createState() => _AllFCRState();
}

class _AllFCRState extends State<AllFCR> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getFCRS(){
    // Firestore.instance.collection("Range").where("title",isEqualTo: "FCR").get().then((value3){
    //   value3.docs.forEach((element) {
    //     if((widget.feed/widget.weight) >= double.parse(element["value1"].toString()) && (widget.feed/widget.weight) <= double.parse(element["value2"].toString())){
    //       setState(() {
    //         fcr = element["result"];
    //       });
    //     }
    //     else{
    //       setState(() {
    //         fcr = "Condition not good";
    //       });
    //     }
    //   });
    // }).whenComplete((){
      // Firestore.instance.collection("Range").where("title",isEqualTo: "nitrite").get().then((value3){
      //   value3.docs.forEach((element) {
      //     if((widget.nitrite) >= double.parse(element["value1"].toString()) && (widget.nitrite) <= double.parse(element["value2"].toString())){
      //       setState(() {
      //         nitrite = element["result"];
      //       });
      //     }
      //     else{
      //       setState(() {
      //         nitrite = "Condition not good";
      //       });
      //     }
      //   });
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
