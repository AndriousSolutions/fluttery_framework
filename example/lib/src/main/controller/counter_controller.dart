//
import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

///
class CounterController extends AppStateXController {
  ///
  factory CounterController() => _this ??= CounterController._();
  CounterController._() : super() {
    //
    _model = CounterModel();

    /// Provide the 'timer' controller to the interface.
    englishWordsTimer = EnglishWordsTimer();
  }
  static CounterController? _this;

  late final CounterModel _model;

  ///
  late final EnglishWordsTimer englishWordsTimer;

  /// The flag indicating if an InheritedWidget is to used.
  bool get useInherited => AppController().useInheritedWidget;

  /// the 'counter' value.
  String get data => _model.data;

  /// The 'View' is calling setState()
  void onPressed() => _model.onPressed();

  /// Supply the word pair
  Widget get wordPair => englishWordsTimer.wordPair;

  /// Access to the timer
  EnglishWordsTimer get timer => englishWordsTimer;

  /// The 'Controller' is calling the 'View' to call setState()
//  void onPressed() => setState(() => _model.onPressed());

  /// **************  Life cycle events ****************

  @override
  void initState() {
    // Add this controller to the State object's lifecycle.
    englishWordsTimer.addState(state);
    super.initState();
    debugPrint('############ Event: initState() in $_thisController in $state');
  }

  /// Called to complete any asynchronous operations.
  @override
  Future<bool> initAsync() async {
    //
    final init = await super.initAsync();

    // Provide the name of this class object during debugging
    _thisController = toString().replaceFirst('Instance of ', '');

    debugPrint('############ Event: initAsync() in $_thisController in $state');
    return init;
  }

  // Provide the name of this class object during debugging
  String _thisController = "'CounterController'";

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    debugPrint(
        '############ Event: deactivate() in $_thisController in $state');
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    debugPrint('############ Event: activate() in $_thisController in $state');
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU DON'T KNOW WHEN THIS WILL RUN in the Framework.
  /// PERFORM ANY TIME-CRITICAL OPERATION IN deactivate() INSTEAD!
  @override
  void dispose() {
    debugPrint(
        '###### Event: dispose() in $_thisController ${state == null ? 'but now null' : 'but now in $state'}');
    super.dispose();
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    debugPrint(
        '############ Event: inactiveLifecycleState() in $_thisController in $state');
  }

  /// All views of an application are hidden, either because the application is
  /// about to be paused (on iOS and Android), or because it has been minimized
  /// or placed on a desktop that is no longer visible (on non-web desktop), or
  /// is running in a window or tab that is no longer visible (on the web).
  @override
  void hiddenAppLifecycleState() {
    debugPrint(
        '############ Event: hiddenAppLifecycleState() in $_thisController in $state');
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedAppLifecycleState() {
    debugPrint(
        '############ Event: pausedLifecycleState() in $_thisController in $state');
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    debugPrint(
        '############ Event: detachedLifecycleState() in $_thisController in $state');
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    debugPrint(
        '############ Event: resumedLifecycleState() in $_thisController in $state');
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(CounterPage oldWidget) {
    debugPrint(
        '############ Event: didUpdateWidget() in $_thisController in $state');
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    debugPrint(
        '############ Event: didChangeDependencies() in $_thisController in $state');
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    debugPrint(
        '############ Event: reassemble() in $_thisController in $state');
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    debugPrint(
        '############ Event: didPopRoute() in $_thisController in $state');
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    debugPrint(
        '############ Event: didPushRouteInformation() in $_thisController in $state');
    return super.didPushRouteInformation(routeInformation);
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    debugPrint(
        '############ Event: didPopNext() in $_thisController in $state');
  }

  /// Called when this route has been pushed.
  @override
  void didPush() {
    debugPrint('############ Event: didPush() in $_thisController in $state');
  }

  /// Called when this route has been popped off.
  @override
  void didPop() {
    debugPrint('############ Event: didPop() in $_thisController in $state');
  }

  /// New route has been pushed, and this route is no longer visible.
  @override
  void didPushNext() {
    debugPrint(
        '############ Event: didPushNext() in $_thisController in $state');
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    debugPrint(
        '############ Event: didChangeMetrics() in $_thisController in $state');
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    debugPrint(
        '############ Event: didChangeTextScaleFactor() in $_thisController in $state');
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    debugPrint(
        '############ Event: didChangePlatformBrightness() in $_thisController in $state');
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    debugPrint(
        '############ Event: didChangeLocale() in $_thisController in $state');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.detach
    /// AppLifecycleState.resume
    // // Commented out for readability. Controllers have individual event handlers.
    //   debugPrint(
    //       '############ Event: didChangeAppLifecycleState($state) in $_thisController in state');
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    debugPrint(
        '############ Event: didHaveMemoryPressure() in $_thisController in $state');
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    debugPrint(
        '############ Event: didChangeAccessibilityFeatures() in $_thisController in $state');
  }
}
