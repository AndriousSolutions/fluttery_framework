import '_unit_test_view.dart';

void testAppState(WidgetTester tester) {
  //
//  test('Test AppState', () async {
  // Find its StatefulWidget first then the 'type' of State object.
//  final appState = tester.firstState<AppState>(find.byType(FlutteryExampleApp));

  final appState = ExampleAppController().state as AppState;

  bool? use = appState.useCupertino;

  use = appState.useCupertino;

  use = appState.useMaterial;

  use = appState.useMaterial;

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
//  });
}
