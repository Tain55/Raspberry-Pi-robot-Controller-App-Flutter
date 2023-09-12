import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'controle_robot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: callAbmulance(),
    );
  }
}

class callAbmulance extends StatefulWidget {
  const callAbmulance({Key? key}) : super(key: key);

  @override
  State<callAbmulance> createState() => _callAbmulanceState();
}

class _callAbmulanceState extends State<callAbmulance> {
  final CollectionReference _ambulance = FirebaseFirestore.instance.collection('box_one');

  //create text controller
  final TextEditingController _serverNumberController = TextEditingController();
  final TextEditingController _yourNumberController = TextEditingController();
  final TextEditingController _yourAddressController = TextEditingController();

  final TextEditingController _boxName = TextEditingController();

  final TextEditingController _boxOneHour = TextEditingController();
  final TextEditingController _boxOneMinute = TextEditingController();
  final TextEditingController _boxOneYn = TextEditingController();

  final TextEditingController _boxTwoHour = TextEditingController();
  final TextEditingController _boxTwoMinute = TextEditingController();
  final TextEditingController _boxTwoYn = TextEditingController();

  final TextEditingController _boxThreeHour = TextEditingController();
  final TextEditingController _boxThreeMinute = TextEditingController();
  final TextEditingController _boxThreeYn = TextEditingController();

  //update methode
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _serverNumberController.text = ['server number'] as String;
      _yourNumberController.text = ['my number'] as String;
      _yourAddressController.text = ['address'] as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _ambulance.snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text("Ambulance",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red),)),

                          Row(
                            children: [
                              Text(
                                "Information",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                              IconButton(
                                  onPressed: () => {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.grey,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _yourAddressController,
                                                  decoration: const InputDecoration(labelText: 'Your Address'),
                                                ),
                                                TextField(
                                                  keyboardType:
                                                  const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _serverNumberController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Server number',
                                                  ),
                                                ),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _yourNumberController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Hospital number',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Update'),
                                                  onPressed: () async {
                                                    final String address = _yourAddressController.text;
                                                    final int?serverNumber = int.tryParse(_yourNumberController.text);
                                                    final int?hospitalNumber = int.tryParse(_serverNumberController.text);
                                                    //if () {
                                                    await _ambulance.doc(documentSnapshot!.id).update({"ambumyaddress": address,"ambuhospitalnumber": hospitalNumber, "ambumyserver ": serverNumber});

                                                    _serverNumberController.text = '';
                                                    _yourNumberController.text = '';
                                                    _yourAddressController.text = '';
                                                    Navigator.of(context).pop();
                                                  }
                                                  ,
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                          const Divider(
                            thickness: .5,
                            color: Colors.black54,
                          ),
                          Row(
                            children: [
                              Text(
                                "Ambulance Number: ",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(documentSnapshot['ambuhospitalnumber'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Server number: ",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(documentSnapshot['ambumyserver'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Address: ",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(documentSnapshot['ambumyaddress'].toString())
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                              ],
                            ),
                          ),

                          SizedBox(height: 30,),

                          Center(child: Text("Medicine",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),)),

                          //For medicine
                          Row(
                            children: [
                              Text("Patient Name: ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.orange),),
                              Text(documentSnapshot['patientname'].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                              IconButton(
                                  onPressed: () => {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.grey,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _boxName,
                                                  decoration: const InputDecoration(labelText: 'Patient name: '),
                                                ),

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Update'),
                                                  onPressed: () async {
                                                    final String patient = _boxName.text;
                                                    //if () {
                                                    await _ambulance.doc(documentSnapshot!.id).update({"patientname": patient});

                                                    _boxName.text = '';
                                                    Navigator.of(context).pop();
                                                  }
                                                  ,
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "Box 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                              IconButton(
                                  onPressed: () => {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.grey,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _boxOneYn,
                                                  decoration: const InputDecoration(labelText: 'Want it active?(y/n)'),
                                                ),
                                                Text("Time should be 24 hour",style: TextStyle(color: Colors.red,fontSize: 15),),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxOneHour,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Hour',
                                                  ),
                                                ),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxOneMinute,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Minute',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Update'),
                                                  onPressed: () async {
                                                    final String oneYn = _boxOneYn.text;
                                                    final int?oneHour = int.tryParse(_boxOneHour.text);
                                                    final int?oneMinute = int.tryParse(_boxOneMinute.text);
                                                    //if () {
                                                    await _ambulance.doc(documentSnapshot!.id).update({"boxoneyn":oneYn ,"boxonehour": oneHour, "boxoneminute": oneMinute});

                                                    _boxOneHour.text = '';
                                                    _boxOneMinute.text = '';
                                                    _boxOneYn.text = '';
                                                    Navigator.of(context).pop();
                                                  }
                                                  ,
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                          const Divider(
                            thickness: .5,
                            color: Colors.black54,
                          ),

                          Row(
                            children: [
                              Text("Box one time: ",style: TextStyle( fontWeight: FontWeight.bold)),
                              Text(documentSnapshot['boxonehour'].toString()+":"+documentSnapshot['boxoneminute'].toString())
                            ],
                          ),
                          Row(children: [
                            Text("Box one y/n: ",style: TextStyle( fontWeight: FontWeight.bold)),
                            Text(documentSnapshot['boxoneyn'])
                          ],),

                          SizedBox(height: 20,),


                          Row(
                            children: [
                              Text(
                                "Box 2",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                              IconButton(
                                  onPressed: () => {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.grey,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _boxTwoYn,
                                                  decoration: const InputDecoration(labelText: 'Want it active?(y/n)'),
                                                ),
                                                Text("Time should be 24 hour",style: TextStyle(color: Colors.red,fontSize: 15),),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxTwoHour,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Hour',
                                                  ),
                                                ),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxTwoMinute,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Minute',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Update'),
                                                  onPressed: () async {
                                                    final String twoYn = _boxTwoYn.text;
                                                    final int?twoHour = int.tryParse(_boxTwoHour.text);
                                                    final int?twoMinute = int.tryParse(_boxTwoMinute.text);
                                                    //if () {
                                                    await _ambulance.doc(documentSnapshot!.id).update({"boxtwoyn":twoYn ,"boxtwohour": twoHour, "boxtwominute": twoMinute});

                                                    _boxTwoHour.text = '';
                                                    _boxTwoMinute.text = '';
                                                    _boxTwoYn.text = '';
                                                    Navigator.of(context).pop();
                                                  }
                                                  ,
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                          const Divider(
                            thickness: .5,
                            color: Colors.black54,
                          ),
                          Row(
                            children: [
                              Text("Box two time: ",style: TextStyle( fontWeight: FontWeight.bold)),
                              Text(documentSnapshot['boxtwohour'].toString()+":"+documentSnapshot['boxtwominute'].toString())
                            ],
                          ),
                          Row(children: [
                            Text("Box two y/n: ",style: TextStyle( fontWeight: FontWeight.bold)),
                            Text(documentSnapshot['boxtwoyn'])
                          ],),

                          SizedBox(height: 20,),


                          Row(
                            children: [
                              Text(
                                "Box 3",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                              IconButton(
                                  onPressed: () => {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.green,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: _boxThreeYn,
                                                  decoration: const InputDecoration(labelText: 'Want it active?(y/n)'),
                                                ),
                                                Text("Time should be 24 hour",style: TextStyle(color: Colors.red,fontSize: 15),),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxThreeHour,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Hour',
                                                  ),
                                                ),
                                                TextField(
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                  controller: _boxThreeMinute,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Minute',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Update'),
                                                  onPressed: () async {
                                                    final String threeYn = _boxThreeYn.text;
                                                    final int?threeHour = int.tryParse(_boxThreeHour.text);
                                                    final int?threeMinute = int.tryParse(_boxThreeMinute.text);
                                                    //if () {
                                                    await _ambulance.doc(documentSnapshot!.id).update({"boxthreeyn":threeYn ,"boxthreehour": threeHour, "boxthreeminute": threeMinute});

                                                    _boxThreeHour.text = '';
                                                    _boxThreeMinute.text = '';
                                                    _boxThreeYn.text = '';
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      )
                                  },
                                  icon: const Icon(Icons.edit)
                              )
                            ],
                          ),
                          const Divider(
                            thickness: .5,
                            color: Colors.black54,
                          ),
                          Row(
                            children: [
                              Text("Box three time: ",style: TextStyle( fontWeight: FontWeight.bold)),
                              Text(documentSnapshot['boxthreehour'].toString()+":"+documentSnapshot['boxthreeminute'].toString())
                            ],
                          ),
                          Row(children: [
                            Text("Box three y/n: ",style: TextStyle( fontWeight: FontWeight.bold)),
                            Text(documentSnapshot['boxthreeyn'])
                          ],),

                          SizedBox(height: 30,),


                          //button of controle
                          GestureDetector(
                            //ontap
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> controleRobot()));
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Colors.red,
                              child: Center(child: Text("Control robot",style: TextStyle(fontSize: 40, color: Colors.white),)),
                            ),
                          ),

                          SizedBox(height: 20,),

                          GestureDetector(
                            //ontap
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> controleRobot()));
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Center(child: Text("Count Exercise",style: TextStyle(fontSize: 40, color: Colors.white),)),
                            ),
                          ),

                          SizedBox(height: 20,),

                          GestureDetector(
                            //ontap
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> controleRobot()));
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Colors.green,
                              child: Center(child: Text("Play Game",style: TextStyle(fontSize: 40, color: Colors.white),)),
                            ),
                          ),

                          SizedBox(height: 20,),

                        ],
                      ),
                    );
                  }
                );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
    );
  }
}
