import 'package:connectedge2/helper/authentication.dart';
import 'package:connectedge2/helper/constants.dart';
import 'package:connectedge2/helper/database.dart';
import 'package:connectedge2/helper/helperfunctions.dart';
import 'package:connectedge2/screens/conversation_screen.dart';
import 'package:connectedge2/screens/profile_page.dart';
import 'package:connectedge2/screens/search.dart';
import 'package:connectedge2/services/auth.dart';
import 'package:connectedge2/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return ChatRoomTile(
                userName: snapshot.data.documents[index].data["chatroomid"]
                  .toString().replaceAll("_", "")
                    .replaceAll(Constants.myName, ""),
                chatRoomId: snapshot.data.documents[index].data["chatroomid"],
              );
            }
        ) : Container();
      },
    );
  }
  @override
  void initState(){
    getUserDetail();
    super.initState();
  }
  getUserDetail() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
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
                          image:DecorationImage(image: NetworkImage("https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png")),
                        ),
                      ),
                      Text(
                          "${Constants.myName}",
                          style:TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          )
                      ),
                      SizedBox(height: 5,),
                      Text(
                          "${Constants.myEmail}",
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
                  leading: Icon(Icons.person,color: Colors.white,),
                  title:Text(
                    "Edit profile",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,MaterialPageRoute(
                      builder: (context)=> ProfilePage(),
                    )
                    );
                  },
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
              // Logout Button
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
                  onTap: () {
                    authMethods.signOut();
                    HelperFunctions.saveUserLoggedInSharedPreference(false);
                    Navigator.pushReplacement(
                        context,MaterialPageRoute(
                      builder: (context)=> Authentication(),
                    )
                    );
                  },
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
              Expanded(
                child: Container(
                  color: Colors.grey[800],
                ),
              ),
            ],
          ) ,
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor : Colors.black,
          centerTitle: true,
          title: Text('𝕮𝖔𝖓𝖓𝖊𝖈𝖙 𝕰𝖉𝖌𝖊',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          ),
        ),
        body: chatRoomList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()
            ));
          },
        ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {

  final String userName;
  final String chatRoomId;
  ChatRoomTile({this.userName, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0, 1).toUpperCase()}", style: mediumTextStyle(),),
            ),
            SizedBox(width: 8,),
            Text(userName, style: mediumTextStyle(),)
          ],
        ),
      ),
    );
  }
}
