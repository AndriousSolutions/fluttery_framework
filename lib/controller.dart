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
    show SetStateMixin, StateListener, RootState, AsyncOps;

// App's View
export '/view/app_object.dart' show App, AppDrawer;

//App's Controller & StateXController
// ignore: deprecated_member_use_from_same_package
export 'controller/app_statex_controller.dart'
    show AppStateXController, StateXController;

// Device Info
export 'controller/device_info.dart' show DeviceInfo;

// Error Handler
export 'controller/handle_error.dart' show HandleError;

/// Error Handling
export 'controller/error_handler.dart';

// Preferences
export 'package:prefs/prefs.dart' show Prefs, SharedPreferences;
