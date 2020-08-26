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
        side: BorderSide(color: Colors.green)
    ),
    color: Colors.black,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Wrong Email Id or Password",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    content: Text("Enter Correct Email Id or Password",
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

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService.signInWithEmailPassword(
          emailtexteditingcontroller.text, passwordtexteditingcontroller.text)
          .then((result) async {
        if (result != null)  {
          /*QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(emailtexteditingcontroller.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);*/

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          //print("******************");
          setState(() {
            isLoading = false;
            showAlertDialog(context);
            //show snackbar
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
