import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/models/range_model.dart';
import 'package:chemical/models/tanks_model.dart';
import 'package:chemical/tank_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AdminTanks extends StatefulWidget {
  final List<RangeModel> resultList;

  const AdminTanks({Key key, this.resultList}) : super(key: key);
  @override
  _AdminTanksState createState() => _AdminTanksState();
}

class _AdminTanksState extends State<AdminTanks> {
  List<TankModel> tanks = [];

  getTanks(){
    Firestore.instance.collection("Tank").get().then((value){
      value.docs.forEach((element) {
        print(element.toString());
        setState(() {
          tanks.add(TankModel(
              element.id,
              double.parse(element["ammonia"].toString()),
              element["date"].toString(),
              element["email"],
              double.parse(element["feed"].toString()),
              double.parse(element["nitrate"].toString()),
              double.parse(element["nitrite"].toString()),
              double.parse(element["ph"].toString()),
              double.parse(element["tds"].toString()),
              double.parse(element["weight"].toString())));
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tanks'),
        ),
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Expanded(
                child: GridView.builder(
                  primary: false,
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                  itemCount: tanks.length,
                  itemBuilder:(cyx,index){
                    return WidgetAnimator(
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TankDetail(
                                  ammonia: tanks[index].ammonia,
                                  date: tanks[index].date,
                                  email: tanks[index].email,
                                  feed: tanks[index].feed,
                                  nitrate: tanks[index].nitrate,
                                  nitrite: tanks[index].nitrite,
                                  ph: tanks[index].ph,
                                  tds: tanks[index].tds,
                                  weight: tanks[index].weight,
                                )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.indigo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('Tank ${index + 1}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
