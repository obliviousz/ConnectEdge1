import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectedge2/helper/database.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/widgets/widget.dart';
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
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(color: Colors.black)
    ),
    color: Colors.black,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
    title: Text("Wrong Email Id or Password",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    content: Text("Enter Correct Email Id or Password",
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
      backgroundColor: Colors.black,
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
        child :Container(
            padding: EdgeInsets.symmetric(horizontal:20.0),
          child: Column(
          children: [
            Form(
              key : formKey,
              child: Column(
                children: [
                  SizedBox(height:160.0),
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
                  SizedBox(height:10.0),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 60.0,
                    width: 200.0,
                    child :GestureDetector(
                      onTap: (){
                        signIn();
                      },
                        child: buttons1("Sign In",context),
                    ),
                  ),
                  SizedBox(height:20.0),
                  SizedBox(
                    height: 60.0,
                    width: 200.0,
                    child: GestureDetector(
                      onTap: (){
                            widget.toggle();
                      },
                        child: buttons1("Sign Up",context)
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
