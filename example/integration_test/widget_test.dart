import 'src/_test_imports.dart';

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() => integrationTestFlutteryFramework();

void integrationTestFlutteryFramework() {
  //
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    /// Allows for SharedPreferences to be ready for testing.
    SharedPreferences.setMockInitialValues({});
  });

  /// Runs after EACH test or group
  tearDown(() {});

  /// Define a test. The TestWidgets function also provides a WidgetTester
  /// to work with. The WidgetTester allows you to build and interact
  /// with widgets in the test environment.
  testWidgets('testing example app', (WidgetTester tester) async {
    //

    /// Flutter won’t automatically rebuild your widget in the test environment.
    /// Use pump() or pumpAndSettle() to ask Flutter to rebuild the widget.
    await tester.pumpWidget(FlutteryExampleApp());

    /// pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();

    final con = ExampleAppController();

    //
    int cnt = 1;

    while (cnt <= 3) {
      switch (con.application) {
        case 'Counter':

          /// Counter app testing
          await counterTest(tester);

          /// Testing its Bottom bar
          await bottomBarTests(tester);

          break;
        case 'Word Pairs':

          /// Random Word Pairs app
          await wordsTest(tester);

          /// Test dialog windows
          await dialogTests(tester);

          break;
        case 'Contacts':

          /// Contacts app
//          await contactsTest(tester);
          break;
      }

      /// Switch the app through the popupmenu
      await openApplicationMenu(tester);

      cnt++;
    }

    /// Unit testing
    await unitTests(tester);

    reportTestErrors();

    return;

    /// Switch the app through the popupmenu
    await openApplicationMenu(tester);

    /// Open About menu
    await openAboutMenu(tester);

    /// Switch the Interface
    await openInterfaceMenu(tester);

    /// WordPairs App Model Unit Testing
    await wordPairsModelTest(tester);

    return;

    /// Open the Locale window
    await openLocaleMenu(tester);
  });
}
