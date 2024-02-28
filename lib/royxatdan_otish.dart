import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yangi akkaunt ochish"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: TextField(
              // controller: ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Name")),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: TextField(
              // controller: ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Login")),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: TextField(
              // controller: ,
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
              },
              child: Text("Yaratish"),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
