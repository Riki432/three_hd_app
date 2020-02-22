import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Userdata.dart';

class EmailAuth{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> signUpWithEmail(String email, String password) async {
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


  static Future<bool> sendData(Userdata data) async {
    await Firestore.instance.collection("Userdata")
      .document()
        .setData({
          "FirstName" : data.fname,
          "LastName" : data.lname,
          "Email" : data.email,
          "City" : data.city,
          "Phone" : data.phone,
          "ZipCode" : data.zipCode
        }).catchError((err){
          return false;
        });
    return true;
  }


  Future<Userdata> getData(String uid) async {
    DocumentSnapshot document = await Firestore.instance.collection("Userdata").document(uid).get();
    Userdata data = document.data as Userdata;
    return data;
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
  
}



