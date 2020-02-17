
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
  var boards = new List();

  Future retrieveEightQueensResults() async {
    final prefs = await SharedPreferences.getInstance();
    int count = await prefs.getInt("count");
    print(count);
    var _boards = new List();
    for(int i = 1 ; i < count + 1; i++) {
      String s_board = prefs.getString('board'+i.toString());
      var board = jsonDecode(s_board);
      _boards.add(board);
    }

    setState(() {
      boards = _boards;
    });
  }

  @override
  void initState() {
    retrieveEightQueensResults().then((value) {
      print('async done');
      super.initState();
    });
  }
  
  Widget ResultItem(BuildContext context, int index) {
    String todisplay = "";
    for(int x = 0; x < boards[index].length; x++ ){
      todisplay += boards[index][x].toString();
      todisplay+= "\n";
    }
    return Text(todisplay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new ListView.builder(
          itemCount: boards.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Result ${index+1}'),
              subtitle: Container(
                child: ResultItem(context, index)
              ),
            );
          },
        )
    );
  }
}