//
import 'package:flutter/material.dart' show Key, Scrollable;

import 'package:flutter_test/flutter_test.dart';

String _location = '========================== scroll_navigation_screen.dart';

Future<bool> scrollToTap(WidgetTester tester, String text, {int? index}) async {
  //
  final scrollFinder = find.byType(Scrollable); //, skipOffstage: false);

  final typeLength = scrollFinder.evaluate().length;

  // Found
  var tap = typeLength > 0;

  if (tap) {
    //
    if (index != null) {
      //
      tap = index >= 0;

      if (tap) {
        tap = index <= typeLength - 1;
      }
    }
  }

  if (tap) {
    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      find.text(text.trim()),
      500,
      scrollable: scrollFinder.at(index ?? 0), // Assume first
    );
    await tester.pumpAndSettle();

    await tester.tap(scrollFinder.last);
    await tester.pump();
  }

  return tap;

  // // Find the appropriate button even if translated.
  // // final button = find.widgetWithText(SimpleDialogOption, 'OK');
  // final button = find.byKey(const Key('button02')); // another option
  //
  // if (button.evaluate().isNotEmpty) {
  //   expect(button, findsOneWidget, reason: _location);
  //   await tester.tap(button);
  //   await tester.pumpAndSettle(const Duration(seconds: 5));
  // }
}
