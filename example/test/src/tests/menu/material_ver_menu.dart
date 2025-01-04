//
import 'package:flutter/material.dart' show Key;

import 'package:flutter_test/flutter_test.dart';

import 'open_menu.dart';

const _location = '========================== material_ver_menu.dart';

/// Switch the app through the popupmenu
Future<bool> openMaterialVersionMenu(WidgetTester tester) async {
  /// Open popup menu
  var open = await openPopupMenu(tester);

  //
  if (!open) {
    return false;
  }

  /// Switch Material version
  final material =
      find.byKey(const Key('materialButtons'), skipOffstage: false);

  open = material.evaluate().isNotEmpty;

  if (open) {
    //
    expect(material, findsOneWidget, reason: _location);

    await tester.tap(material);

    await tester.pumpAndSettle(const Duration(milliseconds: 800));
  }

  return open;
}
