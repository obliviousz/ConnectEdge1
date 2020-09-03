import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/screens/sign_in.dart';
import 'package:connectedge2/screens/sign_up.dart';
import 'package:flutter/material.dart';
Widget appBarMain(BuildContext context){
    return AppBar(
      centerTitle: true,
      backgroundColor : Colors.black,
      title: Text('𝕮𝖔𝖓𝖓𝖊𝖈𝖙 𝕰𝖉𝖌𝖊',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
      ),
    );
}
InputDecoration textfield()
{
  return InputDecoration(
    //obscureText:true,
      hintText: 'username',
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      )
    );
}
InputDecoration textfield1()
{
  return InputDecoration(
    //obscureText:true,
      hintText: 'email',
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      )
  );
      //obscureText: true,
}
InputDecoration textfield2()
{
  return InputDecoration(
      //obscureText:true,
        hintText: 'password',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        )
    );
}
Widget buttons1(String inp,BuildContext context)
{
  return RaisedButton(
    //color: Colors.green,
    //hoverColor: Colors.green,
    child : Text(
      inp,
      style: TextStyle(
        fontSize:25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    color: Colors.black,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(color: Colors.green)
    ),
  );
}

BoxDecoration margins()
{
    return BoxDecoration(
      border: Border.all(
      color: Colors.green,
      ),
    );
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.white
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17
  );
}