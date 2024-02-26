import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController logintxt = TextEditingController();
  TextEditingController passwordtxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
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
          MaterialButton(
            onPressed: () {},
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
