//
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

String _location = '========================== open_drawer.dart';

/// Open a particular type of dialog window.
Future<bool> openDrawerOption(String key, WidgetTester tester) async {
  //
  final opened = await openDrawer(tester);

  if (opened) {
    //
    final finder = find.byKey(Key(key));

    expect(finder, findsOneWidget, reason: _location);

    await tester.tap(finder);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  }
  return opened;
}

/// Open the Drawer
Future<bool> openDrawer(WidgetTester tester) async {
  //
  final ScaffoldState state = tester.firstState(find.byType(Scaffold));

  expect(state, isNotNull, reason: _location);

  state.openDrawer();

  await tester.pumpAndSettle();

  return state.isDrawerOpen;
}

/// Close the Drawer
Future<bool> closeDrawer(WidgetTester tester) async {
  //
  final ScaffoldState state = tester.firstState(find.byType(Scaffold));

  expect(state, isNotNull, reason: _location);

  var close = false;

  if (state.isDrawerOpen) {
    close = true;
    state.closeDrawer();
  }

  if (state.isEndDrawerOpen) {
    close = true;
    state.closeEndDrawer();
  }

  if (close) {
    await tester.pumpAndSettle();
  }

  return close;
}
