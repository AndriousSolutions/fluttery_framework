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
  final app = App();

  App.errorHandler;

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  App.onError(details);

  app.onAsyncError(
      AsyncSnapshot.withError(ConnectionState.none, AssertionError('error')));

  App.widgetsAppKey;

  App.navigatorKey;

  App.scaffoldMessengerKey;

  App.routes;

  App.initialRoute;

  App.onGenerateRoute;

  App.onUnknownRoute;

  App.navigatorObservers;

  App.builder;

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

  App.inDebugMode;

  App.inDebugger;

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
