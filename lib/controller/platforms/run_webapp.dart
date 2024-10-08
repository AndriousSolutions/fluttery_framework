// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//

import 'package:flutter/material.dart' as m show Widget, runApp;

import '/controller.dart' as c show AppErrorHandler;

/// To change the URL strategy from hash to path
/// and remove that annoying # sign from the website's url.
import 'package:url_strategy/url_strategy.dart';

/// Add an Error Handler right at the start.
void runApp(m.Widget app) {
  // Instantiate the app's error handler.
  c.AppErrorHandler();

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();

  // Since Flutter 3.10, must now run in the 'root' zone
  m.runApp(app);
}
