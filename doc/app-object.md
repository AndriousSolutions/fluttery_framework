## _Your app's properties accessible anytime and anywhere_

The App object will represent your app with a number of static properties accessible to you.
I encourage you to seek them out how they're used in the Fluttery Framework itself and its example apps.
That's because you can use them too in your own app.
You'll wonder how you ever coded without them.
###### (Copy & paste an item below and try it out.)
```Dart

import 'dart:ui' as ui show FlutterView;

void testingAppObject() {
  //
  final app = AppObject();
  
  /// As you see above, you can instantiate the AppObject class (factory constructor)
  /// However, it's already done for you (see below) and assigned to the variable, App. 
  /// 
  /// In app.dart:
  /// Supply a 'high level' reference to the 'App object.'
  /// ignore: non_constant_identifier_names
  /// final App = AppObject();

  /// Indicating app is running in the Flutter engine and not in
  /// the `flutter_test` framework with TestWidgetsFlutterBinding for example
  bool inWidgetsFlutterBinding = App.inWidgetsFlutterBinding;

  /// Indicate if running under a 'Flutter Test' environment
  bool inFlutterTest = App.inFlutterTest;

  /// Determine if the App initialized successfully.
  bool? isInit = App.isInit;

  // Only run certain code if a 'hot reload' was performed.
  bool hotReload = App.hotReload;

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  // Calls the app's error handler
  App.onError(details);

  // Called if there was an error in the app's initAsync() function at start up.
  app.onAsyncError(
      AsyncSnapshot.withError(ConnectionState.none, AssertionError('error')));

  // Supplied the very screen of your app.
  // Must first import 'dart:ui' as ui show FlutterView;
  ui.FlutterView mainWindow = App.mainWindow;

  // The app's Global key.
  GlobalKey<NavigatorState> key = App.navigatorKey;

  // The key to the app's Scaffold
  GlobalKey<ScaffoldMessengerState>? scaffoldKey = App.scaffoldMessengerKey;

  /// Indicates if the App is running the Material interface theme.
  // Allows you to use Material UI when explicitly specified or even when running in iOS
  bool useMaterial = App.useMaterial;

  /// Indicates if the App is running the Cupertino interface theme.
  // Allows you to use Cupertino UI when explicitly specified or even when running in Android
  bool useCupertino = App.useCupertino;

  // All the app's routes if any.
  Map<String, WidgetBuilder>? routes = App.routes;

  /// Returns to the initial route used by the app.
  String? initialRoute = App.initialRoute;

  /// The route generator used when the app is navigated to a named route.
  RouteFactory? genRoute = App.onGenerateRoute;

  /// Called when [onGenerateRoute] fails except for the [initialRoute].
  RouteFactory? unknown = App.onUnknownRoute;

  /// The list of observers for the [Navigator] for this app.
  List<NavigatorObserver>? observers = App.navigatorObservers;

  /// if neither [routes], or [onGenerateRoute] was passed.
  TransitionBuilder? builder = App.builder;

  // The app's title if any.
  String? title = App.title;

  /// Routine used to generate the App's title.
  GenerateAppTitle? genTitle = App.onGenerateTitle;

  // Supplies you a 'materal' color from the specified color object
  MaterialColor material = App.getMaterialColor(Colors.red);

  /// Returns the Color passed to the app.
  Color? color = App.color;

  /// Returns the device's possibly ever-changing Locale.
  Locale? locale = App.locale;

  /// Returns the App's current localizations delegates.
  Iterable<LocalizationsDelegate<dynamic>>? delegates =
      App.localizationsDelegates;

  /// Returns a List of the App's locales.
  List<Locale>? locales = App.supportedLocales;

  /// If true, it paints a grid overlay on Material apps.
  bool? debugShowMaterialGrid = App.debugShowMaterialGrid;

  /// If true, it turns on a performance overlay.
  bool? showPerformanceOverlay = App.showPerformanceOverlay;

  /// Checkerboard raster cache to speed up overall rendering.
  bool? checkerboardRasterCacheImages = App.checkerboardRasterCacheImages;

  /// Checkerboard layers rendered offscreen bitmaps.
  bool? checkerboardOffscreenLayers = App.checkerboardOffscreenLayers;

  /// Shows an overlay of accessibility information
  bool? showSemanticsDebugger = App.showSemanticsDebugger;

  /// Shows a little "DEBUG" banner in checked mode.
  bool? debugShowCheckedModeBanner = App.debugShowCheckedModeBanner;

  /// Each RenderBox to paint a box around its bounds.
  bool? debugPaintSizeEnabled = App.debugPaintSizeEnabled;

  /// RenderBox paints a line at its baselines.
  bool? debugPaintBaselinesEnabled = App.debugPaintBaselinesEnabled;

  /// Objects flash while they are being tapped.
  bool? debugPaintPointersEnabled = App.debugPaintPointersEnabled;

  /// Layer paints a box around its bound.
  bool? debugPaintLayerBordersEnabled = App.debugPaintLayerBordersEnabled;

  /// Overlay a rotating set of colors when repainting layers in checked mode.
  bool? debugRepaintRainbowEnabled = App.debugRepaintRainbowEnabled;

  /// The running platform
  TargetPlatform? platform = App.platform;

// Must first import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
//  PackageInfo? packageInfo = App.packageInfo;

  // The app's very name
  String? appName = App.appName;

  // The package name of the app.
  String? packageName = App.packageName;

  // The app's version number
  String? version = App.version;

  /// The build number of the App.
  String? buildNumber = App.buildNumber;

  // Whether the app is running in 'debug mode.'
  bool inDebugMode = App.inDebugMode;

  // Rebuild the app's State object, AppState.
  App.refresh();

  // Assign the 'current widget' as a dependent to the app's InheritedWidget
//  App.dependOnInheritedWidget();

  // Notify the app's dependent widgets to rebuild.
  App.notifyClients();

  // Displays a snackbar.
  App.snackBar(content: const Text('hello.'));

  // Explicitly catch an error. Usually called in a try{ }catch
  App.catchError(AssertionError('test'));

  // Supply the scaffold State object of the app.
  ScaffoldState? scaffold = App.scaffold;

  /// The Physical width of the screen
  double screenPhysicalWidth = App.screenPhysicalWidth;

  /// The 'logical' width of the screen
  double screenWidth = App.screenWidth;

  /// The Physical height of the screen
  double screenPhysicalHeight = App.screenPhysicalHeight;

  /// The 'Logical' height of the screen
  double screenHeight = App.screenHeight;

  /// Current Screen Size
  Size screenSize = App.screenSize;

  /// Set whether the app is to use a 'small screen' or not.
  bool asSmallScreen = App.asSmallScreen;

  /// Return the bool value indicating if running in a small screen or not.
  bool inSmallScreen = App.inSmallScreen;

  /// The local directory for this App.
  String? filesDir = App.filesDir;

  /// Returns the connection status of the device.
  ///
  ///  bluetooth
  ///  wifi
  ///  ethernet
  ///  mobile
  ///  none
  ///  vpn (iOS and macOS returns 'other')
  ///  other
  String? connectivity = App.connectivity;

  /// Indicates if the app has access to the Internet.
  /// Assume we're online if null
  bool isOnline = App.isOnline;

  /// Was off but now turned on connectivity
  bool turnedOnInternet = App.turnedOnInternet;

  /// Was on but now turned off connectivity
  bool turnedOffInternet = App.turnedOffInternet;

  /// The unique id for this app's particular installation.
  String? installNum = App.installNum;

  /// Add a 'ConnectivityListener' to the app
  /// It's onConnectivityChanged() will be called with any connectivity change.
  bool added = App.addConnectivityListener(ConnectivityListenerTester());

  /// Remove a 'ConnectivityListener' to the app
  bool removed = App.removeConnectivityListener(ConnectivityListenerTester());
}

class ConnectivityListenerTester with ConnectivityListener {
  factory ConnectivityListenerTester() =>
      _this ??= ConnectivityListenerTester._();
  ConnectivityListenerTester._();
  static ConnectivityListenerTester? _this;

  @override
  void onConnectivityChanged(ConnectivityResult result) {
    // TODO: implement onConnectivityChanged
  }
}
```