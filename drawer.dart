import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.grey[850],
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:DecorationImage(image: NetworkImage("https://cutewallpaper.org/21/stylish-boys-wallpapers/50-Dps-For-Fb-Stylish-Boy-Cool-Cb-Dpzone-Of-Inam-Jni-.jpg")),
                    ),
                  ),
                  Text(
                    "Ajay Sharma",
                    style:TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    )
                  ),
                  Text(
                      "ajaysharma1234@gmail.com",
                      style:TextStyle(
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: Icon(Icons.group_add,color: Colors.white,),
              title:Text(
                "About us",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: null,
            ),
          ),
          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: Icon(Icons.person,color: Colors.white,),
              title:Text(
                "Edit profile",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: null,
            ),
          ),
          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: Icon(Icons.comment,color: Colors.white,),
              title:Text(
                "Raise An Issue",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: null,
            ),
          ),
          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: Icon(Icons.settings,color: Colors.white,),
              title:Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: null,
            ),
          ),
          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: Icon(Icons.arrow_back,color: Colors.white,),
              title:Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: null,
            ),
          ),
          Container(
            height: 181.13,
            color: Colors.grey[800],
          ),
        ],
      ) ,
    );
  }
}
