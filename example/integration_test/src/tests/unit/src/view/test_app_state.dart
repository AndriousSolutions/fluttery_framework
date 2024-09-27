import '_unit_test_view.dart';

Future<void> testAppState(WidgetTester tester) async {
  //
  // Find its StatefulWidget first then the 'type' of State object.
//  final appState = tester.firstState<AppState>(find.byType(FlutteryExampleApp));

  final appState = ExampleAppController().state as AppState;

  bool? use = appState.useCupertino;

  use = appState.useCupertino;

  use = appState.useMaterial;

  use = appState.useMaterial;

  await appState.didPopRoute();

  appState.activate();

  appState.onHome();

  appState.onRouteInformationProvider();

  appState.onBackButtonDispatcher();

  appState.oniOSTheme();

  appState.onLocale();

  appState.onDebugShowMaterialGrid();

  appState.onShowPerformanceOverlay();

  appState.onCheckerboardRasterCacheImages();

  appState.onCheckerboardOffscreenLayers();

  appState.onShowSemanticsDebugger();

  appState.onDebugShowCheckedModeBanner();

  appState.app;

  appState.onError(FlutterErrorDetails(exception: AssertionError('Error')));
}
