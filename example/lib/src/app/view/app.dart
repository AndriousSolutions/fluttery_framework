// ignore_for_file: unnecessary_overrides

import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

/// The App's State object
class FlutteryExampleApp extends AppStatefulWidget {
  ///
  FlutteryExampleApp({super.key});

  // /// Readily supply a Splash Screen to your app.
  // @override
  // Widget? onSplashScreen(BuildContext context) {
  //   Widget? widget;
  //   widget = const SplashScreen(); // Comment out and see what happens
  //   // When testing, a Splash Screen will interfere and so is excluded.
  //   return App.inFlutterTest ? null : widget;
  // }

  @override
  AppStateX<StatefulWidget> createAppState() => _ExampleAppState();
}

/// This is the 'View' of the application.
/// The 'look and behavior' of the app.
///
class _ExampleAppState extends AppStateX<FlutteryExampleApp> {
  _ExampleAppState()
      : super(
          title: 'Fluttery Demo App',
          controller: AppController(),
          errorHandler: AppErrorHandler.errorHandler,
          errorScreen: AppErrorHandler.displayErrorWidget,
          inUnknownRoute: AppErrorHandler.onUnknownRoute,
          useRouterConfig: AppController().useRouterConfig,
          inGenerateRoute: AppController().onGenerateRoute,
          // Named parameters always takes precedence over inDebugShowCheckedModeBanner and onDebugShowCheckedModeBanner()
          // debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
          inDebugShowCheckedModeBanner: () => dev.debugShowCheckedModeBanner,
          inDebugShowMaterialGrid: () => dev.debugShowMaterialGrid,
          inShowPerformanceOverlay: () => dev.showPerformanceOverlay,
          inShowSemanticsDebugger: () => dev.showSemanticsDebugger,
          inDebugPaintSizeEnabled: () => dev.debugPaintSizeEnabled,
          inDebugPaintBaselinesEnabled: () => dev.debugPaintBaselinesEnabled,
          inDebugPaintPointersEnabled: () => dev.debugPaintPointersEnabled,
          inDebugPaintLayerBordersEnabled: () =>
              dev.debugPaintLayerBordersEnabled,
          inDebugRepaintRainbowEnabled: () => dev.debugRepaintRainbowEnabled,
          inDebugRepaintTextRainbowEnabled: () =>
              dev.debugRepaintTextRainbowEnabled,
          inDebugPrintRebuildDirtyWidgets: () =>
              dev.debugPrintRebuildDirtyWidgets,
          inDebugOnRebuildDirtyWidget: dev.debugOnRebuildDirtyWidget
              ? dev.onDebugOnRebuildDirtyWidget
              : null,
          inDebugPrintBuildScope: () => dev.debugPrintBuildScope,
          inDebugPrintScheduleBuildForStacks: () =>
              dev.debugPrintScheduleBuildForStacks,
          inDebugPrintGlobalKeyedWidgetLifecycle: () =>
              dev.debugPrintGlobalKeyedWidgetLifecycle,
          inDebugProfileBuildsEnabled: () => dev.debugProfileBuildsEnabled,
          inDebugProfileBuildsEnabledUserWidgets: () =>
              dev.debugProfileBuildsEnabledUserWidgets,
          inDebugEnhanceBuildTimelineArguments: () =>
              dev.debugEnhanceBuildTimelineArguments,
          inDebugHighlightDeprecatedWidgets: () =>
              dev.debugHighlightDeprecatedWidgets,
          inSupportedLocales: () {
            /// The app's translations
            L10n.translations = {
              const Locale('zh', 'CN'): zhCN,
              const Locale('fr', 'FR'): frFR,
              const Locale('de', 'DE'): deDE,
              const Locale('he', 'IL'): heIL,
              const Locale('ru', 'RU'): ruRU,
              const Locale('es', 'AR'): esAR,
            };
            return L10n.supportedLocales;
          },
          localizationsDelegates: [
            L10n.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          allowChangeLocale: true,
          // Allow the app to change locale
          allowChangeUI: true,
          // Allow the app to change its design interface
          allowChangeTheme: true,
          // While debugging, prints out event function calls
          printEvents: true,
          // Supply an Error Handler right in the initialization
          inErrorHandler: (details) {
            //
            debugPrint(
                "============  Event: inErrorHandler() '${details.exceptionAsString()}' in instance of _ExampleAppState");
          },
          // Determine if the error in initAsync() is caught nor not
          inCatchAsyncError: (error) async {
            final message = error.toString().split(': ').last;
            debugPrint(
                "============  Event: inCatchAsyncError() '$message' in instance of _ExampleAppState");
            return false;
          },
          inAsyncError: (error) async {
            final message = error.toString().split(': ').last;
            debugPrint(
                "============  Event: inCatchAsyncError() '$message' in instance of _ExampleAppState");
          },
          // Programmatically determine the home page
          home: AppController().useHome ? const CounterPage() : null,
        );

  /// Place a breakpoint in here and see how it works
  /// Used to complete asynchronous operations
  @override
  Future<bool> initAsync() async {
    return super.initAsync();
  }

  /// Place a breakpoint in here and see how it works
  /// This is a State class and so has an initState() function
  @override
  void initState() {
    super.initState();
    // Supply the standard set of Routes
    // There's the Singleton approach
    _routes = AppController().routes;
    //There's casting the property appropriately
    _routes = (controller as AppController).routes;
  }

  // Supply the standard set of Routes
  late Map<String, Widget> _routes;

  /// Place a breakpoint in here and see how it works
  @override
  void deactivate() {
    super.deactivate();
  }

  /// Place a breakpoint in here and see how it works
  @override
  void dispose() {
    super.dispose();
  }

  /// Place a breakpoint in here and see how it works
  /// Called in a function allows for UniqueKey() in StatefulWidget
  @override
  Widget? onHome() {
    Widget? home;
    final appController = controller as AppController;
    // In case, during testing, the 'onHome' function setting is not on
    if (App.inFlutterTest &&
        !appController.useOnHome &&
        !appController.useRoutes) {
      appController.setForOnHome();
    }

    if (appController.useOnHome) {
      home = CounterPage(
        key: UniqueKey(), //  UniqueKey() for built-in InheritedWidget
      );
    }
    return home;
  }

  // Development Tools Settings
  static final DevToolSettingsController dev = DevToolSettingsController();

  /// Place a breakpoint in here and see how it works
  /// Note, will be ignored if parameter, useRouterConfig, is false or null.
  @override
  RouterConfig<Object>? onRouterConfig() {
    final routes = <RouteBase>[];
    for (final route in _routes.entries) {
      routes.addAll(
        [
          GoRoute(
            path: route.key,
            name: route.key,
            builder: (_, __) => route.value,
          )
        ],
      );
    }
    return GoRouter(
      routes: routes,
      debugLogDiagnostics: true,
    );
  }

  /// Place a breakpoint in here and see how it works
  @override
  Map<String, WidgetBuilder>? onRoutes() {
    //
    final con = controller as AppController;
    // If home parameter is used, remove from Map
    if (!con.useRoutes) {
      _routes.remove(Navigator.defaultRouteName);
    }

    final routes = <String, WidgetBuilder>{};

    for (final route in _routes.entries) {
      routes.addAll({route.key: (_) => route.value});
    }
    return routes;
  }

  /// Place a breakpoint here and see how it works
  @override
  Widget build(BuildContext context) => super.build(context);

  /// Programmatically determine whether the banner is displayed or not.
  /// Place a breakpoint in your IDE and see what happens in there
  @override
  bool? onDebugShowCheckedModeBanner() => super.onDebugShowCheckedModeBanner();

  /// Determine if initAsync() error or exception is caught or not
  @override
  Future<bool> onCatchAsyncError(Object error) async {
    //
    debugPrint('============ Event: onCatchAsyncError() in $this');

    //
    final message = error.toString().split(': ').last;

    bool caught;

    switch (message) {
      case 'Fake error to demonstrate error handling!':
        caught = true;
        break;
      case 'Error in initAsync()!':
        caught = true;
        break;
      case 'Error in App initAsync()!':
        caught = true;
        break;
      case 'Error in builder!':
        caught = true;
        break;
      default:
        caught = false;
    }
    return caught;
  }

  // Your App's State object's Error Routine
  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);
    //
    debugPrint('============ Event: onError() in $this');

    final name = details.exceptionAsString().split(': ').last;
    //
    switch (name) {
      case 'Fake error to demonstrate error handling!': // Button pressed
        break;
      case 'Error in builder!':
        //
        // (controller as AppController).errorInBuild = false;
        break;
    }
  }

  /// initAsync() has failed.
  @override
  void onAsyncError(FlutterErrorDetails details) {
    //
    debugPrint('============ Event: onAsyncError() in $this');
  }

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    ///  You've three options to generate a route:
    ///  parameter inGenerateRoute, onGenerateRoute(), and the parameter, generateRoute
    ///  In this example app the 'inline' version is used:
    ///  inGenerateRoute: AppController().onGenerateRoute
    ///
    ///  The parameter, generateRoute, takes top priority and is to supply
    ///  a Route object right at startup.
    ///  This function is next if no parameter is supplied, and if not defined either,
    ///  the 'inline' function version is checked
    ///
    /// Uncomment the line below and place a breakpoint in onUnknownRoute() below.
    /// DON'T FORGET TO UNCOMMENT THE LINE AGAIN!
    // return null;
    return super.onGenerateRoute(settings);

    /// If no Route is defined by now, your 'unknown' route will be displayed.
    /// In your favorite IDE, place a breakpoint in onUnknownRoute() below:
  }

  @override
  Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return super.onUnknownRoute(settings);
  }
}
