// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//

import 'dart:isolate' show Isolate, RawReceivePort;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart' as m show Widget, runApp;

import '/controller.dart' as c show AppErrorHandler;

/// Add an Error Handler right at the start.
void runApp(m.Widget app) {
  // Don't call WidgetsFlutterBinding.ensureInitialized()
  // since the runApp() function itself calls it internally

  // Instantiate the app's error handler.
  final handler = c.AppErrorHandler();

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

  m.runApp(app);
}
