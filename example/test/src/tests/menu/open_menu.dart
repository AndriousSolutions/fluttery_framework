//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

String _location = '========================== open_menu.dart';

///Open the PopupMenu
Future<bool> openPopupMenu(WidgetTester tester,
    {bool throwError = true}) async {
  //
  final popup = find.byKey(const Key('appMenuButton'), skipOffstage: false);

  final opened = popup.evaluate().isNotEmpty;

  if (opened) {
    //
    expect(popup, findsOneWidget, reason: _location);

    await tester.tap(popup);

    /// Wait for the transition in the Interface
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  }
  return opened;
}
