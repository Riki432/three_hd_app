import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Userdata.dart';

class EmailAuth{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Future<FirebaseUser> signUpWithEmail(String email, String password) async {
    try{
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password
    );
    return authResult.user;
    }
    catch(exception){
      print(exception);
    }
    return null;
    
  }

  static void resetPassword(String email) 
  {
    /// Returns two errors
    /// ERROR_USER_NOT_FOUND
    /// ERROR_INVALID_EMAIL
    /// Make sure the second one doesn't happen
    /// Put a catch block for the first one.
      _firebaseAuth.sendPasswordResetEmail(
        email: email
      );    
  }

  static Future<bool> verifyEmail(FirebaseUser user) async { 
      user = await FirebaseAuth.instance.currentUser();
      print("${user.email} ${user.isEmailVerified}");
      return user.isEmailVerified;
  }


  static Future<FirebaseUser> signInWithEmail(String email, String password) async{
    try{
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password
    );
    return authResult.user;
    }
    catch(ex)
    {
      print(ex);
    }
    //GetIt.I.registerSingleton(user);
    return null;
  }
    
  Future<bool> forgotPassword({@required String email}) async {
    FirebaseAuth.instance
      .sendPasswordResetEmail(email: email)
        .then((_){
          return true;
        })
        .catchError((err){
          return false;
        });

      return false;
  }

}


class GoogleSignIn
{
    Future<Userdata> signIn() async{
      final _signIn = GoogleSignIn();
      await _signIn.signIn();
      final currUser = await FirebaseAuth.instance.currentUser();
      if (await Userdata.docExists(currUser.uid)){
        return Userdata.getDataFromDB(currUser.uid);
      }
      else{
        Userdata userData = Userdata(
          email: currUser.email, 
          name: currUser.displayName, 
          uid: currUser.uid,
          phone: currUser.phoneNumber,
          imageUrl: currUser.photoUrl
        );
        userData.sendUserDataToDB();
        return userData;
      }

    }


}



