//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

import 'open_menu.dart';

String _location = '========================== interface_menu.dart';

/// Switch the Interface through the popupmenu
Future<bool> openInterfaceMenu(WidgetTester tester) async {
  /// Open popup menu
  await openPopupMenu(tester);

  /// Switch the Interface
  final interface = find.byKey(const Key('interfaceMenuItem'));

  // Not around if already in Cupertino Interface
  final open = interface.evaluate().isNotEmpty;

  if (open) {
    //
    expect(interface, findsOneWidget, reason: _location);

    await tester.tap(interface);
    await tester.pump();

    /// Wait for the transition of the Interface
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
  }
  return open;
}
