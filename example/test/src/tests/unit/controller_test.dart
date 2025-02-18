//
import '../../_tests_exports.dart';

String _location = '========================== controller_test.dart';

Future<void> testTemplateController(WidgetTester tester) async {
  final con = AppController();

  con.detachedAppLifecycleState();

  await con.changeApp();

  await tester.pumpAndSettle();
}
