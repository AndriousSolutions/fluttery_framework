/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

Future<void> testAppController() async {
  //
  final app = AppController();

  await app.initAsync();

  final details = FlutterErrorDetails(exception: AssertionError('Error'));

  app.onAsyncError(details);

  app.onConnectivityChanged(ConnectivityResult.none);
}