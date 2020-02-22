import 'dart:ui';

import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String flareAnimation = "Bounce";
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10.0),
          // color: Colors.limeAccent,
        ),
        child: Column(
          children: <Widget>[
              Container(
                // color: Colors.red,
                height: 200.0,
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: FlareActor(
                  "assets/LoginAnim.flr",
                  animation: flareAnimation,
                  shouldClip: true,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  
                  // controller: FlareController(),
                ),
              ),            
            Center(
              child: Container(
                constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 400)),
                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: Form(
                  key: _formKey,
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   height: 200.0,
                      //   child: FlareActor(
                      //   "assets/LoginAnim.flr",
                      //   animation: flareAnimation,
                      //   // shouldClip: true,
                      //   // controller: FlareController(),
                      //  )
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            controller: email,
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: "Enter your passsword",
                            labelText: "Password"
                          ),
                          validator: (String val){
                            if(val.length < 8) return "Invalid password";
                            else return null;
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
                                setState(() {
                                flareAnimation = "Zoom";  
                                });
                                if(_formKey.currentState.validate()){
                                  print("Validating?");
                                }
                                
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
          ],
        ),
      ),
    );
  }
}