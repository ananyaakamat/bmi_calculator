// This is a basic Flutter widget test for the BMI Calculator app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('BMI Calculator app loads correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BMICalculatorApp());

    // Verify that the app bar title is present.
    expect(find.text('BMI Calculator'), findsOneWidget);

    // Verify that height and weight input fields are present.
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);

    // Verify that calculate button is present.
    expect(find.text('Calculate'), findsOneWidget);

    // Verify that reset button is present.
    expect(find.text('Reset'), findsOneWidget);

    // Verify that unit toggle is present.
    expect(find.text('Metric (cm/kg)'), findsOneWidget);
  });
}