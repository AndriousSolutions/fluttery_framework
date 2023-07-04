## _App properties anytime, anywhere_

Supply an App object accessible throughout the app.
###### (Copy & paste and try it out.)
```Dart
  final app = AppObject();

  bool inWidgetsFlutterBinding = App.inWidgetsFlutterBinding;

  bool inFlutterTest = App.inFlutterTest;

  bool isInit = App.isInit;

  bool hotReload = App.hotReload;

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  App.onError(details);

  app.onAsyncError(
      AsyncSnapshot.withError(ConnectionState.none, AssertionError('error')));

  ui.FlutterView mainWindow = App.mainWindow;

  GlobalKey<NavigatorState>() key = App.navigatorKey;

  GlobalKey<ScaffoldMessengerState>? get scaffoldKey = App.scaffoldMessengerKey;

  Map<String, WidgetBuilder>? routes = App.routes;

  String? initialRoute = App.initialRoute;

  RouteFactory? genRoute = App.onGenerateRoute;

  RouteFactory? unknown = App.onUnknownRoute;

  List<NavigatorObserver>? observers = App.navigatorObservers;

  TransitionBuilder? builder = App.builder;

  String? title = App.title;

  GenerateAppTitle? genTitle = App.onGenerateTitle;

  MaterialColor material = App.getMaterialColor(Colors.red);

  Color? color = App.color;

  Iterable<LocalizationsDelegate<dynamic>>? delegates = App.localizationsDelegates;

  LocaleResolutionCallback? callBack = App.localeResolutionCallback;

  bool debugShowMaterialGrid = App.debugShowMaterialGrid;

  bool showPerformanceOverlay = App.showPerformanceOverlay;

  bool checkerboardRasterCacheImages = App.checkerboardRasterCacheImages;

  bool checkerboardOffscreenLayers = App.checkerboardOffscreenLayers;

  bool showSemanticsDebugger = App.showSemanticsDebugger;

  bool debugShowCheckedModeBanner = App.debugShowCheckedModeBanner;

  bool debugPaintSizeEnabled = App.debugPaintSizeEnabled;

  bool debugPaintBaselinesEnabled = App.debugPaintBaselinesEnabled;

  bool debugPaintPointersEnabled = App.debugPaintPointersEnabled;

  bool debugPaintLayerBordersEnabled = App.debugPaintLayerBordersEnabled;

  bool debugRepaintRainbowEnabled = App.debugRepaintRainbowEnabled;

  TargetPlatform? platform = App.platform;

  PackageInfo? packageInfo = App.packageInfo;

  String? appName = App.appName;

  String? packageName = App.packageName;

  String? version = App.version;

  String? buildNumber = App.buildNumber;

  bool inDebugMode = App.inDebugMode;

  App.refresh();

  App.dependOnInheritedWidget(App.context);

  App.notifyClients();

  App.snackBar(content: const Text('hello.'));

  App.catchError(AssertionError('test'));

  ScaffoldState? scaffold = App.scaffold;

  double screenPhysicalWidth = App.screenPhysicalWidth;

  double screenWidth = App.screenWidth;

  double screenPhysicalHeight = App.screenPhysicalHeight;

  double screenHeight = App.screenHeight;

  double screenSize = App.screenSize;

  bool asSmallScreen = App.asSmallScreen;

  bool inSmallScreen = App.inSmallScreen;

  String filesDir = App.filesDir;

  String connectivity = App.connectivity;

  bool isOnline = App.isOnline;

  bool turnedOnInternet = App.turnedOnInternet;

  bool turnedOffInternet = App.turnedOffInternet;

  app.onConnectivityChanged(ConnectivityResult.none);

  bool added = App.addConnectivityListener(ConnectivityListenerTester());

  boo removed = App.removeConnectivityListener(ConnectivityListenerTester());

  String installNum = await App.installNum;
```