/// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  20 Oct 2021
///
///

import 'package:flutter/services.dart';

import 'package:fluttery_framework/view.dart';

/// Landscape-only State object.
mixin SetOrientationLandscapeOnly<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    /// The empty list causes the application to defer to the system default.
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}

/// Portrait-only State object.
mixin SetOrientationPortraitOnly<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    /// The empty list causes the application to defer to the system default.
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}
