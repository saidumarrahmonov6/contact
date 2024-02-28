import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact/malumot.dart';
import 'package:contact/royxatdan_otish.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'malumot.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference login = FirebaseFirestore.instance.collection("login");

  TextEditingController logintxt = TextEditingController();
  TextEditingController passwordtxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: StreamBuilder(
        stream: login.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context , int index){
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: logintxt,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), label: Text("Login")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: passwordtxt,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), label: Text("Password")),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
                            if(passwordtxt.text == document['password'] && document['login'] == logintxt.text){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> MalumotApp()));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tayyor")));
                              print("Kirildi");
                              passwordtxt.clear();
                              logintxt.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Xato")));
                              print('xatolik');
                            }
                          },
                          child: Text("Kirish"),
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Container(
                      //   child: MaterialButton(
                      //     onPressed: (){
                      //       Navigator.push(context, MaterialPageRoute(builder: (_)=> SingUp()));
                      //     },
                      //     child: Text("Ro'yxatdan o'tish"),
                      //   ),
                      // ),
                    ],
                  );
                },
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            } else {
              return Container(child: Text("Nomalum xatolik !"),);
            }
          }
      )
    );
  }
}

