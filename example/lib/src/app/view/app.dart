//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

/// The App's State object
class FlutteryExampleApp extends AppStatefulWidget {
  ///
  FlutteryExampleApp({super.key})
      : super(
        // splashScreen: const SplashScreen(),   // three ways to present a Splash screen
        // inSplashScreen: () => const SplashScreen(),
        );

  // This is the 'App State object' of the application.
  @override
  AppStateX<FlutteryExampleApp> createAppState() => _ExampleAppState();

  @override
  Widget? onSplashScreen(BuildContext context) =>
      App.inFlutterTest ? const SplashScreen() : null;
}

/// This is the 'View' of the application.
/// The 'look and behavior' of the app.
///
class _ExampleAppState extends AppStateX<FlutteryExampleApp> {
  _ExampleAppState()
      : super(
          controller: ExampleAppController(),
          inTitle: () => 'Demo App',
          switchUI: ExampleAppController().switchUI,
          useRouterConfig: ExampleAppController().useRouterConfig,
          errorScreen: defaultErrorWidgetBuilder,
          onNavigationNotification: (notification) {
            if (kDebugMode) {
              debugPrint('############ Event: onNavigationNotification()');
            }
            return notification.canHandlePop;
          },
          onUnknownRoute: (settings) {
            Route<dynamic>? route;
            if (kDebugMode) {
              debugPrint('############ Event: onUnknownRoute()');
            }
            return route;
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
          allowChangeTheme: true, // Allow the App's theme to change
          allowChangeLocale: true, // Allow the app to change locale
          allowChangeUI: true, // Allow the app to change its design interface
          inInitAsync: () => Future.value(true), // Demonstration purposes
          inInitState: () {/* Optional inInitState() function */},
          inErrorHandler: (details) {
            //
            final appState = App.appState!;
            // You see? appState is this object!
            assert(() {
              if (appState is _ExampleAppState) {
                debugPrint(
                    '=========== inErrorHandler: appState is _ExampleAppState');
              }
              return true;
            }());

            // Retrieve the last Flutter Error that has occurred.
            var lastErrorDetails = appState.lastFlutterErrorDetails;

            // Retrieve the last Flutter Error that has occurred.
            // Note, this function retrieves and then 'clears' the last error from storage.
            lastErrorDetails = appState.lastFlutterError();

            // This, of course, will be the same. It's this very error that's caught here.
            if (details == lastErrorDetails) {
              debugPrint(
                  '=========== inErrorHandler: details == lastErrorDetails');
            }
          },
        );

  @override
  Widget onHome() => (controller as ExampleAppController).onHome();

  /// Programmatically determine whether the banner is diaplayed or not.
  @override
  bool onDebugShowCheckedModeBanner() => false;

  @override
  bool onOnNavigationNotification(notification) {
    if (kDebugMode) {
      debugPrint('############ Event: Navigation change.');
    }
    return notification.canHandlePop;
  }

  @override
  RouterConfig<Object>? onRouterConfig() => GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return onHome();
            },
          ),
          // GoRoute(
          //   path: '/add',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const AddContact();
          //   },
          // ),
        ],
      );

  @override
  Map<String, WidgetBuilder>? onRoutes() => {
    '/Page01': (_) => Page01(this),
    '/Page02': (_) => Page02(this),
    '/Page03': (_) => Page03(this),
    '/Page04': (_) => Page04(this),
    '/Page05': (_) => Page05(this),
    '/Page06': (_) => Page06(this),
    '/Page07': (_) => Page07(this),
    '/Page08': (_) => Page08(this),
    '/Page09': (_) => Page09(this),
    '/Page10': (_) => Page10(this),
  };

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

  @override
  // ignore: unnecessary_overrides
  void onErrorHandler(FlutterErrorDetails details) {
    //
    final appState = App.appState!;
    // You see? appState is this object!
    assert(() {
      // ignore: unnecessary_type_check
      if (this is _ExampleAppState && appState is _ExampleAppState) {
        debugPrint(
            '=========== onErrorHandler: this is _ExampleAppState && appState is _ExampleAppState');
      }
      return true;
    }());

    // Retrieve the last Flutter Error that has occurred.
    var lastErrorDetails = lastFlutterErrorDetails;

    // You see? appState is this object!
    assert(() {
      if (lastErrorDetails != null &&
          details.exception == lastErrorDetails.exception &&
          lastFlutterErrorMessage ==
              'Exception: Fake error to demonstrate error handling!') {
        debugPrint(
            '=========== onErrorHandler(): details.exception == lastErrorDetails.exception');
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
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return super.updateShouldNotify(oldWidget);
  }

  @override
  // ignore: unnecessary_overrides
  bool dependOnInheritedWidget(BuildContext? context) {
    return super.dependOnInheritedWidget(context);
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
