// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//

import 'dart:async' show runZonedGuarded;

import 'package:flutter/foundation.dart'
    show FlutterExceptionHandler, kDebugMode;

import 'package:flutter/material.dart' as m
    show FlutterError, FlutterErrorDetails, Widget, runApp;

import '/controller.dart' as c show AppErrorHandler;

/// To change the URL strategy from hash to path
/// and remove that annoying # sign from the website's url.
import 'package:flutter_web_plugins/url_strategy.dart';

/// Add an Error Handler right at the start.
void runApp(
  m.Widget app, {
  FlutterExceptionHandler? onError,
  bool? runZoneGuard,
}) {
  // Ignore runZoneGuard gp
  // Instantiate the app's error handler.
  final handler = c.AppErrorHandler();

  // Assign an error handler (Will be replaced after)
  c.AppErrorHandler.set(handler: _RunWebAppErrorHandler(onError).handler);

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  if (urlStrategy is! PathUrlStrategy) {
    usePathUrlStrategy();
  }

  // Run in a new zone with an error handler
  if (runZoneGuard ?? false) {
    // Catch any errors attempting to execute runApp();
    runZonedGuarded(() {
      m.runApp(app);
    }, handler.runZonedError);
  } else {
    // Since Flutter 3.10, must now run in the 'root' zone
    m.runApp(app);
  }
}

class _RunWebAppErrorHandler {
  _RunWebAppErrorHandler([this.onError]);

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
      appHandler.handleException(details);

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
}
