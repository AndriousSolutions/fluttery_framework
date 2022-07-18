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

//import 'package:mvc_application/controller.dart' show HandleError;

import 'package:fluttery_framework/view.dart'
    show App, ConnectivityListener, ConnectivityResult;

import 'package:state_extended/state_extended.dart';

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

  /// The 'App Level' Error Handler.
  /// Override if you like to customize your error handling.
  void onError(FlutterErrorDetails details) {
    // Call the App's 'current' error handler.
    App?.onError(details);
  }

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}
}

// /// Your 'working' class most concerned with the app's functionality.
// /// Incorporates an Error Handler.
// class StateController extends mvc.StateController with HandleError {
//   /// Optionally supply a 'State' object to be linked to this State Controller.
//   StateController([v.StateC? state]) : super(state);
//
//   /// The current StateMVC object from mvc_application/view.dart
//   v.StateC? get stateMVC => state as v.StateC?;
// }
