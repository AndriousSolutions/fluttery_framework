/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_view.dart';

void testAppView(WidgetTester tester) {
  //
//  test('Test App class', () async {
  //
  final app = AppObject();

  App.inWidgetsFlutterBinding;

  App.inFlutterTest;

  App.errorHandler;

  App.isInit = App.isInit;

  App.hotReload = App.hotReload;

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  App.onError(details);

  app.onAsyncError(
      AsyncSnapshot.withError(ConnectionState.none, AssertionError('error')));

  App.mainWindow;

  App.navigatorKey;

  // ignore: unused_local_variable
  GlobalKey<ScaffoldMessengerState>? key = App.appState!.scaffoldMessengerKey;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     Map<String, WidgetBuilder>? routes = App.routes;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     String? initialRoute = App.initialRoute;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     RouteFactory? onGenerateRoute = App.onGenerateRoute;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     RouteFactory? onUnknownRoute = App.onUnknownRoute;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     List<NavigatorObserver>? navigatorObservers = App.navigatorObservers;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     TransitionBuilder? builder = App.builder;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     String? title = App.title;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     GenerateAppTitle? onGenerateTitle = App.onGenerateTitle;

  App.getMaterialColor(Colors.red);

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     Color? color = App.color;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     Iterable<LocalizationsDelegate<dynamic>>? delegates =
  //     App.localizationsDelegates;

  // @Deprecated('Unnecessarily exposed property')
  // // ignore: unused_local_variable
  //     LocaleResolutionCallback? callback = App.localeResolutionCallback;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugShowMaterialGrid = App.debugShowMaterialGrid;
  // App.debugShowMaterialGrid = debugShowMaterialGrid;

  // @Deprecated('Unnecessarily exposed property')
  // bool? showPerformanceOverlay = App.showPerformanceOverlay;
  // App.showPerformanceOverlay = showPerformanceOverlay;

  // @Deprecated('Unnecessarily exposed property')
  // bool? checkerboardRasterCacheImages = App.checkerboardRasterCacheImages;
  // App.checkerboardRasterCacheImages = checkerboardRasterCacheImages;

  // @Deprecated('Unnecessarily exposed property')
  // bool? checkerboardOffscreenLayers = App.checkerboardOffscreenLayers;
  // App.checkerboardOffscreenLayers = checkerboardOffscreenLayers;

  // @Deprecated('Unnecessarily exposed property')
  // bool? showSemanticsDebugger = App.showSemanticsDebugger;
  // App.showSemanticsDebugger = showSemanticsDebugger;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugShowCheckedModeBanner = App.debugShowCheckedModeBanner;
  // App.debugShowCheckedModeBanner = debugShowCheckedModeBanner;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugPaintSizeEnabled = App.debugPaintSizeEnabled;
  // App.debugPaintSizeEnabled = debugPaintSizeEnabled;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugPaintBaselinesEnabled = App.debugPaintBaselinesEnabled;
  // App.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugPaintPointersEnabled = App.debugPaintPointersEnabled;
  // App.debugPaintPointersEnabled = debugPaintPointersEnabled;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugPaintLayerBordersEnabled = App.debugPaintLayerBordersEnabled;
  // App.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled;

  // @Deprecated('Unnecessarily exposed property')
  // bool? debugRepaintRainbowEnabled = App.debugRepaintRainbowEnabled;
  // App.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled;

  App.platform;

  App.packageInfo;

  App.appName;

  App.packageName;

  App.version;

  App.buildNumber;

  App.inDebugMode;

  App.refresh();

  App.dependOnInheritedWidget(App.context);

  // App.buildInherited();

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
//  });
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
