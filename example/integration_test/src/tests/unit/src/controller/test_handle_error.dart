library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

import '../view/_unit_test_view.dart';

void testHandleError(WidgetTester tester) {
//  test('Test HandleError Mixin', () async {
  //
  final error = Exception('Error Test');

  StateXController con = ExampleAppController();

  var state = con.state;

  if (state != null && state is AppState) {
    //
    state.onError(FlutterErrorDetails(exception: error));
  }

  final details = FlutterErrorDetails(exception: error);

  con = CounterController();

  state = con.state;

  if (state != null) {
    //
    state.onError(details);
  }

//  AppErrorHandler? errorHandler = App.errorHandler;
  AppErrorHandler? errorHandler = AppErrorHandler();

//  AppErrorHandler.errorDisplayWidget(details);

//  FlutterExceptionHandler? hnd = errorHandler.onError;

  Widget? widget = errorHandler.displayError(details);

  bool mode = AppErrorHandler.inDebugMode;

  // errorHandler.reportError(error, StackTrace());
  //
  // errorHandler.isolateError(error, stack);
  //
  // errorHandler.runZonedError(error, StackTrace stack);

  final handler = HandelErrorTester();

  handler.getError(error);

  handler.getError(Exception('Test'));

  handler.errorMsg;

  handler.inError;

  handler.hasError;

  handler.getError();
//  });
}

class HandelErrorTester with HandleError {
  factory HandelErrorTester() => _this ??= HandelErrorTester._();
  HandelErrorTester._();
  static HandelErrorTester? _this;
}
