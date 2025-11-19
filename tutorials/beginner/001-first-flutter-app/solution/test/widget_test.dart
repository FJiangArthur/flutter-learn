import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app_solution/main.dart';

void main() {
  testWidgets('App displays Hello, Flutter!', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that 'Hello, Flutter!' is displayed
    expect(find.text('Hello, Flutter!'), findsOneWidget);

    // Verify that the app bar title is correct
    expect(find.text('My First App'), findsOneWidget);
  });

  testWidgets('App uses Scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that Scaffold is used
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('App uses AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that AppBar is present
    expect(find.byType(AppBar), findsOneWidget);
  });
}
