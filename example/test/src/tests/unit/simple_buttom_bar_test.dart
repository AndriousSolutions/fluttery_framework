//
import '_tests_unit_exports.dart';

// ignore: unused_element
const _location = '========================== simple_buttom_bar_test.dart';

//
Future<void> bottomBarTests(WidgetTester tester) async {
  //
  await _tapBottomBar('HomeBottomBarButton', tester);

  await _tapBottomBar('StatsBottomBarButton', tester);

  await _tapBottomBar('EventsBottomBarButton', tester);

  await _tapBottomBar('HistoryBottomBarButton', tester);
}

/// Open a particular type of dialog window.
Future<void> _tapBottomBar(String key, WidgetTester tester) async {
  //
  final finder = find.byKey(Key(key));

  if (finder.evaluate().isNotEmpty) {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
