import 'src/model/_unit_test_model.dart';

//
unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testHash(tester);

  await testAppController();

  await testDeviceInfo();

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
