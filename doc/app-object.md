## _App properties anytime, anywhere_

Supply an App object accessible throughout the app.
###### (Copy & paste and try it out.)
```Dart
  final app = AppObject();

  App.inWidgetsFlutterBinding;

  App.inFlutterTest;

  App.errorHandler;

  App.isInit;

  App.hotReload;

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  App.onError(details);

  app.onAsyncError(
      AsyncSnapshot.withError(ConnectionState.none, AssertionError('error')));

  App.mainWindow;

  App.navigatorKey;

  App.scaffoldMessengerKey;

  App.routes;

  App.menu;

  App.initialRoute;

  App.onGenerateRoute;

  App.onUnknownRoute;

  App.navigatorObservers;

  App.builderr;

  App.title;

  App.onGenerateTitle;

  App.getMaterialColor(Colors.red);

  App.color;

  App.localizationsDelegates;

  App.localeResolutionCallback;

  App.debugShowMaterialGrid;

  App.showPerformanceOverlay;

  App.checkerboardRasterCacheImages;

  App.checkerboardOffscreenLayers;

  App.showSemanticsDebugger;

  App.debugShowCheckedModeBanner;

  App.debugPaintSizeEnabled;

  App.debugPaintBaselinesEnabled;

  App.debugPaintPointersEnabled;

  App.debugPaintLayerBordersEnabled;

  App.debugRepaintRainbowEnabled;

  App.platform;

  App.packageInfo;

  App.appName;

  App.packageName;

  App.version;

  App.buildNumber;

  App.inDebugMode;

  App.refresh();

  App.dependOnInheritedWidget(App.context);

  App.buildInherited();

  App.notifyClients();

  App.snackBar(content: const Text('hello.'));

  App.catchError(AssertionError('test'));

  App.scaffold;

  App.screenPhysicalWidth;

  App.screenWidth;

  App.screenPhysicalHeight;

  App.screenHeight;

  App.screenSize;

  App.asSmallScreen;

  App.inSmallScreen;

  App.filesDir;

  App.connectivity;

  App.isOnline;

  App.turnedOnInternet;

  App.turnedOffInternet;

  app.onConnectivityChanged(ConnectivityResult.none);

  App.addConnectivityListener(ConnectivityListenerTester());

  App.removeConnectivityListener(ConnectivityListenerTester());

  App.installNum;
```