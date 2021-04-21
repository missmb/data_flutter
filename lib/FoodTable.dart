import 'package:flutter/material.dart';
import 'Food.dart';
import 'Services.dart';
// import 'dart:async';

class FoodTable extends StatefulWidget {
  FoodTable() : super();
  final String title = 'Food Data Table';
  @override
  FoodTableState createState() => FoodTableState();
}

class FoodTableState extends State<FoodTable> {
  List<Food> _foods;
  // GlobalObjectKey<ScaffoldState> _scaffoldKey;
   GlobalKey<ScaffoldState> _scaffoldKey;
  //  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController _usernameController; //Control username TextField
  TextEditingController _foodController; //Control username TextField
  Food _selectedFood;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _foods = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    // _scaffoldKey = GlobalKey(); // Key to get the context to shoe a SnackBar
     _scaffoldKey = new GlobalKey<ScaffoldState>();
    _usernameController = TextEditingController();
    _foodController = TextEditingController();
  }

// Method to update the AppBar title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _addFood() {
    //
  }

  _getFood() {
    //
  }

  _updateFood() {
    //
  }

  _deleteFood() {
    //
  }

//Method to clear TextField values
  _clearValues() {
    _usernameController.text = "";
    _foodController.text = "";
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress), // show the progress in the title..
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getFood();
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration.collapsed(hintText: 'Username'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _foodController,
                  decoration: InputDecoration.collapsed(hintText: 'Food'),
                ),
              ),
              // Add an update button and Cancel button
              // show these buttons only ehen updating an food
              _isUpdating
                  ? Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('Update'),
                          onPressed: () {
                            _updateFood();
                          },
                        ),
                        OutlineButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            setState(() {
                              _isUpdating = false;
                            });
                            _clearValues();
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
