/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  24 Dec 2018
///

// The original StateXController
import 'package:state_extended/state_extended.dart' as c;

import 'package:fluttery_framework/view.dart';

///
/// A Controller for the 'app level'.
///
/// dartdoc:
/// {@category State Object Controller}
class AppController extends StateXController implements ConnectivityListener {
  /// Optionally supply a 'State' object to be linked to this State Controller.
  AppController([StateX? state]) : super(state);

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

///
///
/// dartdoc:
/// {@category State Object Controller}
/// {@category Get started}
class StateXController extends c.StateXController {
  ///
  StateXController([super.state]);

  /// Link a widget to a InheritedWidget
  @override
  bool dependOnInheritedWidget(BuildContext? context) =>
      state?.dependOnInheritedWidget(context) ?? false;

  /// Retrieve the State object by its StatefulWidget. Returns null if not found.
  @override
  StateX? stateOf<T extends StatefulWidget>() {
    final state = super.stateOf<T>();
    return state == null ? null : state as StateX;
  }

  /// Return a Set of State objects.
  @override
  Set<StateX> get states => Set.from(super.states.whereType<StateX>());
}
