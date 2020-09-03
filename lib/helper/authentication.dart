import 'package:connectedge2/screens/sign_in.dart';
import 'package:connectedge2/screens/sign_up.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showSignedIn = true;
  void toggleView() {
    setState(() {
      showSignedIn = !showSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignedIn) {
      return SignIn(toggleView);
    }
    else{
      return SignUp(toggleView);
    }
  }
}