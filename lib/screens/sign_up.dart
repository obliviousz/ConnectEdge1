import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/screens/chatroomscreen.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:connectedge2/widgets/widget.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController usernametexteditingcontroller = new TextEditingController();
  TextEditingController emailtexteditingcontroller = new TextEditingController();
  TextEditingController passwordtexteditingcontroller = new TextEditingController();
  bool isValid = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  signMeUP() async{
      if(formKey.currentState.validate())
        {
            setState(() {
              isLoading = true;
            });
        }
      authMethods.signUpWithEmailPassword(emailtexteditingcontroller.text.trim(), passwordtexteditingcontroller.text).then((val){
        if(val!=null) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Authentication()),
          );
        }
      });
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
