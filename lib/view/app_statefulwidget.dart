/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  24 Dec 2018
///

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:fluttery_framework/controller.dart' show Assets;

import 'package:fluttery_framework/view.dart'
    as v; //   show App, AppState, ReportErrorHandler;

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
///
/// {@category Get started}
/// {@category App's Preferences}
/// {@category Error handling}
abstract class AppStatefulWidget extends StatefulWidget {
  /// The entrypoint of the framework passed to runApp()
  /// This is a StatelessWidget where you can define
  /// the loading screen or the App's error handling.
  AppStatefulWidget({
    Key? key,
    this.loadingScreen,
    this.circularProgressIndicator = true,
    @Deprecated("The 'error' parameter is deprecated.")
    bool? allowNewHandlers = true,
  })  : _app = v.AppObject(),
        super(key: key ?? GlobalKey<_StateApp>()) {
    // defer displaying anything while starting up
    if (circularProgressIndicator == null || !circularProgressIndicator!) {
      WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();
    }
  }
  //
  final v.AppObject _app;

  /// A simple screen displayed then starting up.
  final Widget? loadingScreen;

  /// Whether CircularProgressIndicator is displayed or not
  final bool? circularProgressIndicator;

  /// Create the app-level State object.
  v.AppState createAppState();

  /// Creates the App's State object.
  @override
  State createState() => _StateApp();
}

/// This State object sets up the App to run.
class _StateApp extends State<AppStatefulWidget> {
  //
  _StateApp() {
    // Best to determine if binding with the Flutter engine or not here and now.
    // May be in a test environment instead and that can be determined here.
    v.App.inWidgetsFlutterBinding;
  }
  v.AppState? _appState;

  @override
  void initState() {
    super.initState();
    _appGlobalKey = GlobalKey<v.AppState>();
    _assets = Assets();
  }

  late GlobalKey _appGlobalKey;
  late Assets _assets;

  /// Implement from the abstract v.AppStatefulWidget to create the View!
  @override
  Widget build(BuildContext context) {
    _assets.init(context);
    return FutureBuilder<bool>(
      key: UniqueKey(), // UniqueKey() for hot reload
      future: initAsync(),
      initialData: false,
      builder: (_, snapshot) => _futureBuilder(snapshot, widget.loadingScreen),
    );
  }

  /// Runs all the asynchronous operations necessary before the app can proceed.
  Future<bool> initAsync() async {
    //
    var init = _appState != null;

    // Possibly this app's called by another app.
    if (init && !v.App.hotReload) {
      return init;
    }

    init = true;

    try {
      /// Initialize System Preferences
      await Prefs.init();

      if (!v.App.inFlutterTest) {
        /// Collect installation & connectivity information
        await v.App.initInternal();
      }

      /// Set theme using App's menu system if any theme was saved.
      v.App.setThemeData();

      // Create 'App State object' for this app.
      _appState = widget.createAppState();

      // Supply the state object to the App object.
      v.App.appState = _appState;

      // Record this State object.
      _appState?.parentState = this;

      // Don't collect package and device information while testing.
      if (!v.App.inFlutterTest) {
        //
        await v.App.getDeviceInfo();
      }

      // Perform any asynchronous operations.
      init = await _appState!.initAsync();
      //
    } catch (e) {
      init = false;
      v.App.isInit = false;
      // Rethrow to _futureBuilder()
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
    // Not called by another app
    v.App.standAloneApp = _appInApp;
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

      //
      _assets.dispose();

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

      if (_appState != null) {
        // May have its own error handler for Asynchronous operations.
        // So to possibly 'clear up' before falling out.
        _appState!.onAsyncError(details);
      }

      // Have the framework handle the asynchronous error.
      widget._app.onAsyncError(snapshot);

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
      //
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
