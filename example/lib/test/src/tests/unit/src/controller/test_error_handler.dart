library;

/// Copyright 2025 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 03 March, 2025
///

import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

// Specify the name of this file
const _location = '========================== test_app_handler.dart';

/// Test for an Error occurring in the builder() function itself!
void testAppErrorHandler() {
  ///
  testWidgets('Test Error Handler', (WidgetTester tester) async {
    //
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

    final details = FlutterErrorDetails(
      exception: Exception('Fake Exception!'),
      library: 'test_app_handler.dart',
      context: ErrorDescription('Testing AppErrorHandler routine'),
    );

    handler.logErrorDetails(details);

    handler.reset();

    handler.onError(details);

    // Assign the 'old' handler
    AppErrorHandler.set(screen: handler.oldBuilder);

    // Disable the set() function from making changes again
    AppErrorHandler.allowNewErrorHandlers = false;

    // Attempting again should be unsuccessful
    set = AppErrorHandler.set(handler: errorFunction);

    // Can't be set again
    expect(set, isFalse, reason: _location);
  });
}
