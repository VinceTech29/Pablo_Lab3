import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pablo_lab3/main.dart';

void main() {
  testWidgets('Initial UI displays custom App Name, Form, and Student Info',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LoginRegisterApp());
    await tester.pumpAndSettle();

    // Verify App Name above the form
    expect(find.text('AuthPortal App'), findsOneWidget);

    // Verify Form Heading
    expect(find.text('Welcome Back!'), findsOneWidget);

    // Verify Student Name and Section below the form
    expect(find.text('Student: Lourde Vincent Pablo'), findsOneWidget);
    expect(find.text('Section: BSIT 3-A'), findsOneWidget);

    // Verify Login Button and switch button
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    expect(find.text('No account yet? Register'), findsOneWidget);
  });

  testWidgets('Validation errors appear on empty login submit',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LoginRegisterApp());
    await tester.pumpAndSettle();

    // Tap Login without filling fields
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);
  });

  testWidgets('Validation error for password shorter than 8 characters',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LoginRegisterApp());
    await tester.pumpAndSettle();

    // Enter valid email and short password (less than 8 chars)
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), '12345');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Use at least 8 characters.'), findsOneWidget);
  });

  testWidgets('Full registration and login flow works correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LoginRegisterApp());
    await tester.pumpAndSettle();

    // Switch to Register
    await tester.tap(find.text('No account yet? Register'));
    await tester.pumpAndSettle();

    expect(find.text('Create an Account'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
    expect(
        find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);

    // Fill registration form with sample credentials
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'), 'Juan Dela Cruz');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'juan@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'flutter123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'), 'flutter123');

    // Tap Register
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    // Expect SnackBar message and redirected to Login
    expect(find.text('Registration successful! Please log in.'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);

    // Now log in with registered credentials
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'juan@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'flutter123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Expect Welcome Screen
    expect(find.text('Welcome, Juan Dela Cruz!'), findsOneWidget);
    expect(find.text('juan@example.com'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Logout'), findsOneWidget);

    // Tap Logout
    await tester.tap(find.widgetWithText(ElevatedButton, 'Logout'));
    await tester.pumpAndSettle();

    // Expect back to Login
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
