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

  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize items essential to the Mobile Applications.
  /// Implement any asynchronous operations needed done at start up.
  @override
  Future<bool> initAsync() async {
    return true;
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  /// Returns true if the error was properly handled.
  @override
  bool onAsyncError(FlutterErrorDetails details) {
    return false;
  }

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}
}
