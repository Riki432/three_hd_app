import 'package:flutter/material.dart';
import 'package:three_hd_app/Userdata.dart';

class HomePage extends StatefulWidget {
  final Userdata userData;
  HomePage({@required this.userData});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Userdata data;
  @override
  void initState() { 
    data = widget.userData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.network(data.imageUrl, height: 300.0, width: 300.0,),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(data.name),
              )
            ]
          ),
        ),
      ),
    );
  }
}