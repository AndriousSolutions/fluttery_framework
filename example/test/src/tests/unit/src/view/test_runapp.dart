// ignore_for_file: unused_local_variable
import '_tests_unit_view.dart';

// Specify the name of this file
const _location = '========================== test_app_handler.dart';

/// Test the built-in runApp() routine.
void testRunAppRoutine() {
  ///
  testWidgets('Test built-in runApp() routine', (WidgetTester tester) async {
    // First instantiate Fluttery's Error Handler
    final handler = AppErrorHandler();

    // Execute runApp() to set an Error Handler
    runApp(
      const MaterialApp(
        title: 'Material App',
        home: Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        ),
      ),
    );

    // pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final details = FlutterErrorDetails(
      exception: Exception('Fake Exception!'),
      library: 'test_runapp.dart',
      context: ErrorDescription('Test built-in runApp() routine'),
    );

    // Test the assigned handler
    FlutterError.reportError(details);

    // Restores an Error Handler
    handler.deactivate();

    // Execute runApp() to set an Error Handler
    runApp(
      const MaterialApp(
        title: 'Material App',
        home: Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        ),
      ),
      runZoneGuard: false,
    );

    // Restores an Error Handler
    handler.deactivate();
  });
}
