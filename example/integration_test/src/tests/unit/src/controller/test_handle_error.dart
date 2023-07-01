/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

void testHandleError(WidgetTester tester) {
//  test('Test HandleError Mixin', () async {
  //
  final error = AssertionError('Error Test');

  StateXController con = ExampleAppController();

  var state = con.state;

  if (state != null && state is AppState) {
    //
    state.onError(FlutterErrorDetails(exception: error));
  }

  con = CounterController();

  state = con.state;

  if (state != null && state is StateXonErrorMixin) {
    //
    state.onError(FlutterErrorDetails(exception: error));
  }

  final handler = _HandelErrorTester();

  handler.getError(error);

  handler.errorMsg;

  handler.inError;

  handler.hasError;

  handler.getError();
//  });
}

class _HandelErrorTester with HandleError {}
