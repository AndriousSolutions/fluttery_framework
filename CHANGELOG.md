
## 4.4.0
September 18, 2023
- AppState parameters have corresponding getters 
- AppState.buildApp();
- Removed parameter inAppBuilder in AppState
- Included App.standAloneApp
- enhanced getter iOSThemeData
- bool? onDebugShowWidgetInspector()
- Included Widget builder(BuildContext context) in StateX
- Entered more translations
- Updated to state_extended: ^4.6.0

## 4.3.0+1
July 28, 2023
- Supply a third alternative to the MaterialApp or CupertinoApp in the class, AppState
  inAppBuilder and onAppBuilder
- Continue updating documentation

## 4.2.0
July 24, 2023
- Introduced allowChangeTheme, allowChangeLocale and allowChangeUI for AppState
- Added getter preferredLocale and saveLocale() save and retrieve a preferred Locale for AppState
- Majority of AppState parameters now immutable to retain scope
- Removed some 11 AppState setters to again tightening the code's scope
- Continue updating documentation

## 4.1.0+5
July 20, 2023
- Implemented onInitAsync() in app_state.dart
- Adjusted onError() in app_state.dart to call State object's onError()
- Introduced FlutterError.presentError(details); in App.onError()
- All the 'error' parameters are deprecated.
- Continue updating documentation

## 4.0.1+14
July 03, 2023
- /// Retrieve and cast as this Framework's own particular 'controller' type.
  StateXController? controllerById(String? id)
  StateXController? get rootCon {
  AppState? get rootState {
  StateXController? get controller {
- Extend the Counter example app
- dartdoc category: App object & Device info.
- Continue updating documentation

## 4.0.0+7
June 15, 2023
- *BREAKING CHANGE* Removed GetX to instead use go_router
- Static reference to GoRouter object: App.goRouter
- Updated to include new MaterialApp properties: highContrastTheme, highContrastDarkTheme, themeAnimationDuration, themeAnimationCurve, 
- extension GoRouterExtension on BuildContext to utilize App.goRouter
- Providing extensive documentation with the README.md

## 3.1.1+1
June 03, 2023
// Locale must explicitly be assigned to Get.locale as well.
- Get.locale = _locale;

## 3.1.0+1
May 23, 2023
- StateX class with a built-in InheritedWidget
- dependOnInheritedWidget() in StateXController
- Corrected example app, controller: TemplateController()
- Removed  abstract class View
- Update Counter Example app and Grid example app
- semanticsDismissible ?? true for latest Flutter version
- IMPORTANT dispose() runs late and cancels the *new* timer deactivate() is more reliable.

## 3.0.0
April 13, 2023
- *BREAKING CHANGE* Upgrade to Flutter v.3.0
- Incorporate GetX v.4 into this framework
- Upgrade to state_extended v.3
- Introduce class StateIn and class StateX
- Update example app

## 2.7.0
April 01, 2023 
- NavigatorStateMethodsMixin supplies a Global Navigator without context

## 2.6.0+1
March 30, 2023
- Commented out class NavBottomBar in nav_bottom_bar.dart
- Added dependency device_info_plus_web
- then removed dependency device_info_plus_web finding it insufficient.

## 2.5.0+2
March 29, 2023
- Updated parameters in class AppDrawer
- Included class AppDrawer in testing
- Included class SimpleBottomAppBar in testing
- Included dialog windows from dialog_box.dart in testing

## 2.4.1
March 26, 2023
- T get widget => (parentState?.widget ?? super.widget) as T;
- if (_routerDelegate == null && _routerConfig == null)
- RouteObserver class for RouteAware objects

## 2.3.0+1
March 21, 2023
- Assets class with a factory constructor
- More extensive tests introduced
- super.key in constructors

## 2.2.0
March 17, 2023
- App.inWidgetsFlutterBinding  // Indicating Flutter framework binding with WidgetsFlutterBinding
- App.inFlutterTest            // Indicating if running under a 'Flutter Test' environment
- if (!v.App.inFlutterTest) {  // Prevents MethodChannel() calls in a test environment.

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