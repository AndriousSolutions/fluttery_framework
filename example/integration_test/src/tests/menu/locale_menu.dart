//
import 'package:flutter/material.dart' show Key, Scrollable, SimpleDialogOption;

import 'package:flutter_test/flutter_test.dart';

import 'open_menu.dart';

String _location = '========================== locale_menu.dart';

/// Open the Locale menu
Future<void> openLocaleMenu(WidgetTester tester) async {
  /// Open the popupmenu
  await openPopupMenu(tester);

  /// Open the Locale window
  final locale = find.byKey(const Key('localeMenuItem'));
  expect(locale, findsOneWidget, reason: _location);
  await tester.tap(locale);
  await tester.pumpAndSettle();

  /// Select a language
  await selectLanguage(tester);

  /// Close window if still open
  final button = find.widgetWithText(SimpleDialogOption, 'Cancel');
  if (button.evaluate().isNotEmpty) {
    expect(button, findsOneWidget, reason: _location);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }
}

Future<void> selectLanguage(WidgetTester tester) async {
  //
  final listFinder = find.byType(Scrollable); //, skipOffstage: false);

  expect(listFinder, findsWidgets, reason: _location);

  // Scroll until the item to be found appears.
  await tester.scrollUntilVisible(
    find.text('fr-FR'),
    500.0,
    scrollable: listFinder.last,
  );
  await tester.pumpAndSettle();

  await tester.tap(listFinder.last);
  await tester.pump();

  // Find the appropriate button even if translated.
  var button = find.widgetWithText(SimpleDialogOption, 'OK');
//  button = find.byKey(const Key('button02')); // another option

  if (button.evaluate().isNotEmpty) {
    expect(button, findsOneWidget, reason: _location);
    await tester.tap(button);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }
}
