// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eight_queens/main.dart';

void main() {
  group('Main Application tests', () {
    testWidgets('My App has a title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Find the title
      expect(find.text('Eight Queens App'), findsOneWidget);
    });

    testWidgets('My App has the desired message', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Find the title
      expect(find.text('Select a board size'), findsOneWidget);
    });

    testWidgets('My App has an usable textfield', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Enter a number into the textfield
      await tester.enterText(find.byType(TextField), '8');

      //Expect it was stored correctly
      expect(find.text('8'),findsWidgets);
    });

    testWidgets('App pushes a new view with results', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Enter a number into the textfield
      await tester.enterText(find.byType(TextField), '8');

      //Tap the button to go to the next screen
      await tester.tap(find.byIcon(Icons.done));

      // Wait for it to be shown
      await tester.pumpAndSettle();

      //Expect the new page to be shown
      expect(find.byType(ResultsPage),findsOneWidget);
    });

    testWidgets('App with invalid input wont show results widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Enter a number into the textfield
      await tester.enterText(find.byType(TextField), '0');

      //Tap the button to go to the next screen
      await tester.tap(find.byIcon(Icons.done));

      // Wait for it to be shown
      await tester.pumpAndSettle();

      //Expect the new page to be shown
      expect(find.byType(ResultsPage),findsNothing);
    });


  });
}
