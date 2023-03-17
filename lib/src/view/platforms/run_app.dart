/// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  28 Sep 2021
///
import 'dart:async' show runZonedGuarded;

import 'dart:isolate' show Isolate, RawReceivePort;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler;

import 'package:flutter/material.dart' as m
    show ErrorWidgetBuilder, Widget, runApp;

import 'package:fluttery_framework/view.dart' as v
    show AppErrorHandler, ReportErrorHandler;

/// Add an Error Handler right at the start.
// The 'error' parameters are deprecated.
void runApp(
  m.Widget app, {
  FlutterExceptionHandler? errorHandler,
  m.ErrorWidgetBuilder? errorScreen,
  v.ReportErrorHandler? errorReport,
  bool newErrorHandlers = true,
}) {
  // Instantiate the app's error handler.
  final handler = v.AppErrorHandler(newErrorHandlers: newErrorHandlers);

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

  // Catch any errors attempting to execute runApp();
  runZonedGuarded(() {
    m.runApp(app);
  }, handler.runZonedError);
}
