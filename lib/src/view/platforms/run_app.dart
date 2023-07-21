/// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  28 Sep 2021
///
import 'dart:async' show runZonedGuarded;

import 'dart:isolate' show Isolate, RawReceivePort;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler, kIsWeb;

import 'package:flutter/material.dart' as m
    show ErrorWidgetBuilder, Widget, runApp;

import 'package:fluttery_framework/view.dart' as v
    show AppErrorHandler, ReportErrorHandler;

/// Add an Error Handler right at the start.
void runApp(
  m.Widget app, {
  @Deprecated("The 'error' parameters are deprecated.")
  FlutterExceptionHandler? errorHandler,
  @Deprecated("The 'error' parameters are deprecated.")
  m.ErrorWidgetBuilder? errorScreen,
  @Deprecated("The 'error' parameters are deprecated.")
  v.ReportErrorHandler? errorReport,
  @Deprecated("The 'error' parameters are deprecated.")
  bool newErrorHandlers = true,
}) {
  // Instantiate the app's error handler.
  final handler = v.AppErrorHandler();

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

  // Catch any errors attempting to execute runApp();
  runZonedGuarded(() {
    m.runApp(app);
  }, handler.runZonedError);
}
