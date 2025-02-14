// ignore_for_file: unused_local_variable
library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_tests_unit_controller.dart';

import '../view/_tests_unit_view.dart';

void testHandleError(WidgetTester tester) {
  //
  final error = Exception('Error Test');

  StateXController con = AppController();

  final appState = con.appState;

  if (appState != null) {
    //
    appState.onError(FlutterErrorDetails(exception: error));
  }

  final details = FlutterErrorDetails(exception: error);

  con = CounterController();

  final state = con.state;

  if (state != null) {
    //
    state.onError(details);
  }

  final AppErrorHandler errorHandler = AppErrorHandler();

  AppErrorHandler.inDebugMode;

  AppErrorHandler.presentError;

  AppErrorHandler.presentError = true;

  errorHandler.oldBuilder;

  errorHandler.oldOnError;

  AppErrorHandler.displayErrorWidget(details);

//  FlutterExceptionHandler? hnd = errorHandler.onError;

  final Widget widget = errorHandler.displayError(details);

  final bool mode = AppErrorHandler.inDebugMode;

  errorHandler.reportError(error, StackTrace.empty);

  errorHandler.isolateError(error, StackTrace.empty);

  errorHandler.runZonedError(error, StackTrace.empty);

  errorHandler.activate();

  final handler = HandelErrorTester();

  handler.getError(error);

  handler.getError(Exception('Test'));

  handler.errorMsg;

  handler.inError;

  handler.hasError;

  handler.getError();
}

class HandelErrorTester with HandleError {
  factory HandelErrorTester() => _this ??= HandelErrorTester._();
  HandelErrorTester._();
  static HandelErrorTester? _this;
}
