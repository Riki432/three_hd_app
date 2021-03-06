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
    return WillPopScope(
          onWillPop: () => showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              content: Text("Are you sure you want to exit?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            ),

          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text("Home"),
            ),
        body: Center(
          child: Card(
            elevation: 10.0,
            child: Container(
              constraints: BoxConstraints.loose(Size(400, 400)),
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
        ),
      ),
    );
  }
}