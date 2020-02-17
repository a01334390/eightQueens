
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  Future retrieveEightQueensResults() async {
    final prefs = await SharedPreferences.getInstance();
    String boardsString = await prefs.get('result');
    print(boardsString);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("results")
          ],
        ),
      ),
    );
  }
}