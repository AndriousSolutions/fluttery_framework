//
import 'src/_test_imports.dart';

String _location = '========================== test_navigation.dart';

/// Testing the counter app
Future<void> appNavigationTest(WidgetTester tester) async {
  //
  final opened = await openDrawerOption('Navigation', tester);

  if (!opened) {
    return;
  }

  final con = NavController();

  await tapButton(tester, key: 'Next Page', count: 2);

  final title = (con.state as NavState).title;

  var key = 'canPopWidget$title';

  await tapButton(tester, key: key);

  expect(find.byKey(Key('${key}Text')), findsOneWidget, reason: _location);

  /// Retreat back and exit the screen
  await tapButton(tester, key: 'Prev Page', keyUntil: 'Exit');

  await closeDrawer(tester);
}
