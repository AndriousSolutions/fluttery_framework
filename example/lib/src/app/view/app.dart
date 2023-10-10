//
import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/model.dart';

import 'package:fluttery_framework_example/src/view.dart';

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
          controllers: [CounterController()],
          inTitle: () => 'Demo App',
          inDebugShowCheckedModeBanner: () => false,
          switchUI: Prefs.getBool('switchUI'),
          useRouterConfig: false,
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
          allowChangeLocale: true, // Allow the app to change locale
          allowChangeUI: true, // Allow the app to change its design interface
          inInitAsync: () => Future.value(true), // Merely a test.
          inInitState: () {/* Optional inInitState() function */},
        );

  @override
  Widget onHome() => ExampleAppController().onHome();

  @override
  RouterConfig<Object>? onRouterConfig() => GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return onHome();
            },
          ),
          GoRoute(
            path: '/add',
            builder: (BuildContext context, GoRouterState state) {
              return const AddContact();
            },
          ),
        ],
      );

  /// Place a breakpoint to see how it's built
  @override
  Widget build(BuildContext context) => super.build(context);
}
