//
import '../_test_imports.dart';

String _location = '========================== counter_test.dart';

/// Testing the counter app
Future<void> counterTest(WidgetTester tester) async {
  // Retrieve the current count.
  String count = CounterController().data;
  // Verify that our counter starts at 0.
  expect(find.text(count), findsOneWidget, reason: _location);
  expect(find.text('1'), findsNothing, reason: _location);

  // 9 counts
  for (int cnt = 1; cnt <= 9; cnt++) {
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  }

  count = (int.parse(count) + 9).toString();

  // Verify that our counter has incremented.
  expect(find.text('0'), findsNothing, reason: _location);
  expect(find.text(count), findsOneWidget, reason: _location);

  final finder = find.byKey(const Key('InheritedSwitch'));

  // Tap that button.
  if (finder.evaluate().isNotEmpty) {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  // 9 counts
  for (int cnt = 1; cnt <= 9; cnt++) {
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  }

  // Retrieve the current count.
  count = CounterController().data;

  // Verify that our counter has incremented.
  expect(find.text(count), findsOneWidget, reason: _location);
}
