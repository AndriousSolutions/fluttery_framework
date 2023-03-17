
## 2.1.0+2
March 16, 2023
- All source code is now under 2-clause BSD License.
- Conditional imports to make this Web compatible using fake_classes_for_web.dart
- Removed timezone.dart to make this Windows compatible. 
- SharedPreferences.setMockInitialValues({}); in test directory to ready plugin.

## 2.0.0+3
March 15, 2023
- Widget buildChild(BuildContext context) { renamed  Widget buildIn(BuildContext context) {
- field_widgets.dart updated to some 40+ more fields in Flutter
- // The 'error' parameters are deprecated.
  runApp(errorHandler: , errorScreen: , errorReport: ,) changed to runApp(newErrorHandlers: )
  AppStatefulWidget(errorHandler: , errorScreen: , errorReport: ,) unused constructor parameters
  App(errorHandler: , errorScreen: , errorReport: ,) unused constructor parameters
- AppErrorHandler.allowNewHandlers renamed AppErrorHandler.newErrorHandlers
- Errors in App's FutureBuilder are not handled; merely reported
- class AppWidgetErrorDisplayed { // A simple 'Widget Error' Screen if widget fails to display
- class AppState now has 'inline' error functions
- If a widget fails to display, call the latest SateX object's error routine
- rebuildLastState(); and refreshLastState() are deprecated
- Removed the incompatible package: unique_identifier: ^0.3.0

## 1.9.0
February 04, 2023
- // Refresh the 'current/latest' State object and 'root/first' State object.
- static refresh() in class App

## 1.8.0+01
January 30, 2023
With Flutter 3.7.0 release:
- class CupertinoListTile finally replaces my own version
- TextStyle, headline4, is deprecated
- Lint rule, invariant_booleans, is deprecated
New Lint rules:
- use_build_context_synchronously
- library_private_types_in_public_api
- A value for optional parameter isn't ever given
- // ignore_for_file: unused_element


## 1.7.0
January 21, 2023
- Removed 'final' from Appstate property: theme
- Introduced debugRepaintTextRainbowEnabled
- Moved debug.debugPaintSizeEnabled to buildChild()
- Upgrade unique_identifier: ^0.3.0

## 1.6.5
January 19, 2023
- **BUG FIX** Removed: routes ??= const <String, WidgetBuilder>{};
- Upgrade to state_extended: ^2.0.0

## 1.6.4+03
December 30, 2022
- Return boolean init from appState initAsync()
- value is! Color in getter iOSTheme
- Default iOSTheme to CupertinoThemeData(brightness: Brightness.light);
- getter isOnline is corrected
- class App with ConnectivityListener
- getters turnedOnInternet and turnedOffInternet

## 1.6.3+01
November 25, 2022
- get INSTANCE
- Corrected setNewRoutePath()
- hyperlink.dart & webpage_wrapper.dart

## 1.6.2+01
November 19, 2022
- theme: themeData(),
- _routerConfig = routerConfig ?? onRouterConfig();
- DeviceInfoPlugin().deviceInfo;
- if (_routerDelegate == null)

## 1.6.1
November 11, 2022
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