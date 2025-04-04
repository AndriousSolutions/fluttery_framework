// ignore_for_file: unused_local_variable
//
import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

///
Future<void> testAppState(WidgetTester tester) async {
  //
  // Find its StatefulWidget first then the 'type' of State object.
//  final appState = tester.firstState<AppState>(find.byType(FlutteryExampleApp));

  final appState = AppController().appState!;

  bool? booleanValue = appState.useCupertino;

  booleanValue = appState.useCupertino;

  booleanValue = appState.useMaterial;

  booleanValue = appState.useMaterial;

  booleanValue = appState.switchUI;

  booleanValue = appState.appInApp;

  double? doubleValue = appState.maxMobileWidth;

  doubleValue = appState.maxTabletWidth;

  final nav = appState.navigator;

  await appState.didPopRoute();

  appState.onRouteInformationProvider();

  appState.onBackButtonDispatcher();

  appState.onRouterConfig();

  appState.onGenerateRoute(const RouteSettings());

  appState.onUnknownRoute(const RouteSettings());

  appState.onOnNavigationNotification(
      const NavigationNotification(canHandlePop: false));

  bool noteCallback(Notification note) => true;

  appState.addNavigationListener(noteCallback);

  appState.removeNavigationListener(noteCallback);

  appState.oniOSTheme();

  appState.onLocale();

  appState.onLocalizationsDelegates();

  appState.onDebugShowMaterialGrid();

  appState.onShowPerformanceOverlay();

  appState.onCheckerboardRasterCacheImages();

  appState.onCheckerboardOffscreenLayers();

  appState.onShowSemanticsDebugger();

  appState.onDebugShowWidgetInspector();

  appState.onDebugShowCheckedModeBanner();

  appState.app;

  final errorDetails = FlutterErrorDetails(exception: AssertionError('Error'));

  await appState.catchAsyncError(UnsupportedError('Error Test'));

  appState.onError(errorDetails);

  appState.onErrorScreen(errorDetails);
}
