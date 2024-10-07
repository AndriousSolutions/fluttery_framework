import 'src/_test_imports.dart';

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() => integrationTestFlutteryFramework();

void integrationTestFlutteryFramework() {
  // Allow for Integration testing
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('testing example app', (WidgetTester tester) async {
    //

    // Flutter won’t automatically rebuild your widget in the test environment.
    // Use pump() or pumpAndSettle() to ask Flutter to rebuild the widget.
    await tester.pumpWidget(FlutteryExampleApp());

    // pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();

    final con = ExampleAppController();

    //
    int cnt = 1;

    while (cnt <= 3) {
      //
      switch (con.application) {
        case 'Counter':

          // Counter app testing
          await counterTest(tester);

          // Testing its Bottom bar
          await bottomBarTests(tester);

          break;
        case 'Word Pairs':

          // Random Word Pairs app
          await wordsTest(tester);

          // Test dialog windows
          await dialogTests(tester);

          break;
      }

      // Switch the app through the popupmenu
      await openApplicationMenu(tester);

      cnt++;
    }

    // Open About menu
    await openAboutMenu(tester);

    // Open the Locale window
    await openLocaleMenu(tester);

    // Switch the Interface to Material
    await openInterfaceMenu(tester);

    if (App.useCupertino) {
      // Switch the Interface to Material
      await openInterfaceMenu(tester);
    }

    // Open Material menu
    await openMaterialVersionMenu(tester);

    // Change app to use the router
    con.useRouterConfig = true;

    // Switch the Interface
    await openInterfaceMenu(tester);

    // Unit testing
    await unitTests(tester);

    reportTestErrors();

    // // WordPairs App Model Unit Testing
    // await wordPairsModelTest(tester);
    //
    // return;
  });
}
