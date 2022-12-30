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

import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart' show FlutterExceptionHandler, Key;

import 'package:flutter/material.dart';

import 'package:fluttery_framework/controller.dart' show Assets;

import 'package:fluttery_framework/view.dart' as v
    show App, AppState, ReportErrorHandler;

/// Export the classes needed to use this file.
export 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import 'package:prefs/prefs.dart' show Prefs;

import 'package:universal_platform/universal_platform.dart';

/// Error Screen Builder if an error occurs.
typedef ErrorWidgetBuilder = Widget Function(
    FlutterErrorDetails flutterErrorDetails);

/// The widget passed to runApp().
/// The 'App' Stateful Widget. It's the StatefulWidget for the 'App' State object.
/// extends the AppStatefulWidget found in the package, statex.
abstract class AppStatefulWidget extends StatefulWidget {
  /// The entrypoint of the framework passed to runApp()
  /// This is a StatelessWidget where you can define
  /// the loading screen or the App's error handling.
  AppStatefulWidget({
    Key? key,
    this.loadingScreen,
    this.circularProgressIndicator = true,
    FlutterExceptionHandler? errorHandler,
    ErrorWidgetBuilder? errorScreen,
    v.ReportErrorHandler? errorReport,
    bool allowNewHandlers = true,
  })  : _app = v.App(
          errorHandler: errorHandler,
          errorScreen: errorScreen,
          errorReport: errorReport,
          allowNewHandlers: allowNewHandlers,
        ),
        super(key: key ?? GlobalKey<_StateApp>()) {
    // defer displaying anything while starting up
    if (circularProgressIndicator == null || !circularProgressIndicator!) {
      WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();
    }
  } // Allows app calling app

  /// A simple screen displayed then starting up.
  final Widget? loadingScreen;

  /// Whether CircularProgressIndicator is displayed or not
  final bool? circularProgressIndicator;

  // /// Reference to the 'app' object.
  // v.App? get app => _app;
  final v.App _app;

  /// Create the app-level State object.
  v.AppState createAppState();

  /// Creates the App's State object.
  @override
  State createState() => _StateApp();
}

/// This State object sets up the App to run.
class _StateApp extends State<AppStatefulWidget> {
  //
  v.AppState? _appState;

  @override
  void initState() {
    super.initState();
    _appGlobalKey = GlobalKey<v.AppState>();
  }

  late GlobalKey _appGlobalKey;

  /// Implement from the abstract v.AppStatefulWidget to create the View!
  @override
  Widget build(BuildContext context) {
    Assets.init(context);
    return FutureBuilder<bool>(
        key: UniqueKey(), // UniqueKey() for hot reload
        future: initAsync(),
        initialData: false,
        builder: (_, snapshot) =>
            _futureBuilder(snapshot, widget.loadingScreen));
  }

  /// Runs all the asynchronous operations necessary before the app can proceed.
  Future<bool> initAsync() async {
    //
    var init = _appState != null;

    // Possibly this app's called by another app.
    if (init && !v.App.hotReload) {
      return init;
    }
    // or it's a hot reload

    init = true;

    final _widget = widget;

    try {
      /// Initialize System Preferences
      await Prefs.init();

      /// Collect installation & connectivity information
      await _widget._app.initInternal();

      /// Set theme using App's menu system if any theme was saved.
      v.App.setThemeData();

      // Create 'App State object' for this app.
      _appState = _widget.createAppState();

      // Record this State object.
      _appState?.parentState = this;

      // Supply the state object to the App object.
      _widget._app.setAppState(_appState);

      // Collect the device's information but not in certain platforms
//      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      await v.App.getDeviceInfo();
//      }

      // Perform any asynchronous operations.
      init = await _appState!.initAsync();
      //
    } catch (e) {
      init = false;
      v.App.isInit = false;
      rethrow;
    }
    return v.App.isInit = init;
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Determine if this app has been called by another app.
    final state = context.findRootAncestorStateOfType<_StateApp>();
    // Don't dispose if this app is called by another app
    disposeStatic = state == null || state == this;
    // A flag indicating if this app is called by another app
    _appInApp = state != null && state != this;
  }

  // Flag to dispose static objects
  static bool disposeStatic = true;

  // This App is within another App
  // ignore: unused_element
  static bool get appInApp => _appInApp;
  static bool _appInApp = false;

  /// Clean up resources before the app is finally terminated.
  @override
  @mustCallSuper
  void dispose() {
    // Don't dispose static references (i.e. App called an app)
    if (disposeStatic) {
      //
      Prefs.dispose();
      // Assets.init(context); called in App.build() -gp
      Assets.dispose();
      //
      widget._app.dispose();
    }
    // Remove the reference to the app's view
    _appState = null;
    //
    super.dispose();
  }

  /// Rebuild the State object
  /// and supply and new key to 'reload' the app.
  @override
  void setState(VoidCallback fn) {
    v.App.hotReload = true;
    _appGlobalKey = GlobalKey<v.AppState>();
    super.setState(() {});
  }

  /// Run the CircularProgressIndicator() until asynchronous operations are
  /// completed before the app proceeds.
  Widget _futureBuilder(AsyncSnapshot<bool> snapshot, Widget? loading) {
    //
    Widget _widget;

    if (snapshot.hasData &&
        snapshot.data! &&
        (v.App.isInit != null && v.App.isInit!)) {
      // Is the CircularProgressIndicator displayed
      final circularProgressIndicator =
          widget.circularProgressIndicator ?? false;

      if (!circularProgressIndicator) {
        WidgetsFlutterBinding.ensureInitialized().allowFirstFrame();
      }
      // Supply a GlobalKey so the 'App' State object is not disposed of if moved in Widget tree.
      _widget = _AppStatefulWidget(key: _appGlobalKey, appState: _appState!);
      //
    } else if (snapshot.hasError) {
      //
      final dynamic exception = snapshot.error;

      final details = FlutterErrorDetails(
        exception: exception,
        stack: exception is Error ? exception.stackTrace : null,
        library: 'app_statefulwidget.dart',
        context: ErrorDescription('While getting ready in FutureBuilder Async'),
      );

      var handled = false;

      if (_appState != null) {
        // May have its own error handler for Asynchronous operations.
        handled = _appState!.onAsyncError(details);
      }

      if (!handled) {
        // Have the framework handle the asynchronous error.
        widget._app.onAsyncError(snapshot);
      }
      _widget = v.App.errorHandler!.displayError(details);
      //
    } else if (snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        !snapshot.data!) {
      //
      final FlutterErrorDetails details = FlutterErrorDetails(
        exception: Exception('App failed to initialize'),
        library: 'app_statefulwidget.dart',
        context: ErrorDescription('Please, notify admin.'),
      );

      FlutterError.reportError(details);

      _widget = ErrorWidget.builder(details);
    } else {
      // //
      // Widget widget;

      if (loading != null) {
        //
        _widget = loading;
      } else {
        //
        if (UniversalPlatform.isAndroid || UniversalPlatform.isWeb) {
          //
          _widget = const Center(child: CircularProgressIndicator());
        } else {
          //
          _widget = const Center(child: CupertinoActivityIndicator());
        }
      }
//      return widget;
    }
    // Reset if there was a 'hot reload'.
    v.App.hotReload = false;

    return _widget;
  }
}

/// It's the StatefulWidget for the 'App' State object.
/// Called by the built-in FutureBuilder
class _AppStatefulWidget extends StatefulWidget {
  /// Requires its 'App' State object be passed as a parameter.
  const _AppStatefulWidget({
    super.key,
    required this.appState,
  });

  /// The framework's 'App' State object.
  final v.AppState appState;

  /// Programmatically creates the App's State object.
  @override
  //ignore: no_logic_in_create_state
  v.AppState createState() => appState;
}
