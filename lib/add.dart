import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddApp extends StatefulWidget {
  const AddApp({super.key});

  @override
  State<AddApp> createState() => _AddAppState();
}

class _AddAppState extends State<AddApp> {
  TextEditingController nametxt = TextEditingController();
  TextEditingController numbertxt = TextEditingController();
  CollectionReference contact = FirebaseFirestore.instance.collection("contact");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontakt qo'shish"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: TextField(
              controller: nametxt,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Ismi")),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: TextField(
              controller: numbertxt,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Raqami")),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            height: 40,
            child: MaterialButton(
              onPressed: () {
                if(numbertxt.text != "" && nametxt.text != ""){
                  Map<String , String> newKontakt = {
                    'name':nametxt.text,
                    'number':numbertxt.text
                  };
                  contact.add(newKontakt);
                  Navigator.pop(context);
                }
              },
              child: Text("Saqlash"),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
