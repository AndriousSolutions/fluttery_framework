
## 5.20.2
April 04, 2025
- Include context in the line:
  final themeData = _theme ?? onTheme(context) ?? v.App.themeData;
- Update dartdoc_options.yaml

## 5.20.1+1
March 31, 2025
- state_extended 5.11.0
- Removed unused  DiagnosticsProperty in error_handler.dart
error_handler.dart
- Flag when an error handler is explicitly passed into the app, _passedErrorHandler
- Calls error handler when an unhandled error occurs in the root isolate.
  _platformOnError = PlatformDispatcher.instance.onError;
- Call to error handler in try-catch construct
app_statex.dart - New functions to catch Asynchronous errors
- Future<bool> onCatchAsyncError(Object error) async => await rootState?.catchAsyncError(error) ?? false;
- Future<bool> catchAsyncError(Object error)
- Future<bool> Function(Object error)? inCatchAsyncError
- Deprecated onErrorHandler(). Use onError() instead.
app_statefulWidget.dart:
- future.catchError( calls catchAsyncError()

## 5.19.0
March 17, 2025
- Folder, test, moved to example/lib allowing testing on the Web
- Added the parameter, super.printEvents, to AppStateX
- _Page3State() : super(printEvents: true);
- Set error handler in run_webapp.dart

## 5.18.0+1
March 05, 2025
- Removed deprecated app_settings.dart
- Additional Tests to the example app:
   multi_screen_test.dart
   routes_test.dart
   settings_screen_test.dart
   code_coverage.dart
   test_runapp.dart
- static void errorHandler(FlutterErrorDetails details) in error_handler.dart
- void activate() { and void deactivate() {  in app_statex.dart
  if (ignoreErrorInTesting) {  // Allow an error to be ignored. Once!
- Testing PopupMenuFunctionsMixin and dart format .

## 5.17.1+3
March 03, 2025
- Introduce three more 'inline' function routines in app_statex.dart:   
   inGenerateRoute, inUnknownRoute, and inScaffoldMessengerKey
- Two parameters in app_statex.dart were changed with new 'inline' functions: 
   onGeneratedRoute to generateRoute and onUnknownRoute to unknownRoute
- Renamed reload() function to hotReload()
- Renamed mixin, RootState, to RootStateMixin
- Revamped Fluttery's error routine in error_handler.dart making it more efficient
- logErrorDetails(FlutterErrorDetails details) now in error_handler.dart
- Stopped using the mixin, RouteNavigatorMethodsMixin. Proved ineffective.
- An update of the example app
- Updated test_error_handler.dart 
- Updated dependencies:
   device_info_plus: ^11.2.0 -> ^11.3.0
   go_router: ^14.0.0 -> ^14.8.0
   http: ^1.2.2 -> ^1.3.0
   package_info_plus: ^8.1.2 -> ^8.3.0
   state_extended: ^5.0.0 -> ^5.10.0
   url_launcher_web: ^2.3.3 -> ^2.4.0

## 5.16.1+1
February 23, 2025
- themeData ??= ThemeData.fallback(); in app_statex.dart
- CupertinoBasedMaterialThemeData() in mixin _AppThemeDataMixin
- Removed radio buttons from popup menu
- Supplied more tests: multi_counters_test.dart';
- dart format .

## 5.16.0+2
February 18, 2025
- Rewrite of the example app
  Replacing the 'home' widget outright is no longer recommended

## 5.15.0+2
February 13, 2025
- final Widget? Function()? inHome; Allow for null Widget in app_statex.dart
- Revamped the example app
- Upgraded to Dart 2.9.0 since toARGB32() now available in class Color
- ui_widgets_utils 1.2.1 (was 1.2.0)
- As of Dart 2.9.0, named parameter 'iconAlignment' was removed from TextButton widget.
  Use ButtonStyle.iconAlignment instead.
- Updated rules in analysis_options.yaml

## 5.14.0+2
February 04, 2025
- Directory, xport, now used in example app
- Rewrite of setiOSThemeData() in app_statex.dart
- assert(() {  if(state is AppStateX){ in app_statex_controller.dart
- Rewrite of radio_material.dart

## 5.13.0
January 30, 2025
- *BUGFIX* setiOSThemeData( and setThemeData( in app_statex.dart
  They fallback to Flutter's default theme only in their specific platform
- changeUI(String? ui) has if (!UniversalPlatform.isMobile) for other platforms
- onSwitchUI()
- Reorganized its files anf folders

## 5.12.0
January 29, 2025
- setiOSThemeData( and setThemeData( in app_statex.dart 
  If a theme not explicit provided, they fallback to Flutter's default theme.

## 5.11.2
January 21, 2025
- *BUGFIX* Run on the Web platform with fake_classes_for_web.dart to fake_model_for_web.dart
- v.App.appState = _appState; before _appState?.setThemeData(context);
- Optional context parameter available for both the 'on' an 'in' theme functions:
  onTheme(context)
  onDarkTheme(context)
  onHighContrastTheme(context)
  onHighContrastDarkTheme(context)
  oniOSTheme(context)

## 5.11.1
January 19, 2025
- *BUGFIX* Restored the capability to run on the Web platform with fake_model_for_web.dart
- *BUGFIX* Repositioned the Sizer() function allowing for a responsive UI in your apps.
- *BUGFIX* Ensure only a Hot Reload will recreate the App's State object
  _appWidget = _AppStatefulWidget(key: GlobalObjectKey<v.AppStateX>(_appState!), appState: _appState!);

## 5.11.0+1
January 15, 2025
- Updated onGenerateRoute() & onRoutes() in app_statex.dart
- Added the getter, routesGenerated, in app_statex.dart
- displayErrorWidget() & onUnknownRoute() in error_handler.dart
- Updated translations directory

## 5.10.0
January 10, 2025
- DevToolsSettings.column() in Example app

## 5.9.0+2
January 08, 2025
- Moved class app_drawer to its own Dart file
In app_statex.dart:
- new getter, NavigatorState? get navigatorState
- Route<dynamic>? onGenerateRoute(RouteSettings settings)
- Route<dynamic>? onUnknownRoute(RouteSettings settings)
New 'in-line' functions allowing the dynamic use of development tools:
- super.inDebugPaintSizeEnabled,  
- super.inDebugPaintBaselinesEnabled,
- super.inDebugPaintPointersEnabled,
- super.inDebugPaintLayerBordersEnabled,
- super.inDebugRepaintRainbowEnabled,
- super.inDebugRepaintTextRainbowEnabled,
- super.inDebugPrintRebuildDirtyWidgets,
- super.inDebugOnRebuildDirtyWidget,
- super.inDebugPrintBuildScope,
- super.inDebugPrintScheduleBuildForStacks,
- super.inDebugPrintGlobalKeyedWidgetLifecycle,
- super.inDebugProfileBuildsEnabled,
- super.inDebugProfileBuildsEnabledUserWidgets,
- super.inDebugEnhanceBuildTimelineArguments,
- super.inDebugHighlightDeprecatedWidgets,
- More tests for mixin RouteNavigatorMethodsMixin
- Introduced typedef ReturnRouteFunctionType
- mixin DebugPaintPrintProfileOptionsMixin supplies development tools. For example:
  debug.debugPaintSizeEnabled = debugPaintSizeEnabled ?? onDebugPaintSizeEnabled() ?? false;
- app_drawer.dart contains the class, AppDrawer
- Further changes to tests in test_navigator_mixin.dart

## 5.8.0+1
January 04, 2025
- extension ColorExts on Color to overcome Flutter 3.27 conversion issue
- Addressed Dart Analysis issues: e.g. /// Missing documentation for public members

## 5.7.6
January 04, 2025
- Flexible() introduced in radiobutton_widget.dart

## 5.7.5+1
January 03, 2025
- Avoid, Unable to load asset: "assets/images/meow.gif", during testing
  App.inFlutterTest ? null : const SplashScreen();

## 5.7.4
December 30, 2024
- Correctly cast the Fluttery Framework version of StateX; not state_extended version.
  getter appState gets Fluttery version; getter rootState gets state_extended version.
  StateX get state in app_statex_controller.dart
  StateX? get firstState, StateX? get lastState in app_statex_controller.dart
  StateX? stateOf<T extends StatefulWidget>() in app_statex_controller.dart
  stateOf<T extends StatefulWidget>() in app_statex_controller.dart
- Corrected changeApp() in example_controller.dart

## 5.7.3
December 29, 2024
- Recognize only 'Testing Errors' in  app_statex.dart
  details.exception is TestFailure || details.exception is Error
- Tests for RouteNavigatorMethodsMixin in app_navigation.dart
- app_navigation.dart renamed app_navigator_mixin.dart
- Add a Navigation listener with addNavigationListener() in app_statex.dart
  
## 5.7.2
December 27, 2024
- Corrected image_api.dart in example app
- Acknowledge any Testng errors in app_statex.dart
- More testing with test_navigation.dart

## 5.7.1
December 25, 2024
- class StateX has
  AppStateX? get rootState => super.rootState as AppStateX;
  StateXController? get controller {
  final con = super.controller; return con as StateXController;
- class AppStateXController has
  AppStateX? get rootState => super.rootState as AppStateX;
- class StateXController has
  AppStateX? get rootState => super.rootState as AppStateX;
- AppObject, AppStateX, and StateX uses Mixin in app_navigation.dart
- Introduce testing of app_navigation.dart with navigating_screens.dart
- Future<void> testFiles(WidgetTester tester) async {

## 5.7.0
December 16, 2024
- App.inFlutterTest
- Tests are updated

## 5.6.0
December 14, 2024
- Introduce Splash screen to example app
- deferFirstFrame() in initState() in app_statefulwidget.dart
- Add mixins: class AppErrorHandler with HandleError, StateXonErrorMixin {
- Update the function, runApp(), with optional error handling
  void runApp(m.Widget app, {FlutterExceptionHandler? onError, bool? runZoneGuard}) {

## 5.5.0
December 11, 2024
- Introduced parameter, themeAnimationStyle,for class MaterialApp
- @protected @factory v.AppStateX createAppState();

## 5.4.2+1
December 11, 2024
- *BUGFIX* Moved Sizer() from app_statex.dart to app_statefulwidget.dart
- app.dart renamed app_object.dart
- app_state.dart renamed app_statex.dart
- app.dart renamed app_statex_controller.dart
- *Deprecated* AppState() and AppController() class are deprecated.
- class AppState renamed class AppStateX
- class AppController renamed AppStateXController
- sizer: ^3.0.0
- Removed unnecessary_library_name in radiobutton_widget.dart
  
## 5.4.1
December 04, 2024
- Optional type argument, T, was not specified.
  .pushNamed<T>(routeName, arguments: arguments);
  .restorablePushNamed<T>(routeName, arguments: arguments);

## 5.4.0+1
October 14, 2024
- AppState class now has the notifyClientsInBuild parameter. Defaults to true.
  This then notifies any dependencies when calling for a rebuild
- The runInitAsync() function in every StateX object
  now allows their initAsync() functions to be conditionally called with every rebuild.
- Translations for 'Material Ver.'
- Updated the README.md
- Updated device_info_plus 10.1.2 to 11.0.0

## 5.3.3
October 07, 2024
- Correct onInitAsync() in app_state.dart and default to returning true

## 5.3.2+1
October 06, 2024
- *BUGFIX* Removed 'default' Error Handler mistakenly left in Production.
- *BUGFIX* Removed 'default' Error Widget Builder mistakenly left in Production.
- A default Error Screen, defaultErrorWidgetBuilder, available during development
- Getters, errorHandler, oldOnError and oldBuilder, offered now in error_handler.dart
- Null error correction in example app

## 5.3.1+1
October 01, 2024
- getDeviceInfo() not called during testing
- onErrorHandler() and inErrorHandler() are called in turn in app_state.dart
- if (inFlutterTest) { for initInternal() in app.dart

## 5.3.0+1
September 29, 2024
- handler.reset() in app_statefulwidget.dart
- Testing the test files

## 5.2.0+4
September 26, 2024
- Restore Error handler with deactivate() in error_handler.dart
- throw Exception('Error in builder!'); in testing
- onCatchAsyncError() wrapped in try..catch in app_state.dart
- inCatchAsyncError() wrapped in try..catch
- Integration Tests Only
- Builder Error Test Only
- Async Error Test

## 5.1.0
September 20, 2024
- Screen Width and Height without BuildContext
- bool get appInApp in app_state.dart
- Print() changed to debugPrint()
- Rewrite of radiobutton_widget.dart

## 5.0.1+6
September 12, 2024
- Removed reactive code: view/rx_core/
- Test class AppMenu
- if (!App.inFlutterTest) in test_app.dart
- Uncomment include: package:flutter_lints/flutter.yaml
- Addressed 'Dangling library doc comment'
- Addressed Dart Analyst 
- export 'model/files.dart' if (dart.library.html) in model.dart
  export 'model/installfile.dart' if (dart.library.html)
- Tighten dependencies: dart pub upgrade --tighten
- import '/view.dart' show in error_handler.dart

## 5.0.0+2
September 09, 2024
- app.dart
- app_appstate.dart
- app_navigation.dart
- app_state.dart
- app_statefulwidget.dart
- rx_impl.dart
- Corrected Dart Analysis warnings
- Include more unit tests

## 4.27.0
August 07, 2024
- textButtonOption<bool>() in dialog_box.dart
- 'Recreated' example app
- super(useInherited: useInherited ?? true) {
- 
## 4.26.1
August 06, 2024
- state_extended.dart change, void didUpdateWidget(covariant T oldWidget) {
  requires correction in example app:
  void didUpdateWidget(RandomDog oldWidget) {
  void didUpdateWidget(CounterPage oldWidget) {
  void didUpdateWidget(WordPairs oldWidget) {

## 4.26.0
July 26, 2024
- Deprecate more public getter properties for further security and cohesion
  scaffoldMessengerKey locale supportedLocales
- inErrorHandler parameter and onErrorHandler() function in example app
- Deprecated App.errorHandler
- class AppErrorHandler new parameters:
  bool? presentError,
  ParagraphStyle? paragraphStyle,
  TextStyle? textStyle,
  EdgeInsets? padding,
  double? minimumWidth,
  Color? backgroundColor,
- static Future<bool> delete(String fileName, {bool? recursive}) async {
- void go(String location, {Object? extra}) {
- test_app.dart removed deprecated getters


## 4.25.0
June 28, 2024
- Fluttery becoming more popular in more enterprise-wide projects,
  tighter cohesion is necessary for more effective functionality and for more security:
  Therefore some 40 properties once readily accessible now have their getters deprecated:
    home routeInformationProvider routeInformationParser routerDelegate
    backButtonDispatcher routerConfig routes initialRoute
    onGenerateRoute onUnknownRoute navigatorObservers builder/transitBuilder
    onGenerateTitle onNavigationNotification darkTheme highContrastTheme
    highContrastDarkTheme themeMode themeAnimationDuration themeAnimationCurve
    color localeListResolutionCallback localizationsDelegates localeResolutionCallback
    debugShowMaterialGrid showPerformanceOverlay checkerboardRasterCacheImages
    checkerboardOffscreenLayers showSemanticsDebugger debugShowWidgetInspector
    debugShowCheckedModeBanner debugPaintSizeEnabled debugPaintBaselinesEnabled
    debugPaintPointersEnabled debugPaintLayerBordersEnabled debugRepaintRainbowEnabled
    shortcuts actions restorationScopeId scrollBehavior

## 4.24.0
June 22, 2024
- inError parameter deprecated use inErrorHandler instead
  Both onErrorHandler and inErrorHandler can be implemented
- class, MsgBox, in dialog_box.dart includes parameters from
  showDialog and AlertDialog
- Function, radioButtonsBuilder, in radiobutton_widget.dart includes
  parameters from Radio, Text, Flexible and Flex

## 4.23.2
June 11, 2024
- AppState's setiOSThemeData() function made public and now called
  app_statefulwidget.dart's initAsync() function:
  _appState?.setiOSThemeData(context);

## 4.23.1
June 11, 2024
- AppState's setThemeData() function made public and now called
  app_statefulwidget.dart's initAsync() function:
  _appState?.setThemeData(context);

## 4.23.0
June 11, 2024
- connectivity_plus: ^5.0.0 to ^6.0.0
  StreamSubscription<ConnectivityResult>? _connectivitySubscription to
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscriptionList
- device_info_plus: ^9.0.0 to ^10.0.0
- go_router: ^13.0.0 to ^14.0.0
- package_info_plus: ^5.0.0 to ^8.0.0
- flutter_lints: ^3.0.0 to ^4.0.0

## 4.22.0
June 05, 2024
- Use buildIn() to work with the built-in InheritedWidget like 'useInherited: true'
- getter builder renamed transitBuilder

## 4.21.0
May 27, 2024
- Updated sdk: '>=3.0.0 <4.0.0'
- *Deprecated* StateIn() and StateF() class are deprecated.
  Use the StateX parameters, *runAsync* and *useInherited*, instead.
- class StatesRouteObserver extends RouteObserver<Route<dynamic>>
- import 'package:flutter/widgets.dart' for the following debug tools:
  debugPrintRebuildDirtyWidgets
  debugOnRebuildDirtyWidget
  debugPrintBuildScope
  debugPrintScheduleBuildForStacks
  debugPrintGlobalKeyedWidgetLifecycle
  debugProfileBuildsEnabled
  debugProfileBuildsEnabledUserWidgets
  debugEnhanceBuildTimelineArguments
  debugHighlightDeprecatedWidgets
- Removed the parameters, inOnGenerateRoute and inOnUnknownRoute, in app_state.dart
  Use parameter onGenerateRoute or method onOnGenerateRoute() equivalent instead.
- class StateX():super(useInherited: useInherited ?? false);
  Use of Built-in InheritedWidget defaults to false
- new getter, builderOverridden, in StateX class.
- Tests StateX class if uses the buildIn() function but its 'useInherited' parameter is not true.
- Cat and Bird images now come from https:\\api.sefinek.net

## 4.20.0
April 23, 2024
- showDialogBox() in dialog_box.dart
- Replace endState with lastState
- Removed from testing: App.buildInherited();  context.textScaleFactor;
- Update analysis_options.yaml

## 4.19.1
April 18, 2024
- _isAppInApp() in app_statefulwidget.dart
- _errorHandler?.dispose() in app.dart

## 4.19.0
April 17, 2024
- catchError() in app_appstate.dart takes in FlutterErrorDetails parameters
- Additional dialog window, Future<T?> showDialogBox<T>()

## 4.18.2+1
April 15, 2024
- Since Flutter 3.10, runApp() must now run in the 'root' zone
  Removed runZonedGuarded() from run_webapp.dart

## 4.18.1
April 15, 2024
- Since Flutter 3.10, runApp() must now run in the 'root' zone
  Removed runZonedGuarded() from run_app.dart
- Call WidgetsFlutterBinding.ensureInitialized() right away in AppStatefulWidget


## 4.18.0+4
April 01, 2024
- New getters for App object: allowChangeTheme, allowChangeLocale, allowChangeUI, switchUI
- if (widget.loadingScreen != null) { in app_statefulwidget.dart
- Allows you to set an error handler more than once.
- Removed deprecated errorHandler from runApp()
- Commented out _materialColor() in app.dart
- Updated show clause in run_app.dart
- Removed dangling library doc comment:  /// to //

## 4.17.0
February 09, 2023
- App.baseTheme = Theme.of(context); // Retain the original theme
- MainAxisAlignment? actionsAlignment in dialog_box.dart // Left-handed IU

## 4.16.0
February 06, 2023
- allowChangeTheme: true, // Explicitly allow the App's theme to change
- In setThemeData(), adjusted how and app's general Theme is acquired 
- content = content ?? Text(text ?? ' '); in dialog_box.dart
- Example app:
  All import statements made more effective
  New menu option: Material Design version 2 and 3 

## 4.15.0
February 05, 2023
- Adjusted how the app sets its theme: _setThemeData(context)
- Corrected showCupertinoDialog() to take in the 'content' widget

## 4.14.0+1
February 03, 2023
- App.allowChangeTheme, App.allowChangeLocale, App.allowChangeUI
- showBox(useRootNavigator: false
- Custom widget, SpinnerCupertino

## 4.13.0
January 25, 2023
- abstract class RadioButtons<T> extends StatefulWidget {
- Removed package name from import statements: import 'package:fluttery_framework/...'

## 4.12.0
January 13, 2023
- Reorganised example app
- Supplied hash code capability in hash.dart

## 4.11.1
December 19, 2023
- Supply Reactive capabilities: mixin RxStates on State and type Rx<T>
- Adjusted code testing

## 4.10.0
December 11, 2023
- 'textScaleFactorOf' is deprecated

## 4.8.3
December 02, 2023
- AppErrorHandler.allowNewErrorHandlers once set false new handlers are not allowed
- AppState.useRouterConfig set true if home == null
- Updated example app

## 4.8.2
December 01, 2023
- Continue to insert relative paths in the example app

## 4.8.1+1
November 30, 2023
- Updated example app
- localPath is current working directory depending on platform
- Additional directory changes to example app

## 4.7.0+1
November 23, 2023
- app_state.dart build() function incorrectly wrapped in Builder()
- Removed unused classes FieldWidgets InheritedStates and ScheduleNotifications
- Corrected Testing of a 'Close' button with if (button.evaluate().isEmpty) {

## 4.6.1
November 21, 2023
- Upgraded to go_router `12.0.0` and package_info_plus `5.0.0`
- Removed deprecated Text widget field, textScaleFactorOf, from use.
- Changed class, PopupMenuController<T>, to a mixin, PopupMenuFunctionsMixin<T>
- Corrected pubspec.yaml to state_extended ^4.0.0

## 4.5.3
October 15, 2023
- con.onItems() in app_menu.dart

## 4.5.2
October 15, 2023
- AppPopupMenu not displayed if no menu items

## 4.5.1+2
October 13, 2023
- AppMenu renamed to AppPopupMenu  Removed popupbutton property
- package_info_plus: ^5.0.0 was removed?? Back to ^4.0.0
- device_info_plus: ^10.0.0 was removed?? Back to ^9.0.0

## 4.5.0+2
October 10, 2023
- Rewrote App's menu:
  AppPopupMenu, PopupMenuWidget, AppPopupMenuController, PopupMenuController
- AppState setter locale includes _supportedLocales
- Introduced builder() as the default 'build' function
- buildiOS() defaults to buildAndroid() if not implemented
- Continue updating documentation
- Updated dependencies: connectivity_plus, device_info_plus, package_info_plus
- find.byType(Scrollable) and find.widgetWithText(SimpleDialogOption, 'OK') in locale_menu.dart

## 4.4.1
September 24, 2023
- Corrected get localizationsDelegates in _AppState

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