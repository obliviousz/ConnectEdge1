import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/helper/database.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/screens/chatroomscreen.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:connectedge2/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'forgotPassword.dart';

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton =  RaisedButton(
    child: Text("Login",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    color: Colors.grey[800],
    onPressed: () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Authentication()
      ));
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ConnectEdge",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        Divider(
          thickness: 1,
        ),
        SizedBox(height: 4,),
        Text("Hey!!! Welcome to ConnectEdge. We hope you will find it useful.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            )
        ),
      ],
    ),
    backgroundColor: Colors.white,
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {

  bool isValid = false;
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernametexteditingcontroller = new TextEditingController();
  TextEditingController emailtexteditingcontroller = new TextEditingController();
  TextEditingController passwordtexteditingcontroller = new TextEditingController();

  signMeUP() async{
      if(formKey.currentState.validate()) {

        Map<String, String> userInfoMap = {
          "name" : usernametexteditingcontroller.text,
          "email" : emailtexteditingcontroller.text,
        };

        setState(() {
          isLoading = true;
        });

        authMethods.signUpWithEmailPassword(emailtexteditingcontroller.text, passwordtexteditingcontroller.text).then((val){
          databaseMethods.uploadUserInfo(userInfoMap);
          setState(() {
            // showAlertDialog(context);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authentication()
            ));
          });
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey,
      body: isLoading ?
      Container(
        child: Center(child: CircularProgressIndicator()),
      ) :
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  Colors.black54,
                  Colors.black87,
                ]
            )
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 35),),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(128,128,128, .5),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  controller: usernametexteditingcontroller,
                                  validator: (val){
                                    return val.isEmpty || val.length<2 ? "Enter Username(3+ characters)" : null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Username",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  controller: emailtexteditingcontroller,
                                  validator: (val){
                                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter correct email";
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  controller: passwordtexteditingcontroller,
                                  validator: (val){
                                    return val.isEmpty || val.length < 6 ? "Enter Password 6+ characters" : null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                            signMeUP();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[700]
                            ),
                            child: Center(
                              child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ", style: TextStyle(color: Colors.grey),),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                                child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                  ),
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
