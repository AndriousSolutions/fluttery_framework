library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_tests_unit_view.dart';

Future<void> testAppObject(WidgetTester tester) async {
  //
  final app = AppObject();

  App.inWidgetsFlutterBinding;

  try {
    await DeviceInfo.initAsync();
  } catch (e) {
    HandelErrorTester().getError(e);
  }

  await App.initInternal();

  App.themeData = const CupertinoThemeData();

  final color = App.themeData!.primaryColor.toARGB32();

  App.themeData = Color(color);

  App.isInit = App.isInit;

  App.hotReload = App.hotReload;

  App.standAloneApp;

  App.goRouter;

  App.goRouter = null;

  App.allowChangeTheme;

  await App.getInstallNum();

  final details = FlutterErrorDetails(exception: AssertionError('error'));

  AppErrorHandler().flutteryExceptionHandler?.call(details);

  App.mainWindow;

  // ignore: unused_local_variable
  final GlobalKey<ScaffoldMessengerState>? key =
      App.appState!.scaffoldMessengerKey;

  App.getMaterialColor(Colors.red);

  App.platform;

  App.packageInfo;

  App.appName;

  App.packageName;

  App.version;

  App.buildNumber;

  App.inDebugMode;

  App.refresh();

  App.dependOnInheritedWidget(App.context);

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

  // ignore: INVALID_USE_OF_PROTECTED_MEMBER
  app.appState?.detachedAppLifecycleState();

  ///==================== extension AppNavigationExtension

  // App.canPop();

  // App.maybePop<bool>();
  //
  // App.pop<bool>();
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
