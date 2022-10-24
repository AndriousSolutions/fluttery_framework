//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

String _location = '========================== open_menu.dart';

///Open the PopupMenu
Future<bool> openPopupMenu(WidgetTester tester,
    {bool throwError = true}) async {
  bool opened = true;
  try {
    final popup = find.byKey(const Key('appMenuButton'), skipOffstage: false);
    expect(popup, findsOneWidget, reason: _location);
    await tester.tap(popup);
    // final app = popup.at(0);
    // await tester.tap(app);

    /// Wait for the transition in the Interface
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  } catch (err) {
    opened = false;
    collectError(err);
    if (throwError) {
      rethrow;
    }
  }
  return opened;
}
