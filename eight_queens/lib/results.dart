
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  var boards;

  Future retrieveEightQueensResults() async {
    final prefs = await SharedPreferences.getInstance();
    String boardsString = await prefs.get('result');
    setState(() {
      boards = jsonDecode(boardsString);
    });
  }

  @override
  void initState() {
    retrieveEightQueensResults().then((value) {
      print('async done');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: boards.length,
        itemBuilder: (BuildContext context, int index) {
          return new Text(boards[index].toString());
        },
      )
    );
  }
}