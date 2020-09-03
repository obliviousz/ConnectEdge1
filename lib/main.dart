import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/screens/chatroomscreen.dart';
import 'package:flutter/material.dart';
import 'screens/sign_in.dart';
import 'helper/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn;

  @override
  void initState(){
    getLoggedInStatus();
    super.initState();
  }
  getLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: 'Connect Edge',
      home: userIsLoggedIn != null ? (userIsLoggedIn ? ChatRoom() : Authentication()) : Authentication(),
    );
  }
}