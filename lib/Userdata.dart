import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userdata{
  final String name;
  final String email;
  final String city;
  final String zipCode;
  final String uid;
  String phone;
  String imageUrl;

  

  Userdata({
    @required this.name,
    @required this.email,
    this.city,
    this.zipCode,
    this.phone,
    @required this.uid,
    this.imageUrl
  });


  Future<void> sendUserDataToDB() async {
    Firestore.instance.collection("Userdata").document(this.uid).setData({
      "Name" : this.name,
      "Email" : this.email,
      "City" : this.city,
      "ZipCode" : this.zipCode,
      "Phone" : this.phone,
      "ImageUrl" : this.imageUrl,
    });
  }

  static Future<Userdata> getDataFromDB(String uid) async {
    final doc = await Firestore.instance.collection("Userdata").document(uid).get();
    final data = doc.data;
    return Userdata(
      name : data["Name"],
      email : data["Email"],
      city : data["City"],
      zipCode : data["ZipCode"],
      phone : data["Phone"],
      imageUrl : data["ImageUrl"],
      uid: uid
    );
  }
    static Future<bool> docExists(String uid) async {
      final doc =  await Firestore.instance.collection("Userdata").document(uid).get();
      if (doc == null) return false;
      else return true;
    }

  }
