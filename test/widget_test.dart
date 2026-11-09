import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pablo_lab3/main.dart';

void main() {
  testWidgets('Lab 3 initial smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginRegisterApp());
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
