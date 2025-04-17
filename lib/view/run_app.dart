// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  28 Sep 2021
//

// At times, you may need to explicitly supply the custom runApp function:
//
//       import 'package:fluttery_framework/run_app.dart';
//
// Otherwise, it's supplied by the view.dart export file.

export '/controller/platforms/run_app.dart'
    if (dart.library.html) '/controller/platforms/run_webapp.dart' show runApp;
