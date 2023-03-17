/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  24 Dec 2018
///

import 'package:flutter/foundation.dart' show FlutterErrorDetails;

import 'package:fluttery_framework/controller.dart' show StateXController;

import 'package:fluttery_framework/view.dart'
    show ConnectivityListener, ConnectivityResult, StateX;

/// A Controller for the 'app level'.
class AppController extends StateXController implements ConnectivityListener {
  /// Optionally supply a 'State' object to be linked to this State Controller.
  AppController([StateX? state]) : super(state);

  @override
  Future<bool> initAsync() async {
    /// Initialize any 'time-consuming' operations at the beginning.
    /// Initialize items essential to the Mobile Applications.
    /// Implement any asynchronous operations needed done at start up.
    return true;
  }

  @override
  bool onAsyncError(FlutterErrorDetails details) {
    /// Supply an 'error handler' routine if something goes wrong
    /// in the corresponding initAsync() routine.
    /// Returns true if the error was properly handled.
    return false;
  }

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}
}
