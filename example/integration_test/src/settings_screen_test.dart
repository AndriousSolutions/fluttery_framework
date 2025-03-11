library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../xport/_export_tests.dart';

String _location = '========================== settings_screen_test.dart';

Future<void> testSettingsScreen(WidgetTester tester) async {
  // Open the Settings Screen
  await openSettingsScreen(tester);

  final result =
      find.byKey(const Key('AppSettings'), skipOffstage: false).evaluate();

  if (result.isNotEmpty) {
    // Test some further functionality in the Drawer object itself
    final drawer =
        result.first.findAncestorWidgetOfExactType<AppSettingsDrawer>();

    if (drawer != null) {
      //
      const widget = Text('test');

      drawer.addAll([widget]);

      drawer.remove(widget);
    }
  }

  // // Use the 'home' parameter
  // var finder = find.byKey(const Key('home'), skipOffstage: false);
  //
  // if (finder.evaluate().isNotEmpty) {
  //   // Tap that button.
  //   await tester.tap(finder);
  //   await tester.pumpAndSettle(const Duration(seconds: 1));
  // }

  // Use the 'home' parameter
  await tapButton(tester, key: 'home', skipOffstage: false);

  // // find the Debug Banner widget
  // finder = find.byKey(const Key('banner'), skipOffstage: false);
  //
  // if (finder.evaluate().isNotEmpty) {
  //   // Tap that button.
  //   await tester.tap(finder);
  //   await tester.pumpAndSettle(const Duration(seconds: 1));
  // }

  await tapButton(tester, key: 'banner', skipOffstage: false);
}

/// Open Settings Screen
Future<bool> openSettingsScreen(WidgetTester tester) async {
  //
  var finder = find.byIcon(Icons.settings, skipOffstage: false);

  var open = finder.evaluate().isNotEmpty;

  // Maybe the Cupertino version instead
  if (!open) {
    finder = find.byIcon(CupertinoIcons.settings, skipOffstage: false);
    open = finder.evaluate().isNotEmpty;
  }

  if (open) {
    // Open the Settings Screen
    await tester.tap(finder);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }

  return open;
}

///
Future<bool> settingsOption(WidgetTester tester, String? option) async {
  //
  Finder? finder;

  var select = option != null && option.isNotEmpty;

  if (select) {
    // Open the Settings Screen
    await openSettingsScreen(tester);

    // find the Debug Banner widget
    finder = find.byKey(Key(option), skipOffstage: false);

    select = finder.evaluate().isNotEmpty;
  }

  if (select) {
    // Tap that button.
    await tester.tap(finder!);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
  return select;
}
