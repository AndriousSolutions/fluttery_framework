//
import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/model.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// App
class TemplateApp extends AppStatefulWidget {
  TemplateApp({super.key});

  // This is the 'App State object' of the application.
  @override
  AppState createAppState() => TemplateView();
}

// This is the 'View' of the application. The 'look and feel' of the app.
class TemplateView extends AppState {
  TemplateView()
      : super(
          controller: TemplateController(),
          controllers: [ContactsController()],
          inTitle: () => 'Demo App'.tr,
          debugShowCheckedModeBanner: false,
          switchUI: Prefs.getBool('switchUI'),
          locale: L10n.locale,
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
        );

  @override
  Widget onHome() => (con as TemplateController).onHome();
}
