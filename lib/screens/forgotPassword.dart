import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, int id) {
  // Create button
  Widget okButton = RaisedButton(
    child: Text(
      "OK",
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
  Widget okButton2 = RaisedButton(
    child: Text(
      "OK",
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Authentication()));
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3,
        ),
        Text("The email you entered isn't registered. Please try again.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            )),
      ],
    ),
    backgroundColor: Colors.white,
    actions: [
      okButton,
    ],
  );
  AlertDialog alert2 = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3,
        ),
        Text("An email has been sent to you with password reset instructions. Click OK to login.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            )),
      ],
    ),
    backgroundColor: Colors.white,
    actions: [
      okButton2,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return (id == 0 ? alert : alert2);
    },
    barrierDismissible: false,
  );
}

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailtexteditingcontroller =
      new TextEditingController();
  TextEditingController passwordtexteditingcontroller =
      new TextEditingController();
  AuthMethods authService = new AuthMethods();

  final formKey = GlobalKey<FormState>();

  forgotPassword() async {
    if (formKey.currentState.validate()) {
      await authService
          .resetPassword(emailtexteditingcontroller.text)
          .then((result) async {
        if (result == null) {
          // showAlertDialog(context, 1);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Authentication()));
        } else {
          showAlertDialog(context, 0);
        }
      }).catchError((e) {
        showAlertDialog(context, 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.black54,
            Colors.black54,
            Colors.black87,
          ]),
        ),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Confirm your email and we'll send you a link to reset your password.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17.0,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Enter correct email";
                            },
                            controller: emailtexteditingcontroller,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.white70,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white54),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            forgotPassword();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[800]),
                            child: Center(
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text(
                "Login Page",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.arrow_back),
              backgroundColor: Colors.grey[850]),
        ],
      ),
    );
  }
}
