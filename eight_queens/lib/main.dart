import 'package:eight_queens/queens.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Eight Queens App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _boardSize = 0;

  ProgressDialog pr;

  // Create a controller to retrieve data from the TextField
  final boardController = TextEditingController();

  @override
  void dispose() {
    // Clean the controller when the widget is disposed
    boardController.dispose();
    super.dispose();
  }

  /**
   * Retrieve the board number and pass it to the eight queens controller
   * TODO: Create the Responsible class in Dart
   */
  void _startProcessing() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _boardSize = int.parse(boardController.text);
    });
//    await pr.show();
    QueenResolver().solve(8);
//    await pr.dismiss();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(title: "Results")));
  }

  @override
  Widget build(BuildContext context) {
    // Build the progress Dialog Element and Style it
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Calculating results...',
        borderRadius: 20.0,
        progressWidget: CircularProgressIndicator(),
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Select a board size',
                  style: TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                )
            ),
            Container(
              width: 200,
              child: new TextField(
                controller: boardController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Board Size"
                ),

              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startProcessing,
        tooltip: 'Process Positions',
        child: Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
