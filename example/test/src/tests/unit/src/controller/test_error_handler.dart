library;

/// Copyright 2025 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 03 March, 2025
///

import '_tests_unit_controller.dart';

// Specify the name of this file
const _location = '========================== test_app_handler.dart';

/// Test for an Error occurring in the builder() function itself!
void testAppErrorHandler() {
  ///
  testWidgets('Test Error Handler', (WidgetTester tester) async {
    // // Tells the tester to build a UI based on the widget tree passed to it
    // await tester.pumpWidget(FlutteryExampleApp(key: UniqueKey()));
    //
    // // pumpAndSettle() waits for all animations to complete.
    // await tester.pumpAndSettle();

    final handler = AppErrorHandler();

    /// the Error Handler used in this test
    // ignore: prefer_function_declarations_over_variables
    final errorFunction = (FlutterErrorDetails details) {
      // The Fluttery Framework's error handler
      try {
        // Record the error
        handler.getError(details.exception);

        // Set the original error routine. Allows the handler to throw errors.
        FlutterError.onError = handler.oldOnError;
        //
      } catch (e, stack) {
        // Throw in DebugMode.
        if (kDebugMode) {
          // Rethrow to be handled by the original routine.
          rethrow;
        } else {
          // Record the error
          handler.reportError(e, stack);
        }
      }
    };

    // Assign the handler
    var set = AppErrorHandler.set(handler: errorFunction);

    // Successfully set
    expect(set, isTrue, reason: _location);

    final errorHandler = handler.errorHandler;

    expect(errorHandler, isA<FlutterExceptionHandler>(), reason: _location);

    expect(errorHandler == errorFunction, isTrue, reason: _location);

    final details = FlutterErrorDetails(
      exception: Exception('Fake Exception!'),
      library: 'test_app_handler.dart',
      context: ErrorDescription('Testing AppErrorHandler routine'),
    );

    handler.logErrorDetails(details);

    final widget = AppErrorHandler.displayErrorWidget(details);

    handler.reset();

    handler.onError(details);

    // Assign the handler
    AppErrorHandler.set(screen: handler.oldBuilder);

    // Disable the set() function from making changes again
    AppErrorHandler.allowNewErrorHandlers = false;

    // Attempting again should be unsuccessful
    set = AppErrorHandler.set(handler: errorFunction);

    // Can't be set again
    expect(set, isFalse, reason: _location);
  });
}
