import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Authentication.dart';
import 'Routes.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Forgot Password"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key : _formKey,
          child: Column(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                hintText: "Enter your email",
                labelText: "Email"
                ),
                validator: (String val){
                  var pattern = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
                  if(pattern.hasMatch(val.trim()) != null) return null;
                  else return "Please enter a valid email ID.";
                },
              ),
          ),
          RaisedButton(
            child: Text("Send Password Reset Email"),
            onPressed: (){
              if(_formKey.currentState.validate())
              {
                EmailAuth.resetPassword(_emailController.text);
                Toast.show("Please check your inbox!", context, duration: 5);
                Navigator.pushNamed(context, Routes.login);
              }
            },
          ),
            ],
          ),
        ),
      ),
    );
  }
}