import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final mobileNumber;

  const OTPScreen({Key key, this.mobileNumber}) : super(key: key);


  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      color: Colors.red,
    );
  }
}