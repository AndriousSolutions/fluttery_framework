//
import 'src/model/_tests_unit_model.dart';

//
Future<void> unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testHash(tester);

  await testAppController();

  await testDeviceInfo();

  await testFiles(tester);

  testHandleError(tester);

  testAppMenu(tester);

  await testAppState(tester);

  await testAppObject(tester);
}
