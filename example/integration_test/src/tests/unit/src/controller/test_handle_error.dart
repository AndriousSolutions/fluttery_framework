/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

void testHandleError() {
//  test('Test HandleError Mixin', () async {
  //
  final handler = _HandelErrorTester();

  handler.getError(AssertionError('Error Test'));

  handler.errorMsg;

  handler.inError;

  handler.hasError;

  handler.getError();
//  });
}

class _HandelErrorTester with HandleError {}
