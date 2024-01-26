/// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  02 Oct 2020
///
///

/// Merely a 'stub' used by conditional import and export statements.

import 'package:flutter/material.dart' show ErrorWidgetBuilder, Widget;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler;

import '/view.dart' show ReportErrorHandler;

/// Used in the conditional export statement:
/// Found in 'package:fluttery_framework/view.dart'
/// For example:
/// export 'package:fluttery_framework/src/conditional_export.dart'
/// if (dart.library.html) 'package:flutter/material.dart'
/// if (dart.library.io) 'package:fluttery_framework/src/controller/app.dart' show runApp;

/// This of course is fake. Merely to satisfy the Dart Analysis tool.
/// if (dart.library.html) 'package:fluttery_framework/src/view/platforms/run_webapp.dart'
/// if (dart.library.io) 'package:fluttery_framework/src/view/platforms/run_app.dart'
void runApp(
  Widget app, {
  FlutterExceptionHandler? errorHandler,
  ErrorWidgetBuilder? errorScreen,
  ReportErrorHandler? errorReport,
  bool allowNewHandlers = false,
}) {}
