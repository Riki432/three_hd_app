import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Userdata{
  final String name;
  final String email;
  final String city;
  final String zipCode;
  final String uid;
  String phone;
  String imageUrl;
  Image image;
  

  Userdata({
    @required this.name,
    @required this.email,
    this.city,
    this.zipCode,
    this.phone,
    @required this.uid,
    this.imageUrl = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    this.image,
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

  static Future<File> getImage() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80
    );
    return file;
  }

  static Future<String> uploadImage(File img, String uid) async {
      /// Returns the url of the file uploaded 
      final StorageReference ref = FirebaseStorage().ref().child("Profiles/$uid");
      final StorageUploadTask task = ref.putFile(img);
      // Cancel your subscription when done.
      final downloadurl = await task.onComplete;
      final String url = (await downloadurl.ref.getDownloadURL());
      return url;
    }
  }

