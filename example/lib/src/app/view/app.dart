//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

/// App
class FlutteryExampleApp extends AppStatefulWidget {
  FlutteryExampleApp({super.key});
  // This is the 'App State object' of the application.
  @override
  AppState createAppState() => _ExampleAppState();
}

/// This is the 'View' of the application.
/// The 'look and behavior' of the app.
///
class _ExampleAppState extends AppState {
  _ExampleAppState()
      : super(
          controller: ExampleAppController(),
          inTitle: () => 'Demo App',
          debugShowCheckedModeBanner: false,
          switchUI: ExampleAppController().switchUI,
          useRouterConfig: ExampleAppController().useRouterConfig,
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
          inInitAsync: () => Future.value(true), // Merely a test.
          inInitState: () {/* Optional inInitState() function */},
          inErrorHandler: (details) {
            final errorString = details.exceptionAsString();
            if (errorString ==
                'Exception: Fake error to demonstrate error handling!') {
              assert(() {
                if (kDebugMode) {
                  debugPrint('########### Fake error caught again here.');
                }
                return true;
              }());
              return;
            }
          },
        );

  @override
  Widget onHome() => (controller as ExampleAppController).onHome();

  @override
  onOnNavigationNotification(notification) {
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

  /// Place a breakpoint to see how it's built
  @override
  Widget build(BuildContext context) => super.build(context);

  @override
  void onErrorHandler(FlutterErrorDetails details) {
    super.onErrorHandler(details);
    // An error was handled by a State object
    if (errorStateName.isNotEmpty) {
      return;
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onError(FlutterErrorDetails details) {
    // This is the app's State object's error routine.
    super.onError(details);
  }
}
