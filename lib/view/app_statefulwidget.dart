// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  24 Dec 2018
//

import '/controller.dart' show AppErrorHandler;

import '/model.dart';

import '/view.dart' as v; //   show App, AppState, ReportErrorHandler;

/// Export the classes needed to use this file.
export 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

/// Responsive UI
import 'package:sizer/sizer.dart' show Sizer;

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
    this.splashScreen,
    this.inSplashScreen,
    this.circularProgressIndicator,
  })  : _app = v.AppObject(),
        super(key: key ?? GlobalKey<_AppStatefulWidgetState>()) {
    // Right at the start! Initialise the binding.
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    final indicator = onCircularProgressIndicator() ?? true;
    if (!indicator) {
      // defer displaying anything while starting up
      widgetsBinding.deferFirstFrame();
    }
  }
  //
  final v.AppObject _app;

  /// The app's Splash Screen if any (called in _futureBuilder() below)
  final Widget? splashScreen;

  /// The app's SplashScreen (called in _futureBuilder() below)
  final Widget Function()? inSplashScreen;

  /// Whether CircularProgressIndicator is displayed or not
  final bool? circularProgressIndicator;

  /// Create the app-level State object.
  v.AppStateX createAppState();

  /// Creates the App's State object.
  @override
  State createState() => _AppStatefulWidgetState();

  /// The breakpoint used to determine whether the device is a mobile device or a tablet.
  double? onMaxMobileWidth() => null;

  /// The breakpoint used to determine whether the device is a tablet or a desktop.
  double? onMaxTabletWidth() => null;

  /// Supply a 'splash screen' (called in _futureBuilder() below)
  Widget? onSplashScreen(BuildContext context) =>
      inSplashScreen != null ? inSplashScreen!() : null;

  /// Display a Circular Process Indicator at start up or not
  bool? onCircularProgressIndicator() => circularProgressIndicator;
}

/// This State object sets up the App to run.
class _AppStatefulWidgetState extends State<AppStatefulWidget> {
  //
  _AppStatefulWidgetState() {
    // Best to determine if binding with the Flutter engine or not here and now.
    // May be in a test environment instead and that can be determined here.
    v.App.inWidgetsFlutterBinding;
  }
  v.AppStateX? _appState;

  @override
  void initState() {
    super.initState();
    _isAppInApp();
    _appGlobalKey = GlobalKey<v.AppStateX>();
    _assets = Assets();
  }

  late GlobalKey _appGlobalKey;
  late Assets _assets;

  /// Implement from the abstract v.AppStatefulWidget to create the View!
  @override
  Widget build(BuildContext context) {
    _assets.init(context);
    final future = initAsync();
    future.catchError(
      (Object e) {
        _appState?.catchAsyncError(e);
        // Always false. snapshot.data == false
        // snapshot.hasError likely true so ErrorWidget.builder() displayed
        return false;
      },
      // It's got to be handled, and so it's always true to call catchError()
      test: (_) => true,
    );
    return Sizer(
      builder: (_, __, ___) => FutureBuilder<bool>(
        key: UniqueKey(), // UniqueKey() for hot reload
        future: future,
        initialData: false,
        builder: (_, snapshot) => _futureBuilder(snapshot),
      ),
      maxMobileWidth: widget.onMaxMobileWidth() ?? 599,
      maxTabletWidth: widget.onMaxTabletWidth(),
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

      /// Collect installation & connectivity information
      await v.App.initInternal();

      /// Set theme using App's menu system if any theme was saved.
      v.App.setThemeData();

      // Create 'App State object' for this app.
      _appState = widget.createAppState();

      // Called within another app
      _appState?.appInApp = _appInApp;

      // Otherwise trips 'across async gaps' warning.
      if (mounted) {
        /// Finalize the app's theme if need be.
        _appState?.setThemeData(context);
        _appState?.setiOSThemeData(context);
      }

      // Supply the state object to the App object.
      v.App.appState = _appState;

      // Record this State object.
      _appState?.parentState = this;

      // Collect package and device information while testing.
      await v.App.getDeviceInfo();

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

  // Flag to dispose static objects
  static bool disposeStatic = true;

  // This App is within another App
  bool _appInApp = false;

  @override
  void activate() {
    super.activate();
    _appState?.activate();
  }

  @override
  void deactivate() {
    _appState?.deactivate();
    super.deactivate();
  }

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
    //
    _appState?.dispose();
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
    _appGlobalKey = GlobalKey<v.AppStateX>();
    super.setState(() {});
  }

  /// Run the CircularProgressIndicator() until asynchronous operations are
  /// completed before the app proceeds.
  Widget _futureBuilder(AsyncSnapshot<bool> snapshot) {
    //
    Widget appWidget;
    Widget? splashScreen;

    if (snapshot.hasData &&
        snapshot.data! &&
        (v.App.isInit != null && v.App.isInit!)) {
      // Is the CircularProgressIndicator displayed
      final circularProgressIndicator =
          widget.onCircularProgressIndicator() ?? true;

      if (!circularProgressIndicator) {
        WidgetsFlutterBinding.ensureInitialized().allowFirstFrame();
      }
      // Supply a GlobalKey so the 'App' State object is not disposed of if moved in Widget tree.
      appWidget = _AppStatefulWidget(key: _appGlobalKey, appState: _appState!);

      // Clear memory of the Splash Screen if any
      splashScreen = null;
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

      // May have its own error handler for Asynchronous operations.
      // So to possibly 'clean up' before falling out.
      _appState?.onAsyncError(details);

      // The 'inline' version of the initAsync() error handler takes last precedence.
      _appState?.inAsyncError?.call(details);

      // Have the framework handle the asynchronous error.
      widget._app.onAsyncError(snapshot);

      final handler = AppErrorHandler();

      // Display an error screen
      appWidget = handler.displayError(details);

      // Clear memory of the Splash Screen if any
      splashScreen = null;
    } else if (snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        !snapshot.data!) {
      //
      final FlutterErrorDetails details = FlutterErrorDetails(
        exception: Exception('App failed to initialize'),
        library: 'app_statefulwidget.dart',
        context: ErrorDescription('Please, notify admin.'),
      );

      // Calls FlutterError.onError() with the given details
      FlutterError.reportError(details);

      appWidget = ErrorWidget.builder(details);

      // Clear memory of the Splash Screen if any
      splashScreen = null;
    } else {
      //
      // In case the Splash Screen errors for some unknown reason.
      try {
        final widget = this.widget;
        if (widget.onCircularProgressIndicator() ?? true) {
          // Only create once!
          splashScreen ??=
              widget.splashScreen ?? widget.onSplashScreen(context);
        }
      } catch (e) {
        splashScreen = null;
      }

      if (splashScreen == null) {
        //
        if (UniversalPlatform.isAndroid || UniversalPlatform.isWeb) {
          //
          appWidget = const Center(child: CircularProgressIndicator());
        } else {
          //
          appWidget = const Center(child: CupertinoActivityIndicator());
        }
      } else {
        // A Splash Screen is displayed for a time
        appWidget = splashScreen;
      }
    }
    // Reset if there was a 'hot reload'.
    v.App.hotReload = false;

    return appWidget;
  }

  // Determine if this app has been called by another _StateApp.
  void _isAppInApp() {
    //
    final state =
        context.findRootAncestorStateOfType<_AppStatefulWidgetState>();
    // A flag indicating if this app is called by another app
    _appInApp = state != null && state != this;
    // Not called by another app
    v.App.standAloneApp = _appInApp;
    // Don't dispose if this app is called by another app
    disposeStatic = !_appInApp;
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
  final v.AppStateX appState;

  /// Programmatically creates the App's State object.
  @override
  //ignore: no_logic_in_create_state
  v.AppStateX createState() => appState;
}
