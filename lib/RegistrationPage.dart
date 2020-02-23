import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:three_hd_app/Authentication.dart';
import 'package:three_hd_app/Routes.dart';
import 'package:three_hd_app/VerificationPage.dart';
import 'package:toast/toast.dart';
import 'HomePage.dart';
import 'Userdata.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  File profileImage;
  bool userVerified = false;
  FirebaseUser user;
  final _formKey = GlobalKey<FormState>();

  final _emailVerificationDialog  = AlertDialog(
    title: Text("Verifying Email"),
    content: Column(
      children: <Widget>[
        Text("Please check your inbox!"),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircularProgressIndicator(),
        )
      ],
    ),
    elevation: 10.0,
  );

  @override
  void dispose() { 
    //if(!userVerified && user != null)
    //{
    //  user.delete();
    //}
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        height: 1200,
        margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async {
                        profileImage = await Userdata.getImage();
                        // Crop c = Crop.file(file)
                        // c.
                        setState(() {});
                      },
                        child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: profileImage == null? Image.asset("assets/userProfile.png").image : Image.file(profileImage, height: 200, width: 200).image
                          )
                        ),
                      ),
                    ),
                  ),
                  //GestureDetector(
                  //  onTap: (){
                  //      ImageCropper.cropImage(
                  //        sourcePath: profileImage.path,
                  //        cropStyle: CropStyle.rectangle, 
                  //      );
                  //    },
                  //    child: Container(
                  //    color: Colors.red,
                  //    height: 400.0,
                  //    width: 400.0,
                  //    ),
                  //),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    controller: nameController,
                    validator: (val){
                      if(val.length < 3) return "Please enter a proper name";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                    controller: emailController,
                    validator: (val){
                    var pattern = RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
                      if(!pattern.hasMatch(val)) return "Please enter valid email";
                      return null;

                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    controller: phoneController,
                    maxLength: 10,
                    validator: (val){
                      var pattern = RegExp(r"[0-9]{10}");
                      if(!pattern.hasMatch(val)) return "Please enter valid mobile no.";
                      return null;

                    },
                    decoration: InputDecoration(
                        hintText: "Mobile No.",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    controller: passwordController,
                    validator: (val){
                      if(val.length < 8 ) return "Password has to be more than 8 characters";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    controller: rePasswordController,
                    validator: (val){
                      if(passwordController.text != val) return "Passwords don't match";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "ReEnter your Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5,
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(32.0),
                      child: MaterialButton(
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) return;
                          showDialog(
                            context: context,
                            builder: (_) => Container(
                              child: AlertDialog(
                                title: Text("Please wait.."),
                                content: Container(
                                  height: 100.0,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Signing you up.."),
                                      ),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                )
                              ),
                            )
                          );

                          FirebaseUser user = await EmailAuth.signUpWithEmail(emailController.text, passwordController.text);
                          if(user == null){
                            print("User is null");
                            return;
                          }

                          user.sendEmailVerification();
                          Toast.show("Please check your inbox", context, duration: 2);
                          final eV = await Navigator.push(context, MaterialPageRoute(
                            builder: (context) => VerifyingEmail(user),
                          ));

                          if(eV == null || eV == false){
                            user.delete();
                            Navigator.of(context).pop();
                            showDialog(
                            context: context,
                            builder: (_) => Container(
                              child: AlertDialog(
                                title: Text(":("),
                                content: Container(
                                  height: 70.0,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Could not verify email.. "),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  )
                                ],
                              ),
                            )
                          );
                          return;
                          }

                          String url;
                          url = profileImage == null ? null : await Userdata.uploadImage(profileImage, user.uid);

                          final data = Userdata(
                            name: nameController.text,
                            email: emailController.text, 
                            uid: user.uid,
                            phone: phoneController.text,
                            imageUrl: url,
                            );  
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(userData: data,),
                            )
                          );
                          
                          data.sendUserDataToDB();

                          //EmailAuth.signUpWithEmail(emailController.text, passwordController.text)
                          //  .then((user){
                          //    print("User signed up");  //First
                          //  if(profileImage != null){
                          //    Userdata.uploadImage(profileImage, user.uid)
                          //      .then((url){
                          //        print("Image uploaded"); // Second
                          //          final data = Userdata(
                          //          name: nameController.text,
                          //          email: emailController.text, 
                          //          uid: user.uid,
                          //          imageUrl: url,
                          //          );  
                          //          Navigator.pushNamed(context, Routes.home, arguments: data);
                                    
                          //          data.sendUserDataToDB();
                          //          print("Data pushed to DB");
                          //      }).catchError((err){print(err);});
                          //    } else
                          //    {
                          //          final data = Userdata(
                          //          name: nameController.text,
                          //          email: emailController.text, 
                          //          uid: user.uid,
                          //          );  
                          //          Navigator.pushNamed(context, Routes.home, arguments: data);
                          //          data.sendUserDataToDB();
                          //    }                          
                          //  }).catchError((PlatformException err){
                          //      if(err.code == "ERROR_EMAIL_ALREADY_IN_USE"){
                          //        print("Email is already in use!");
                          //      }
                              
                          //    print(err);
                          //  });
                        },
                        minWidth: 100.0,
                        height: 45.0,
                        child: Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Auto-Fill"),
                    onPressed: (){
                      nameController.text = "Riki";
                      emailController.text = "bansoderahul432@gmail.com";
                      passwordController.text = "123456789";
                      rePasswordController.text = "123456789";
                      phoneController.text = "9152204054";
                      
                    }
                  )
                ],
            ),
              ),
          ),
        ),
    );
  }
}

