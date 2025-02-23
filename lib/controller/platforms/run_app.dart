// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//

import 'dart:async' show runZonedGuarded;

import 'dart:isolate' show Isolate, RawReceivePort;

import 'package:flutter/foundation.dart'
    show
        ErrorHint,
        FlutterErrorDetails,
        FlutterExceptionHandler,
        kDebugMode,
        kIsWeb;

import 'package:flutter/material.dart' as m
    show FlutterError, FlutterErrorDetails, Widget, runApp;

import '/controller.dart' as c show AppErrorHandler;

/// Add an Error Handler right at the start.
void runApp(
  m.Widget app, {
  FlutterExceptionHandler? onError,
  bool? runZoneGuard,
}) {
  // Assign an error handler (Will be replaced after)
  c.AppErrorHandler.set(handler: _RunAppErrorHandler(onError).handler);

  // Instantiate the app's error handler.
  final handler = c.AppErrorHandler();

  // Isolate is not available on the Web
  if (!kIsWeb) {
    //
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) {
      //
      if (pair is List<dynamic>) {
        final isolateError = pair;
        handler.isolateError(
          isolateError.first.toString(),
          StackTrace.fromString(isolateError.last.toString()),
        );
      }
    }).sendPort);
  }

  // Don't call WidgetsFlutterBinding.ensureInitialized()
  // since the runApp() function itself calls it internally

  // Run in a new zone with an error handler
  if (runZoneGuard ?? true) {
    // Catch any errors attempting to execute runApp();
    runZonedGuarded(() {
      m.runApp(app);
    }, handler.runZonedError);
  } else {
    m.runApp(app);
  }
}

class _RunAppErrorHandler {
  _RunAppErrorHandler([this.onError]);
  // Error handler function
  final FlutterExceptionHandler? onError;

  /// Handle any errors in this runApp().
  void handler(m.FlutterErrorDetails details) {
    // The Fluttery Framework's error handler
    final appHandler = c.AppErrorHandler();

    try {
      // Record the error
      appHandler.getError(details.exception);

      // Handle the Flutter Error Details
      handleException(appHandler, details);

      // Possibly a routine is available
      appHandler.onError(details);

      // Call the supplied error handler
      onError?.call(details);
      //
    } catch (e, stack) {
      // Throw in DebugMode.
      if (kDebugMode) {
        // Set the original error routine. Allows the handler to throw errors.
        m.FlutterError.onError = appHandler.oldOnError;
        // Rethrow to be handled by the original routine.
        rethrow;
      } else {
        // Record the error
        appHandler.reportError(e, stack);
      }
    }
  }

  /// Handle the Exception
  bool handleException(
    c.AppErrorHandler handler,
    m.FlutterErrorDetails details,
  ) {
    // ignore: prefer_final_locals
    var handled = true;
    final msg = details.exceptionAsString();
    final name = msg.split('\n').first;
    //
    switch (name) {
      case 'Zone mismatch.':
        details = FlutterErrorDetails(
          exception: details.exception,
          stack: details.stack,
          library: 'run_app.dart',
          context: ErrorHint(
            "with unnecessary call for binding.\nPlease remove call, WidgetsFlutterBinding.ensureInitialized();\nIf still required, please set the 'runZoneGuard' parameter to false: runApp(runZoneGuard: false)",
          ),
          informationCollector: details.informationCollector,
        );
      default:
      // handled = false;
    }
    // Log the error
    handler.logErrorDetails(details);
    return handled;
  }
}
