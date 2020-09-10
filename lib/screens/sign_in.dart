import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectedge2/helper/database.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:connectedge2/services/auth.dart';
import 'chatroomscreen.dart';
import 'forgotPassword.dart';

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton =  RaisedButton(
    child: Text("OK",
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
      Navigator.of(context).pop();
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
        Text("Invalid Credentials!!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3,),
        Divider(
          thickness: 1,
        ),
        SizedBox(height: 3,),
        Text("Please click OK to try again.",
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
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailtexteditingcontroller = new TextEditingController();
  TextEditingController passwordtexteditingcontroller = new TextEditingController();

  AuthMethods authService = new AuthMethods();
  DatabaseMethods dataService = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  QuerySnapshot userDetails;

  signIn() async {
    if (formKey.currentState.validate()) {

      // save the user_email of the user
      HelperFunctions.saveUserEmailSharedPreference(
          emailtexteditingcontroller.text);

      setState(() {
        isLoading = true;
      });

      // to get the data of the user from database by user_email
      await dataService.getUserByUserEmail(emailtexteditingcontroller.text)
          .then((result) async {
        userDetails = result;
        HelperFunctions
            .saveUserNameSharedPreference(userDetails.documents[0].data["name"]);
      });

      // to check whether the email and password entered are correct or not
      await authService.signInWithEmailPassword(
          emailtexteditingcontroller.text, passwordtexteditingcontroller.text)
          .then((result) async {
        if (result != null)  {
          // authentication successful
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        } else {
          // authentication failed
          setState(() {
            isLoading = false;
            showAlertDialog(context);
          });
        }
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
              SizedBox(height: 58,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10,),
                    Text("Welcome to ConnectEdge", style: TextStyle(color: Colors.white, fontSize: 18),),
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
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                        ),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            signIn();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[700]
                            ),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Don't have an account?", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            widget.toggle();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black
                            ),
                            child: Center(
                              child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
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
