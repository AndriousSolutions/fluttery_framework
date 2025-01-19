//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

/// The App's State object
class FlutteryExampleApp extends AppStatefulWidget {
  ///
  FlutteryExampleApp({super.key});

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
          controller: ExampleAppController(),
          errorScreen: AppErrorHandler.displayErrorWidget,
          onUnknownRoute: AppErrorHandler.onUnknownRoute,
          useRouterConfig: false,
          // useRouterConfig: true,
          // Commented out. It will always the value 'first' passed to the parameter
          // Named parameters always takes precedence over inDebugShowCheckedModeBanner and onDebugShowCheckedModeBanner()
          // debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
          inDebugShowCheckedModeBanner: () => dev.debugShowCheckedModeBanner,
          inDebugPaintSizeEnabled: () => dev.debugPaintSizeEnabled,
          inDebugPaintBaselinesEnabled: () => dev.debugPaintBaselinesEnabled,
          inDebugPaintPointersEnabled: () => dev.debugPaintPointersEnabled,
          inDebugPaintLayerBordersEnabled: () =>
              dev.debugPaintLayerBordersEnabled,
          inDebugRepaintRainbowEnabled: () => dev.debugRepaintRainbowEnabled,
          inDebugRepaintTextRainbowEnabled: () =>
              dev.debugRepaintTextRainbowEnabled,
          inDebugShowMaterialGrid: () => dev.debugShowMaterialGrid,
          inShowPerformanceOverlay: () => dev.showPerformanceOverlay,
          inShowSemanticsDebugger: () => dev.showSemanticsDebugger,
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
          switchUI: ExampleAppController().switchUI,
          allowChangeTheme: true, // Allow the App's theme to change
          allowChangeLocale: true, // Allow the app to change locale
          allowChangeUI: true, // Allow the app to change its design interface
          inErrorHandler: (details) {
            // Retrieve the last Flutter Error that has occurred.
            // Note, the function retrieves and then 'clears' the last error from storage.
            final lastErrorDetails =
                ExampleAppController().appState?.lastFlutterError();

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
          inHome: () => ExampleAppController().onHome(),
        );

  // Development Tools Settings
  static final DevToolsController dev = DevToolsController();

  @override
  Widget? onSplashScreen(BuildContext context) =>
      App.inFlutterTest ? null : const SplashScreen();

  @override
  Map<String, WidgetBuilder>? onRoutes() => {
        '/Page01': (_) => const Page01(),
        '/Page02': (_) => const Page02(),
        '/Page03': (_) => const Page03(),
        '/Page04': (_) => const Page04(),
        '/Page05': (_) => const Page05(),
        '/Page06': (_) => const Page06(),
        '/Page07': (_) => const Page07(),
        '/Page08': (_) => const Page08(),
        '/Page09': (_) => const Page09(),
        '/Page10': (_) => const Page10(),
      };

  /// Note, will be ignored if parameter, useRouterConfig, is false or null.
  @override
  RouterConfig<Object>? onRouterConfig() => GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return (controller as ExampleAppController).onHome();
            },
          ),
          GoRoute(
            path: '/page01',
            name: '/Page01',
            builder: (_, __) => const Page01(),
          ),
          GoRoute(
            path: '/page02',
            name: '/Page02',
            builder: (_, __) => const Page02(),
          ),
          GoRoute(
            path: '/page03',
            name: '/Page03',
            builder: (_, __) => const Page03(),
          ),
          GoRoute(
            path: '/page04',
            name: '/Page04',
            builder: (_, __) => const Page04(),
          ),
          GoRoute(
            path: '/page05',
            name: '/Page05',
            builder: (_, __) => const Page05(),
          ),
          GoRoute(
            path: '/page06',
            name: '/Page06',
            builder: (_, __) => const Page06(),
          ),
          GoRoute(
            path: '/page07',
            name: '/Page07',
            builder: (_, __) => const Page07(),
          ),
          GoRoute(
            path: '/page08',
            name: '/Page08',
            builder: (_, __) => const Page08(),
          ),
          GoRoute(
            path: '/page09',
            name: '/Page09',
            builder: (_, __) => const Page09(),
          ),
        ],
        debugLogDiagnostics: true,
      );

  /// Place a breakpoint here and see how it works
  @override
  Widget build(BuildContext context) => super.build(context);

  /// Place a breakpoint in here and see how it works
  @override
  Widget builder(BuildContext context) {
    // Throw an error right here at the beginning to test recovery code.
    final appCon = controller as ExampleAppController;
    if (appCon.errorInBuilder) {
      appCon.errorInBuilder = false;
      throw Exception('Error in builder!');
    }
    return super.builder(context);
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
