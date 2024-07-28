// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  24 Dec 2018
//

// The original StateXController
import 'package:state_extended/state_extended.dart' as c;

import '/view.dart';

///
/// A Controller for the 'app level'.
///
/// dartdoc:
/// {@category State Object Controller}
class AppController extends c.StateXController implements ConnectivityListener {
  /// Optionally supply a 'State' object to be linked to this State Controller.
  AppController([super.state]);

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}
}
