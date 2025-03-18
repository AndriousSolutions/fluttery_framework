//
import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

///
Future<void> unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testHash(tester);

  await testAppController();

  await testDeviceInfo();

  // Files are not accessible on the Web!
  if (!UniversalPlatform.isWeb) {
    await testFiles(tester);
  }

  testHandleError(tester);

  testAppMenu(tester);

  await testAppState(tester);

  await testAppObject(tester);
}
