import '_unit_imports.dart';

//
unitTests(WidgetTester tester) async {
//
  await testAssets();

  await testAppController();

  await testDeviceInfo();

  // testGetUtils(tester);

  testHandleError(tester);

  testFiles(tester);

  testInstallFile(tester);

  testAppSettings(tester);

  testAppErrorHandler(tester);

  testFieldWidgets(tester);

  testInheritedStateWidget(tester);

  testLoadingScreen(tester);

  testHyperlink(tester);

  testWebPageWrapper(tester);

  testAppView(tester);

  testAppMenu(tester);

  testAppRouterDelegate(tester);

  testAppState(tester);

  testAppStatefulWidget(tester);
}
