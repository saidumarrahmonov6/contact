import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MalumotApp extends StatefulWidget {
  const MalumotApp({super.key});

  @override
  State<MalumotApp> createState() => _MalumotAppState();
}

class _MalumotAppState extends State<MalumotApp> {
  CollectionReference contact = FirebaseFirestore.instance.collection("contact");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontaktlar"),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.lock, size: 30,)
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.lock_outline, size: 30,),
                  Text("Qulflash" , style: TextStyle(fontSize: 25),),
                ],
              ),
            ),
            MaterialButton(
              onPressed: (){},
              child: Row(
                children: [
                  Icon(Icons.add, size: 30,),
                  Text("Yangi kontakt yaratish" ,),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: contact.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (BuildContext context , int index){
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  final String lasttxt = document['name'];
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    height: 80,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(200)
                          ),
                          alignment: Alignment.center,
                          child: Text(lasttxt.substring(0 , 1) , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40),),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(document['name'], style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              child: Text(document['number'], style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        MaterialButton(
                          minWidth: 60,
                          onPressed: ()async{
                            final Uri launcherUri = Uri(scheme: 'tel' , path: document['number']);
                            await launchUrl(launcherUri);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(20)
                            ),
                              child: Icon(Icons.call, size: 50,)
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            } else {
              return Center(child: Text("Xatolik"),);
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(_)=>AddApp()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
