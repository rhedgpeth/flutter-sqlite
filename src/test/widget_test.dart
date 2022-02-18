// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rolodex/main.dart';

void main() {
  group('HomePage tests', ()
  {
    testWidgets('Home page loaded', (WidgetTester tester) async {
      await tester.pumpWidget(App());
      expect(find.text('Contacts'), findsOneWidget);
    });

    testWidgets('Open add user dialog test', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      expect(find.text('Add'), findsNothing);

      // Tap the group_add button
      await tester.tap(find.byIcon(Icons.group_add));
      await tester.pump();

      expect(find.text('Add'), findsOneWidget);
    });
  });
}