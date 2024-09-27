//
import '../../_test_imports.dart';

String _location = '========================== controller_test.dart';

Future<void> testTemplateController(WidgetTester tester) async {
  final con = ExampleAppController();

  final app = con.application;

  expect(app, isInstanceOf<String>(), reason: _location);

  con.detachedAppLifecycleState();

  con.changeApp('Counter');

  await tester.pumpAndSettle();

  if (!con.counterApp) {
    fail('Failed to switch app. $_location');
  }
}
