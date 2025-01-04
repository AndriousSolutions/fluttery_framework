//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

import 'open_menu.dart';

const _location = '========================== app_menu.dart';

/// Switch the app through the popupmenu
Future<bool> openApplicationMenu(WidgetTester tester) async {
  /// Open popup menu
  var open = await openPopupMenu(tester);

  //
  if (!open) {
    return false;
  }

  /// Switch the application
  final application =
      find.byKey(const Key('applicationMenuItem'), skipOffstage: false);

  open = application.evaluate().isNotEmpty;

  if (open) {
    //
    expect(application, findsOneWidget, reason: _location);

    await tester.tap(application);

    await tester.pumpAndSettle(const Duration(milliseconds: 800));
  }

  return open;
}
