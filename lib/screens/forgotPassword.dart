import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:connectedge2/widgets/widget.dart';
import 'package:flutter/material.dart';

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
        side: BorderSide(color: Colors.green)
    ),
    color: Colors.black,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Wrong Email Id",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    content: Text("Enter Correct Email Id",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    backgroundColor: Colors.black,
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
class ForgotPassword extends StatefulWidget {
  //final Function toggle;
  //ForgotP(this.toggle);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailtexteditingcontroller = new TextEditingController();
  TextEditingController passwordtexteditingcontroller = new TextEditingController();
  AuthMethods authService = new AuthMethods();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  forgotPassword() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService.resetPassword(
          emailtexteditingcontroller.text)
          .then((result) async {
        if (result != null)  {
          /*QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(emailtexteditingcontroller.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);*/
          setState(() {
            isLoading = false;
            showAlertDialog(context);
          });
        } else {
          Navigator.pushReplacement(

              context, MaterialPageRoute(builder: (context) => Authentication()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: appBarMain(context),
        body: SingleChildScrollView(
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
                              SizedBox(height:100.0),
                              Text("We'll send a password reset link to you email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              )),
                              SizedBox(height:90.0),
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
                              SizedBox(height: 20.0),
                              SizedBox(
                                height: 80.0,
                                width: 300.0,
                                child :GestureDetector(
                                  onTap: (){
                                    forgotPassword();
                                  },
                                  child: buttons1("Get Password Reset",context),
                                ),
                              ),

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
