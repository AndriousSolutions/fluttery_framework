//
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

String _location = '========================== open_drawer.dart';

/// Open a particular type of dialog window.
Future<bool> openDrawerOption(String key, WidgetTester tester, { bool? skipOffstage}) async {
  //
  Finder? finder;

  var opened = await openDrawer(tester);

  if (opened) {
    //
    final finder = find.byKey(Key(key), skipOffstage: skipOffstage ?? true);

    // expect(finder, findsOneWidget, reason: _location);
    opened = finder.evaluate().isNotEmpty;

    if(!opened){
      await closeDrawer(tester);
    }
  }

  if (opened) {
    //
    await tester.tap(finder!.first);

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
