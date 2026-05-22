// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_tailored/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2560);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
