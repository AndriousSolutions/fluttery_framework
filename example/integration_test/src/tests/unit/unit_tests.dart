import '_unit_imports.dart';

//
unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testAppController();

  await testDeviceInfo();

  // testGetUtils(tester);

  testHandleError(tester);

  testAppSettings(tester);

  testAppErrorHandler(tester);

  testInheritedStateWidget(tester);

  testLoadingScreen(tester);

  testAppView(tester);

  testAppMenu(tester);

  testAppRouterDelegate(tester);

  testAppState(tester);

  testAppStatefulWidget(tester);
}
