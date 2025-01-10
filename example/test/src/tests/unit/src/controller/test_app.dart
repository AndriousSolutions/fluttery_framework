library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_tests_unit_controller.dart';

Future<void> testAppController() async {
  // This class extends StateXController but implements
  // initAsync(), onAsyncError() and onConnectivityChanged()
  final app = AppStateXController();

  // Override to run any asynchronous operations before the app starts
  await app.initAsync();

  final details = FlutterErrorDetails(exception: AssertionError('Error'));

  // Override to run if initAsync() causes an error and so to recover
  app.onAsyncError(details);

  // Override to run if, for example, the phone's wifi/data is turned off.
  app.onConnectivityChanged(ConnectivityResult.none);
}
