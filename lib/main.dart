import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact/malumot.dart';
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
  CollectionReference logins = FirebaseFirestore.instance.collection("logins");

  TextEditingController logintxt = TextEditingController();
  TextEditingController passwordtxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: StreamBuilder(
        stream: logins.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.size,
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
                            check(logintxt.text, passwordtxt.text, document);
                          },
                          child: Text("Login"),
                          color: Colors.green,
                        ),
                      )
                    ],
                  );
                },
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            } else {
             return Center(child: Text("Nomalum xatolik !"),);
            };
          }
      )
    );
  }
  check(String login , String password , document){
    if(login == document['login'] && password == document['password']){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> MalumotApp()));
    }
  }
}

