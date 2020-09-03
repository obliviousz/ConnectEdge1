import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/helper/database.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/screens/chatroomscreen.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:connectedge2/widgets/widget.dart';
import 'package:flutter/material.dart';

/*showAlertDialog(BuildContext context) {
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
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(color: Colors.black)
    ),
    color: Colors.black,
    onPressed: () {

    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
    title: Text("Welcome to ConnectEdge",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    content: Text("Click OK to login...",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
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
}*/

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
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Authentication()),
          );
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: appBarMain(context),
        body: isLoading? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ) :SingleChildScrollView(
            child: Container(
                alignment: Alignment.bottomCenter,
                child :Container(
                    padding: EdgeInsets.symmetric(horizontal:20.0),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height:160.0),
                              TextFormField(
                                validator: (val){
                                  return val.isEmpty || val.length<2 ? "Input correct output(3+ characters)" : null;
                                },
                                controller: usernametexteditingcontroller,
                                style:TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textfield(),
                              ),
                              SizedBox(height:10.0),
                              TextFormField(
                                validator: (val){
                                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter correct email";
                                },
                                controller: emailtexteditingcontroller,
                                style:TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textfield1(),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                validator:  (val){
                                  return val.isEmpty|| val.length < 6 ? "Enter Password 6+ characters" : null;
                                },
                                controller: passwordtexteditingcontroller,
                                style:TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textfield2(),
                                obscureText: true,
                              ),
                              SizedBox(height: 40.0),
                              SizedBox(
                                height: 60.0,
                                width: 250.0,
                                child :GestureDetector(
                                  onTap: (){
                                    //if()
                                    signMeUP();
                                  },
                                    child: buttons1("Register",context)
                                ),
                              ),
                              SizedBox(height:20.0),
                              SizedBox(
                                height: 60.0,
                                width: 400.0,
                                child: GestureDetector(
                                  onTap: (){
                                    widget.toggle();
                                  },
                                    child: buttons1("Have Account? Sign In",context),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        )
                      ],
                    )
                )
            )
        )
    );
  }
}
