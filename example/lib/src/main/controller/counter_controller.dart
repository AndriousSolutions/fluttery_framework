//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

class CounterController extends AppStateXController {
  factory CounterController() => _this ??= CounterController._();
  CounterController._() : super() {
    //
    _model = CounterModel();

    /// Provide the 'timer' controller to the interface.
    wordPairsTimer = WordPairsTimer();
  }
  static CounterController? _this;

  late final CounterModel _model;
  late final WordPairsTimer wordPairsTimer;

  /// The flag indicating if an InheritedWidget is to used.
  bool useInherited = false;

  @override
  void initState() {
    // Add this controller to the State object's lifecycle.
    wordPairsTimer.addState(state);
    super.initState();
    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: initState in $this');
    }
  }

  /// the 'counter' value.
  String get data => _model.data;

  /// The 'View' is calling setState()
  void onPressed() => _model.onPressed();

  /// Supply the word pair
  Widget get wordPair => wordPairsTimer.wordPair;

  /// Access to the timer
  WordPairsTimer get timer => wordPairsTimer;

  /// The 'Controller' is calling the 'View' to call setState()
//  void onPressed() => setState(() => _model.onPressed());

  /// **************  Life cycle events ****************

  /// Called to complete any asynchronous operations.
  @override
  Future<bool> initAsync() async {
    //
    final init = await super.initAsync();

    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: initAsync in $this');
    }
    return init;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: deactivate in $this');
    }
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: activate in $this');
    }
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU DON'T KNOW WHEN THIS WILL RUN in the Framework.
  /// PERFORM ANY TIME-CRITICAL OPERATION IN deactivate() INSTEAD!
  @override
  void dispose() {
    if (inDebugMode) {
      debugPrint('############ Event: dispose() in $this');
    }
    super.dispose();
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: pausedLifecycleState in $this');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: resumedLifecycleState in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: inactiveLifecycleState in $this');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: detachedLifecycleState in $this');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(CounterPage oldWidget) {
    if (inDebugMode) {
      debugPrint('############ Event: didUpdateWidget in $this');
    }
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeDependencies in $this');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    if (inDebugMode) {
      debugPrint('############ Event: reassemble in $this');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      debugPrint('############ Event: didPopRoute in $this');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      debugPrint('############ Event: didPushRouteInformation in $this');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPopNext in $this');
    }
  }

  /// Called when this route has been pushed.
  @override
  void didPush() {
    if (inDebugMode) {
      debugPrint('############ Event: didPush in $this');
    }
  }

  /// Called when this route has been popped off.
  @override
  void didPop() {
    if (inDebugMode) {
      debugPrint('############ Event: didPop in $this');
    }
  }

  /// New route has been pushed, and this route is no longer visible.
  @override
  void didPushNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPushNext in $this');
    }
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeMetrics in $this');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeTextScaleFactor in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangePlatformBrightness in $this');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: didChangeLocale in $this');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.detach
    /// AppLifecycleState.resume
    if (inDebugMode) {
      //ignore: avoid_print
      print(
          '############ Event: didChangeAppLifecycleState in ${this.state} for $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    if (inDebugMode) {
      debugPrint('############ Event: didHaveMemoryPressure in $this');
    }
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeAccessibilityFeatures in $this');
    }
  }
}
