import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/animations/table_page.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String,dynamic>> chemicals =[
    {
      'id': '1',
      'text':"Condition Not Good",
      'color': Colors.red,
      'task': "Task 1"
    },
    {
      'id': '2',
      'text':"Good Condition",
      'color': Colors.green.shade900,
      'task': "Task 2"
    },
    {
      'id': '3',
      'text':"Salt Level Very low",
      'color': Colors.brown.shade900,
      'task': "Task 3"
    },
    {
      'id': '4',
      'text':"PH Level Low Add Calcium Carbonate",
      'color': Colors.pink.shade200,
      'task': "Task 4"
    },
    {
      'id': '5',
      'text':"Good Condition",
      'color': Colors.green.shade900,
      'task': "Task 5"
    },
    {
      'id': '6',
      'text':"Bad Condition Please Solve Problem ASAP",
      'color': Colors.red,
      'task': "Task 6"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("images/background.png"),
             fit: BoxFit.cover,
           ),
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
             Expanded(
               child: GridView.builder(
                 primary: false,
                 //padding: const EdgeInsets.only(left: 30,right: 30,top: 15),
                 itemCount: chemicals.length,
                 itemBuilder:(cyx,index){
                   return WidgetAnimator(
                     Column(
                       children: [
                         GestureDetector(
                           onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => TableScreen()));
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
                                 backgroundColor: chemicals[index]["color"],
                                 child: Padding(
                                   padding: const EdgeInsets.all(3.0),
                                   child: Text(chemicals[index]["text"],style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                 ),
                               ),
                             ),
                           ),
                         ),
                         Text(chemicals[index]["task"],style: TextStyle(color: Colors.red),)
                       ],
                     )
                   );
                 },
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 10
                 ),
               ),
             )
           ],
         ),
       )
    );
  }
}
