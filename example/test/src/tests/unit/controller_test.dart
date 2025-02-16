//
import '../../_tests_exports.dart';

String _location = '========================== controller_test.dart';

Future<void> testTemplateController(WidgetTester tester) async {
  final con = AppController();

  final app = con.application;

  expect(app, isInstanceOf<String>(), reason: _location);

  con.detachedAppLifecycleState();

  await con.changeApp('Counter');

  await tester.pumpAndSettle();

  if (!con.counterApp) {
    fail('Failed to switch app. $_location');
  }
}
