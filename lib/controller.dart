// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  25 Dec 2018
//
//

// Material
export 'package:flutter/material.dart' hide runApp, StateSetter;

// Cupertino
export 'package:flutter/cupertino.dart'
    hide RefreshCallback, runApp, StateSetter;

// State Object's Controller
export 'package:state_extended/state_extended.dart'
    show StateXController, SetStateMixin, StateListener, RootState, AsyncOps;

// App's View
export '/view/app.dart' show App, AppDrawer;

//App's Controller
export 'controller/app.dart' show AppController;

// Device Info
export 'controller/device_info.dart' show DeviceInfo;

// Error Handler
export 'controller/handle_error.dart' show HandleError;

/// Error Handling
export 'controller/error_handler.dart';

// Preferences
export 'package:prefs/prefs.dart' show Prefs, SharedPreferences;
