import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class controleRobot extends StatefulWidget {
  const controleRobot({Key? key}) : super(key: key);

  @override
  State<controleRobot> createState() => _controleRobotState();
}

class _controleRobotState extends State<controleRobot> {
  double _speed = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            SizedBox(height: 380,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapDown: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'f'});
                  },
                  onTapUp: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'z'});
                  },

                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: Icon(Icons.arrow_upward,size: 50,color: Colors.white,),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapDown: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'l'});
                  },
                  onTapUp: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'z'});
                  },

                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: Icon(Icons.arrow_back,size: 50,color: Colors.white,),
                  ),
                ),

                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.black),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Speed",style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
                          Text(_speed.toInt().toString(),
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),),
                        ],
                      )),
                ),

                GestureDetector(
                  onTapDown: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'r'});
                  },
                  onTapUp: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'z'});
                  },

                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: Icon(Icons.arrow_forward,size: 50,color: Colors.white,),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapDown: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'b'});
                  },
                  onTapUp: (_){
                    FirebaseFirestore.instance
                        .collection('controlerobot')
                        .doc('FCJqicxkKUEzvGDs8B6z')
                        .update({'up': 'z'});
                  },

                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: Icon(Icons.arrow_downward,size: 50,color: Colors.white,),
                  ),
                )
              ],
            ),
            Slider(
              value: _speed,
              onChanged: (value){
                setState(() {
                  FirebaseFirestore.instance
                      .collection('controlerobot')
                      .doc('FCJqicxkKUEzvGDs8B6z')
                      .update({'speed': value});
                  _speed = value;
                  }
                );
              },
              min: 40,
              max: 100,
              divisions: 60,
              activeColor: Colors.blue,
              inactiveColor: Colors.orange,


            )
          ],
        ),
      ),
    );
  }
}
