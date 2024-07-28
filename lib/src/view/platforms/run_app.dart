// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//
//import 'dart:async' show runZonedGuarded;

import 'dart:isolate' show Isolate, RawReceivePort;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart' as m show Widget, runApp;

import 'package:fluttery_framework/view.dart' as v show AppErrorHandler;

/// Add an Error Handler right at the start.
void runApp(m.Widget app) {
  // Don't call WidgetsFlutterBinding.ensureInitialized()
  // since the runApp() function itself calls it internally

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

  // // Catch any errors attempting to execute runApp();
  // runZonedGuarded(() {
  //   m.runApp(app);
  // }, handler.runZonedError);

  // Since Flutter 3.10, must now run in the 'root' zone
  m.runApp(app);
}
