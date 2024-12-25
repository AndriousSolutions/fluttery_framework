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
@Deprecated('Use AppStateXController instead.')
class AppController extends AppStateXController {}

///
/// A Controller for the 'app level'.
///
/// dartdoc:
/// {@category State Object Controller}
class AppStateXController extends StateXController
    implements ConnectivityListener {
  /// Optionally supply a 'State' object to be linked to this State Controller.
  AppStateXController([super.state]);

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}

  /// Returns the 'first' StateX object in the App
  @override
  AppStateX? get rootState => super.rootState as AppStateX;
}

/// Your 'working' class most concerned with the app's functionality.
/// Add it to a 'StateX' object to associate it with that State object.
///
/// dartdoc:
/// {@category Testing}
/// {@category Get started}
/// {@category Event handling}
/// {@category State Object Controller}
class StateXController extends c.StateXController {
  ///
  StateXController([super.state]);
  /// Returns the 'first' StateX object in the App
  @override
  AppStateX? get rootState => super.rootState as AppStateX;
}
