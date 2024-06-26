//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

import 'open_menu.dart';

const _location = '========================== app_menu.dart';

/// Switch the app through the popupmenu
Future<void> openApplicationMenu(WidgetTester tester) async {
  /// Open popup menu
  final open = await openPopupMenu(tester);

  //
  if (!open) {
    return;
  }

  /// Switch the application
  final application =
      find.byKey(const Key('applicationMenuItem'), skipOffstage: false);

  expect(application, findsOneWidget, reason: _location);

  await tester.tap(application);

  await tester.pumpAndSettle(const Duration(milliseconds: 800));
}
