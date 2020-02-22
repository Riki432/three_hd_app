import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as JSON ;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn =false;
  Map userProfile;
  final facebookLogin = FacebookLogin();
  _loginWithFB() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await JSON.get('https://graph.facebook.com/v2.12/me?fields=id,name,birthday,gender,adderess,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }
  }
    _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Center(
        child:_isLoggedIn ? Column(
          children: <Widget>[
            Image.network("http://palcehold.it/50x50",height: 50,width: 50),
            Text(""),
            // Text(""), I'm not sure about this
            // Text(""),  
            // Text(""),
            // Text(""),
            OutlineButton(
              child: Text("Logout"),
              onPressed: () {
                _logout();
              },
            )
          ],
        )
        :OutlineButton(
          child: Text(
            "Login With Facebook"), 
            onPressed: () {
              _loginWithFB();
            },
          ),
        ),
      ),
    );
  }
}