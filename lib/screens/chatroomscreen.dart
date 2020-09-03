import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/helper/constants.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/screens/search.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState(){
    getUserDetail();
    super.initState();
  }
  getUserDetail() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor : Colors.black,
          title: Text('𝕮𝖔𝖓𝖓𝖊𝖈𝖙 𝕰𝖉𝖌𝖊',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          ),
          actions: [
            GestureDetector(
                onTap: (){
                    authMethods.signOut();
                    Navigator.pushReplacement(
                      context,MaterialPageRoute(
                      builder: (context)=> Authentication(),
                    )
                    );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:16.0),
                  child: Icon(Icons.exit_to_app),
                )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()
            ));
          },
        ),
    );
  }
}

