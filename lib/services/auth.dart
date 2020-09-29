import 'package:connectedge2/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
    User _userFromFirebaseUser(FirebaseUser user) {
      return user!=null ?  User(userId: user.uid): null;
    }
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future signInWithEmailPassword(String email, String password) async {
        try{
          AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
          FirebaseUser firebaseUser = result.user;
          return _userFromFirebaseUser(firebaseUser);
        }catch(e){
            print(e.toString());
        }
    }
    Future signUpWithEmailPassword(String email, String password) async
    {
      try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // ignore: deprecated_member_use
        FirebaseUser firebaseUser = result.user;
        return _userFromFirebaseUser(firebaseUser);
      }catch(e){
        print(e.toString());
      }
    }
    Future resetPassword(String email) async
    {
      return await _auth.sendPasswordResetEmail(email: email);
    }
    Future signOut() async
    {
        return await _auth.signOut();
    }

}