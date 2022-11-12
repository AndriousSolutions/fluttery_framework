
## 1.6.1
- theme: v.App.themeData = theme ?? onTheme(),
- Introduces https://pub.dev/packages/sizer

## 1.6.0
- _AppState.con property was removed (StateX.controller will do)
- New class, AppMenu
- class PopupMenu<T> extends StatelessWidget {
- static v.AppMenu<String> get menu =>   /// A mutable menu
- showBox() function improved.
- sdk: '>=2.18.1 <3.0.0'
- locale: locale ?? onLocale(), to locale: onLocale() ?? locale,
- localeListResolutionCallback ?? onLocaleListResolutionCallback,
- localeResolutionCallback ?? onLocaleResolutionCallback,

## 1.5.0
- Static Color? setThemeData({ColorSwatch<int?>? swatch, Color? color,}) {
  // Reset if there was a 'hot reload'.
- v.App.hotReload = false;
- unique_identifier: ^0.2.0
- AppErrorHandler({   ,ErrorWidgetBuilder? screen,

## 1.4.2
- Allow 'in' functions to return null  e.g. ThemeData? Function()? inTheme

## 1.4.1+01
- conditional export corrected: dart.library.io) 'package:fluttery_framework
- Lengthened pubspec.yaml description field
- Removed StateX InheritedStateMixin reference from lib\view.dart

## 1.4.0
- Class ScheduleNotifications removed dropping dependency to flutter_local_notifications
- supportedLocales: v.App.supportedLocales = supportedLocales ?? onSupportedLocales()
- Updated widget_test.dart

## 1.3.0
- Removed deprecated refresh() and buildInherited().
- Introduced L10n.locale in example app.
- Introduced initAsync() and inInitState(). 

## 1.2.0
September 10, 2022
- Correct typo: extension ContextExtensionss

## 1.1.0
September 10, 2022
- AppState class now with controller, materialApp, and cupertinoApp parameter
- AppStatefulWidget class now with circularProgressIndicator parameter
- Updated README.MD

## 1.0.0
August 24, 2022
- Production release 

## 0.2.0
August 21, 2022
- import '../example/test/widget_test.dart';
- Supply continuous integration testing

## 0.1.0
July 18, 2022
- Initial Development Release