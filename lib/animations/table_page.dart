import 'package:chemical/animations/bottomAnimation.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: WidgetAnimator(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  child: Table(
                      border: TableBorder.all(), // Allows to add a border decoration around your table
                      children: [
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Head',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Remarks',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('PH',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('TDS',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Temperature',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ammonia',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Nitrite',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Nitrate',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                        ]),
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
