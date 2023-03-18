import 'src/view.dart';

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() => testMyApp();

/// Also called in package's own testing file, test/widget_test.dart
void testMyApp() {
  //
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    /// Allows for SharedPreferences to be ready for testing.
    SharedPreferences.setMockInitialValues({});

    // /// MethodChannels don't work in testing. No native platform accessible
    // /// getApplicationDocumentsDirectory() is given "."
    // TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
    //     .setMockMethodCallHandler(
    //         const MethodChannel('plugins.flutter.io/path_provider'),
    //         (MethodCall methodCall) async {
    //   return ".";
    // });

    /// Never worked.
    // ///
    // TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
    //     .setMockMethodCallHandler(
    //         const MethodChannel(
    //             'dev.fluttercommunity.plus/connectivity_status'),
    //         (MethodCall methodCall) async {
    //   return Future.value(
    //       StreamController<ConnectivityResult>().stream.listen((value) {}));
    //   // return Stream<ConnectivityResult>.fromFutures([
    //   //   Future.value(ConnectivityResult.none),
    //   //   Future.value(ConnectivityResult.wifi),
    //   //   Future.value(ConnectivityResult.mobile)
    //   // ]).asyncMap((data) async {
    //   //   await Future.delayed(const Duration(seconds: 10));
    //   //   return data;
    //   // });
    // });

    // TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
    //     .setMockMethodCallHandler(
    //         const MethodChannel('dev.fluttercommunity.plus/connectivity'),
    //         (MethodCall methodCall) async {
    //   return Future.value(ConnectivityResult.none);
    // });
  });

  /// Registers a function to be run once after all tests.
  /// Be sure the close the app after all the testing.
  tearDownAll(() {});

  /// Define a test. The TestWidgets function also provides a WidgetTester
  /// to work with. The WidgetTester allows you to build and interact
  /// with widgets in the test environment.
  testWidgets('testing example app', (WidgetTester tester) async {
    //

    await tester.pumpWidget(TemplateApp());

    /// Flutter won’t automatically rebuild your widget in the test environment.
    /// Use pump() or pumpAndSettle() to ask Flutter to rebuild the widget.

    /// pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();

    final con = TemplateController();

    //
    int cnt = 1;

    while (cnt <= 3) {
      switch (con.application) {
        case 'Counter':

          /// Counter app testing
          await counterTest(tester);
          break;
        case 'Word Pairs':

          /// Random Word Pairs app
          await wordsTest(tester);
          break;
        case 'Contacts':

          /// Contacts app
          await contactsTest(tester);
          break;
      }

      /// Switch the app through the popupmenu
      await openApplicationMenu(tester);

      cnt++;
    }

    /// Open the Locale window
    await openLocaleMenu(tester);

    /// Open About menu
    await openAboutMenu(tester);

    /// Switch the Interface
    await openInterfaceMenu(tester);

    /// Unit testing does not involve integration or widget testing.

    /// WordPairs App Model Unit Testing
    await wordPairsModelTest(tester);

    /// Unit testing the App's controller object
    // await testTemplateController(tester);

    reportTestErrors();
  });
}
