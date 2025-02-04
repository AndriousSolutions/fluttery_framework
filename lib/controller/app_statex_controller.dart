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
class AppStateXController extends StateXController
    implements ConnectivityListener {
  /// Optionally supply a 'State' object to be linked to this State Controller.
  AppStateXController([super.state]);

  /// If the device's connectivity changes.
  @override
  void onConnectivityChanged(ConnectivityResult result) {}
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
  /// Supply this version of AppStateX
  AppStateX? get appState {
    final state = super.rootState;
    return state == null ? null : state as AppStateX;
  }

  /// Supply this version of StateX
  @override
  StateX? get state {
    var state = super.state;
    if (state != null) {
      assert(() {
        if(state is AppStateX){
          debugPrint("'${state.toStringShort()}' is type, AppStateX. Should use the getter, appState, instead.");
        }
        return true;
      }());
      if (state is AppStateX) {
        state = null; // In Fluttery, AppStateX is not a subtype of this StateX
      }
    }
    return state == null ? null : state as StateX;
  }

  /// Supply this version of StateX
  @override
  StateX? stateOf<T extends StatefulWidget>() {
    var state = super.stateOf<T>();
    if (state != null) {
      assert(() {
        if(state is AppStateX){
          debugPrint("'${state.toStringShort()}' is type, AppStateX.\nIn Fluttery, use the getter, appState, instead.");
        }
        return true;
      }());
      if (state is AppStateX) {
        state = null; // In Fluttery, AppStateX is not a subtype of this StateX
      }
    }
    return state == null ? null : state as StateX;
  }

  /// Return the first State object
  @override
  StateX? get firstState {
    var state = super.firstState;
    if (state != null) {
      assert(() {
        if(state is AppStateX){
          debugPrint("Replace getter, 'firstState', with 'appState'.\nIn Fluttery, AppStateX is not type, StateX.");
        }
        return true;
      }());
      if (state is AppStateX) {
        state = null; // In Fluttery, AppStateX is not a subtype of this StateX
      }
    }
    return state == null ? null : state as StateX;
  }

  /// Return the 'latest' State object
  @override
  StateX? get lastState {
    var state = super.lastState;
    if (state != null) {
      assert(() {
        if(state is AppStateX){
          debugPrint("Replace getter, 'lastState', with 'appState'.\nIn Fluttery, AppStateX is not type, StateX.");
        }
        return true;
      }());
      if (state is AppStateX) {
        state = null; // In Fluttery, AppStateX is not a subtype of this StateX
      }
    }
    return state == null ? null : state as StateX;
  }
}