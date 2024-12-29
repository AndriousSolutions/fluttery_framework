import 'src/model/_unit_test_model.dart';

//
Future<void> unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testHash(tester);

  await testAppController();

  await testDeviceInfo();

  await testFiles(tester);

  testHandleError(tester);

  testAppSettings(tester);

  // testAppErrorHandler(tester);

  // testInheritedStateWidget(tester);

  // testLoadingScreen(tester);

  testAppMenu(tester);

  // testAppRouterDelegate(tester);

  await testAppState(tester);

  // testAppStatefulWidget(tester);

  await testAppObject(tester);
}
