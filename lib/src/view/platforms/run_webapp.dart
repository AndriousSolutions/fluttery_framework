/// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  28 Sep 2021
///

import 'dart:async' show runZonedGuarded;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler;

import 'package:flutter/material.dart' as m
    show ErrorWidgetBuilder, Widget, runApp;

import 'package:fluttery_framework/view.dart' as v
    show AppErrorHandler, ReportErrorHandler;

/// To change the URL strategy from hash to path
/// and remove that annoying # sign from the website's url.
import 'package:url_strategy/url_strategy.dart';

/// Add an Error Handler right at the start.
void runApp(
  m.Widget app, {
  FlutterExceptionHandler? errorHandler,
  m.ErrorWidgetBuilder? errorScreen,
  v.ReportErrorHandler? errorReport,
  bool allowNewHandlers = false,
}) {
  // Instantiate the app's error handler.
  final handler = v.AppErrorHandler(
      handler: errorHandler,
      screen: errorScreen,
      report: errorReport,
      allowNewErrorHandlers: allowNewHandlers);

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();

  // Catch any errors attempting to execute runApp();
  runZonedGuarded(() {
    m.runApp(app);
  }, handler.runZonedError);
}
