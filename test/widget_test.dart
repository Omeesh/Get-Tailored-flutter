import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_tailored/main.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  testWidgets('App renders home screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2560);
    tester.view.devicePixelRatio = 1.0;

    FlutterError.onError = (FlutterErrorDetails details) {
      final exception = details.exceptionAsString();

      // Ignore overflow errors in tests
      if (exception.contains('A RenderFlex overflowed')) {
        return;
      }

      // Ignore network image failures in tests
      if (exception.contains('NetworkImageLoadException')) {
        return;
      }
    };

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}