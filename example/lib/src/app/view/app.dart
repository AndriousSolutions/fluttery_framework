//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

/// The App's State object
class FlutteryExampleApp extends AppStatefulWidget {
  ///
  FlutteryExampleApp({super.key});

  @override
  Widget? onSplashScreen(BuildContext context) =>
      App.inFlutterTest || !AppController().splashScreen
          ? null
          : const SplashScreen();

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
          controllers: [MaterialController()],
          errorScreen: AppErrorHandler.displayErrorWidget,
          onUnknownRoute: AppErrorHandler.onUnknownRoute,
          useRouterConfig: AppController().useRouterConfig,
          // Commented out.
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
          onNavigationNotification: (notification) {
            if (kDebugMode) {
              debugPrint('############ Event: onNavigationNotification()');
            }
            return notification.canHandlePop;
          },
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
          // Allow the app to change general appearance
          inErrorHandler: (details) {
            // Retrieve the last Flutter Error that has occurred.
            // Note, the function retrieves and then 'clears' the last error from storage.
            final lastErrorDetails =
                AppController().appState?.lastFlutterError();

            assert(() {
              if (lastErrorDetails != null &&
                  details.exception != lastErrorDetails.exception) {
                //
                debugPrint(
                    '=========== inErrorHandler: ${details.exceptionAsString()}');
              }
              return true;
            }());
          },
          // Programmatically determine the home page
          home: AppController().useHome ? AppController().onHome() : null,
        );

  /// Called in a function allows for UniqueKey() in StatefulWidget
  @override
  Widget? onHome() {
    Widget? home;
    if ((controller as AppController).useOnHome) {
      home = AppController().onHome();
    }
    return home;
  }

  // Development Tools Settings
  static final DevToolsController dev = DevToolsController();

  @override
  void initState() {
    super.initState();
    // Supply the standard set of Routes
    _routes = {
      '/': AppController().onHome(),
      '/Page1': const Page1(),
      '/Page2': const Page2(),
      '/Page3': const Page3(),
    };
  }

  // Supply the standard set of Routes
  late Map<String, Widget> _routes;

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

  /// Place a breakpoint in here and see how it works
  @override
  Widget builder(BuildContext context) {
    final con = controller as AppController;
    // Throw an error right here at the beginning to test recovery code.
    if (con.errorInBuilder) {
      throw Exception('Error in builder!');
    }
    return super.builder(context);
  }

  /// Determine if to switch from the 'default' platform interface
  @override
  bool? onSwitchUI() {
    //
    return (controller as AppController).switchUI;
  }

  /// Programmatically determine whether the banner is displayed or not.
  /// Place a breakpoint in your IDE and see what happens in there
  @override
  bool? onDebugShowCheckedModeBanner() => super.onDebugShowCheckedModeBanner();

  @override
  bool onOnNavigationNotification(notification) {
    if (kDebugMode) {
      debugPrint('############ Event: Navigation change.');
    }
    return notification.canHandlePop;
  }

  @override
  // ignore: unnecessary_overrides
  void onErrorHandler(FlutterErrorDetails details) {
    //
    // Retrieve the last Flutter Error that has occurred.
    final lastErrorDetails = lastFlutterErrorDetails;

    assert(() {
      if (lastErrorDetails != null &&
          details.exception == lastErrorDetails.exception &&
          lastFlutterErrorMessage ==
              'Exception: Fake error to demonstrate error handling!') {
        //
        debugPrint('=========== onErrorHandler(): $lastFlutterErrorMessage');
      } else {
        // An error in Testing?
        if (App.inFlutterTest) {
          //
          debugPrint('=========== onErrorHandler(): ${details.exception}');
        }
      }
      return true;
    }());
  }

  @override
  // ignore: unnecessary_overrides
  void onError(FlutterErrorDetails details) {
    // This is the app's State object's error routine.
    super.onError(details);
  }

  @override
  // ignore: unnecessary_overrides
  void deactivate() {
    // Place a breakpoint to see how this works
    super.deactivate();
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    // Place a breakpoint to see how this works
    super.dispose();
  }
}
