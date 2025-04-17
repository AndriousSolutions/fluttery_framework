// ignore_for_file: deprecated_member_use_from_same_package
// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  24 Dec 2018
//

import '/controller.dart' show AppErrorHandler;

import '/model.dart';

import '/view.dart' as v; //   show App, AppState, ReportErrorHandler;

/// Responsive UI
import 'package:sizer/sizer.dart' show Sizer;

import 'package:universal_platform/universal_platform.dart'
    show UniversalPlatform;

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
  }) : super(key: key ?? GlobalKey<_AppStatefulWidgetState>());

  /// The app's Splash Screen if any (called in _futureBuilder() below)
  final Widget? splashScreen;

  /// The app's SplashScreen (called in _futureBuilder() below)
  final Widget Function()? inSplashScreen;

  /// Whether CircularProgressIndicator is displayed or not
  final bool? circularProgressIndicator;

  /// Create the app-level State object.
  @protected
  @factory
  v.AppStateX createAppState();

  /// Creates the App's State object.
  @override
  State createState() => _AppStatefulWidgetState();

  /// The breakpoint used to determine whether the device is a mobile device or a tablet.
  double? onMaxMobileWidth() => null;

  /// The breakpoint used to determine whether the device is a tablet or a desktop.
  double? onMaxTabletWidth() => null;

  /// Supply a 'splash screen' (called in _futureBuilder() below)
  // inSplashScreen != null ? inSplashScreen!() : null;
  Widget? onSplashScreen(BuildContext context) => inSplashScreen?.call();

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

  @override
  void initState() {
    super.initState();
    //
    // No Circular Progress Indicator
    if (!(widget.onCircularProgressIndicator() ?? true)) {
      // defer displaying anything while starting up
      WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();
    }
    // Called by another app?
    _isAppInApp();
    // _appGlobalKey = GlobalKey<v.AppStateX>();
    _assets = Assets();
  }

//  late GlobalKey _appGlobalKey;
//   late Key _appGlobalKey;
  late Assets _assets;

  /// Implement from the abstract v.AppStatefulWidget to create the View!
  @override
  Widget build(BuildContext context) {
    _assets.init(context);
    var caughtAsyncError = false; // A flag to change snapshot!!
    final future = initAsync(); // _appState is defined here!
    future.catchError(
      // May possibly recover from the error or exception
      (Object e) async =>
          caughtAsyncError = await _appState?.catchAsyncError(e) ?? false,
      // It's got to be handled, and so it's always true to call handler()
      test: (_) => true,
    );
    return FutureBuilder<bool>(
      key: UniqueKey(), // UniqueKey() for hot reload
      future: future,
      initialData: false,
      // Orientation or Hot Reload now only occurs at this point. gp
      builder: (_, snapshot) {
        // we're ignoring an error or exception.Hope you know what you're doing!
        if (caughtAsyncError) {
          snapshot =
              AsyncSnapshot<bool>.withData(snapshot.connectionState, true);
        }
        return Sizer(
          builder: (_, __, ___) => _futureBuilder(snapshot),
          maxMobileWidth: widget.onMaxMobileWidth() ?? 599,
          maxTabletWidth: widget.onMaxTabletWidth(),
        );
      },
    );
  }

  /// The 'App State Object'
  v.AppStateX? _appState;

  /// The first and constant widget of ths App.
  Widget? _appWidget;

  /// Runs all the asynchronous operations necessary before the app can proceed.
  Future<bool> initAsync() async {
    //
    var init = v.App.isInit;

    // Possibly this app's called by another app.
    if (init) {
      if (!v.App.hotReload) {
        return init;
      }
    }

    init = true;

    try {
      /// Initialize System Preferences
      await Prefs.init();

      /// Collect installation & connectivity information
      await v.App.initInternal();

      /// Set theme using App's menu system if any theme was saved.
      v.App.setThemeData();

      // A Hot Reload may have occurred
      _appState = null;
      _appState?.parentState = null; // Prevent possible memory leak

      // Create 'App State object' for this app.
      _appState = widget.createAppState();

      // Record this State object.
      _appState?.parentState = this;

      // Supply the state object to the App object.
      // v.App.hotReload is tested in here.
      v.App.appState = _appState;

      // Called within another app
      _appState?.appInApp = _appInApp;

      // Otherwise trips 'across async gaps' warning.
      if (mounted) {
        /// Finalize the app's theme if need be.
        _appState?.setThemeData(context);
        _appState?.setiOSThemeData(context);
      }

      // A Hot Reload may have occurred
      _appWidget = null;

      _appWidget = _AppStatefulWidget(
          key: GlobalObjectKey<v.AppStateX>(_appState!), appState: _appState!);

      // Collect package and device information while testing.
      await v.App.getDeviceInfo();

      // Perform any asynchronous operations.
      init = await _appState?.initAsync() ?? init;
      //
    } catch (e) {
      init = false;
      // Rethrow to _futureBuilder()
      rethrow;
    }
    return v.App.isInit = init;
  }

  // Flag to dispose static objects
  static bool disposeStatic = true;

  // This App is within another App
  bool _appInApp = false;

  /// During development, if a hot reload occurs, the reassemble method is called.
  @override
  void reassemble() {
    v.App.hotReload = true;
    super.reassemble();
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
    }
    // Clean up memory
    _appWidget = null;
    _appState = null;
    //
    super.dispose();
  }

  /// Rebuild the State object
  @override
  void setState(VoidCallback fn) {
    v.App.hotReload = true;
    super.setState(() {});
  }

  /// Run the CircularProgressIndicator() until asynchronous operations are
  /// completed before the app proceeds.
  Widget _futureBuilder(AsyncSnapshot<bool> snapshot) {
    //
    Widget appWidget;
    Widget? splashScreen;

    if (_appWidget != null && snapshot.hasData && snapshot.data!) {
      //
      if (!(widget.onCircularProgressIndicator() ?? true)) {
        // Corresponding with its deferFirstFrame();
        WidgetsFlutterBinding.ensureInitialized().allowFirstFrame();
      }

      appWidget = _appWidget!; // if (_appWidget != null

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

      final handler = AppErrorHandler();

      // The Fluttery Framework's Error Handler
      handler.flutteryExceptionHandler?.call(details);

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
      // In case the Splash Screen errors for some unknown reason.
      AppErrorHandler? handler;
      try {
        handler = AppErrorHandler();
        final widget = this.widget;
        final context = this.context;
        // Only create once!
        splashScreen ??= widget.splashScreen ??
            widget.onSplashScreen(context) ??
            _appState?.onSplashScreen(context);
      } catch (e, stack) {
        //
        splashScreen = null;
        // Record the error
        final details = FlutterErrorDetails(
          exception: e,
          stack: stack, // e is Error ? e.stackTrace : null,
          library: 'app_statefulwidget.dart',
          context: ErrorDescription('Failed with SplashScreen!'),
        );
        // Log the error
        handler?.logErrorDetails(details);
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
