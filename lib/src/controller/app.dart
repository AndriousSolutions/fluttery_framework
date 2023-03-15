///
/// Copyright (C) 2018 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  24 Dec 2018
///

import 'package:flutter/foundation.dart' show FlutterErrorDetails;

import 'package:fluttery_framework/controller.dart' show HandleError, StateXController;

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
