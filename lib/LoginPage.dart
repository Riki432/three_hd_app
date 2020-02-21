import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10.0),
          // color: Colors.limeAccent,
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 400)),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(
                color: Colors.black
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        labelText: "Email"
                      ),
                      autovalidate: true,
                      validator: (String val){
                        final emailReg = RegExp("[a-zA-z]+@[a-z]\.[a-z]{6}");
                        if(emailReg.stringMatch(val) == null)
                        {
                          return null;
                        }
                        else{
                          return "";
                        }
                      },
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter your passsword",
                      labelText: "Password"
                    ),
                    onEditingComplete: (){
                      
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Forgot Password"),
                      onPressed: (){
                        print("Forgot Password");
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        child: Text("Login"),
                        color: Colors.red,
                        splashColor: Colors.blue,
                        onPressed: (){
                          print("Login btn pressed");
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New User?"),
                        FlatButton(
                          child: Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue
                              ),
                              ),
                          onPressed: (){
                            print("I want to register");
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}