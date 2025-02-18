//
import '../_test_imports.dart';

String _location = '========================== counter_test.dart';

/// Testing the counter app
Future<void> counterTest(WidgetTester tester) async {
  // Access thr 'Counter app' Controller object
  final con = CounterController();
  // Retrieve the current count.
  String count = con.data;
  // Verify that our counter starts at 0.
  expect(find.text(count), findsOneWidget, reason: _location);
  expect(find.text('1'), findsNothing, reason: _location);

  // Assume the AppState object is utilized in this app with the pound operator: !
  // ignore: unused_local_variable
  var appState = con.rootState!;
      appState = con.appState!;   // Another name for the 'first' State object

  // 9 counts
  for (int cnt = 1; cnt <= 9; cnt++) {
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  }

  final counter = int.parse(count);

  count = (counter + 9).toString();

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
  count = con.data;
  count = CounterController().data; // Singleton pattern traditionally used in Controllers

  // Verify that our counter has incremented.
  expect(find.text(count), findsOneWidget, reason: _location);
}
