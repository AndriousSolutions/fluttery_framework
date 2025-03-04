//
// Test files
import '_test_imports.dart';

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() => integrationTestFlutteryFramework();

void integrationTestFlutteryFramework() {
  // Call this function instead of using the 'default' TestWidgetsFlutterBinding
  // Allow for Integration testing
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('testing example app', (WidgetTester tester) async {
    // Flutter won’t automatically rebuild your widget in the test environment.
    // Use pump() or pumpAndSettle() to ask Flutter to rebuild the widget.
    await tester.pumpWidget(FlutteryExampleApp());

    // Ensure Slash screen is finished
    // pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();

    final con = AppController();

    // Counter app testing
    await counterTest(tester);

    // Multi Counter Screens testing
    await multiCountersTest(tester);

    // Test Grid app
    await animalsTest(tester);

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

    // Hot Reload the app
    final binding = WidgetsFlutterBinding.ensureInitialized();
    await binding.reassembleApplication();

    /// Wait for the transition of the Interface
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Switch the Interface
    await openInterfaceMenu(tester);

    // Unit testing
    await unitTests(tester);

    reportTestErrors();

    return;
  });
}
