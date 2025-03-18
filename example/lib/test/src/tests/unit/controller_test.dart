//
import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

String _location = '========================== controller_test.dart';

///
Future<void> testTemplateController(WidgetTester tester) async {
  //
  final con = AppController();

  con.detachedAppLifecycleState();

  await con.changeApp();

  await tester.pumpAndSettle();
}
