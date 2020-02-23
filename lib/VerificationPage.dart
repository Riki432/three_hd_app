import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Authentication.dart';

class VerifyingEmail extends StatefulWidget {
  final FirebaseUser user;

  VerifyingEmail(this.user);
  @override
  _VerifyingEmailState createState() => _VerifyingEmailState();
}

class _VerifyingEmailState extends State<VerifyingEmail> {
Color cardColor = Colors.red;

@override
void dispose() { 
  super.dispose();
}

@override
void initState() { 
  
  EmailAuth.verifyEmail(widget.user).then((eV){
    if(eV != null && eV == true)
    {
      cardColor = Colors.green;
      Navigator.of(context).pop(true);
    }
  });
  
  super.initState(); 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
        child: Card(
          color: cardColor,
          elevation: 5,
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.replay), 
                      onPressed: () async { 
                        final eV = await EmailAuth.verifyEmail(widget.user);
                        if(eV != null && eV == true)
                        {
                          setState(() {
                            cardColor = Colors.green;
                          });

                          Navigator.of(context).pop(true);
                        }
                       },

                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Verifying Email!", style: TextStyle(fontSize: 25)),
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}