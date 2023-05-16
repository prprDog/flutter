// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttertest/main.dart';
import 'package:uuid/uuid.dart';

import '../lib/bean.dart';

void main() {
  var list = [
    ComponentData(id: const Uuid().v1(), rotation: 0, x: 0, y: 0, width: 100, height: 100),
    ComponentData(id: const Uuid().v1(), rotation: 90, x: 100, y: 100, width: 200, height: 300),
  ];
  var label = Label(width: 800, height: 800, color: Colors.white.value, components: list);
  var labelJson = jsonEncode(label.toMap());
  print('labeljson:$labelJson');
  var map = jsonDecode(labelJson);
  print('decode:$map');
  var recoverlabel =Label.fromMap(map);
  print('label:$recoverlabel');
  /*testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });*/
}
