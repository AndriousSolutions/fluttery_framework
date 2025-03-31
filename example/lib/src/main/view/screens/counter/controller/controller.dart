// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';

import '../model/data_source.dart';

/// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

///
class Controller extends StateXController {
  /// It's a good practice and follow the Singleton pattern.
  /// There's on need for more than one instance of this particular class.
  factory Controller([StateX? state]) => _this ??= Controller._(state);
  Controller._(StateX? super.state) : _model = Model();
  static Controller? _this;

  final Model _model;

  /// Note, the count comes from a separate class, _Model.
  int get count => _model.counter;

  /// Increment and then call the State object's setState() function to reflect the change.
  void onPressed() => incrementCounter();

  /// The Controller knows how to 'talk to' the Model and to the View (interface).
  void incrementCounter() {
    //
    _model.incrementCounter();

    /// Retrieve a particular State object. The rest is ignore if not at 'HomePage'
    final homeState = stateOf<GridPage>();

    // If we're not currently working with this particular State object
    if (homeState == null) {
      // Update the interface with the latest change.
      setState(() {});
    } else {
      /// If count is divisible by 5
      if (_model.counter % 5 == 0) {
        // Assigning a value will cause 'rootState?.notifyClients()'
        // Update the interface with the latest change.
        dataObject = _model.sayHello();
      } else {
        // Call those widget's 'dependent' on the App's InheritedWidget.
        // Update the interface with the latest change.
        rootState!.notifyClients();
      }
    }
  }

  /// **************  Life cycle events ****************
  ///

  /// Called to complete any asynchronous operations.
  @override
  Future<bool> initAsync() async {
    //
    _thisController = toString().replaceFirst('Instance of ', '');

    debugPrint('############ Event: initAsync() in $_thisController in $state');

    // Throw an error here and see how it's handled. Don't throw when testing
    if (state is Page1State && initAsyncError && App.inWidgetsFlutterBinding) {
      throw Exception('Error in initAsync()!');
    }
    return true;
  }

  /// Invoke an error or not
  bool get initAsyncError => AppSettingsController().initAsyncError;

  // initAsync() has failed
  @override
  void onAsyncError(FlutterErrorDetails details) {
    /// You're controller may want to work on the details.
    return;
  }

// Provide the name of this class object during debugging
  String _thisController = "'Controller'";

  /// The framework will call this method exactly once.
  /// Only when the [StateX] object is first created.
  @override
  void initState() {
    super.initState();
    debugPrint('############ Event: initState() in $_thisController in $state');
  }

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
  /// Note: YOU DON'T KNOW WHEN THIS WILL RUN in the Engine.
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

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    debugPrint(
        '############ Event: resumedLifecycleState() in $_thisController in $state');
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    debugPrint(
        '############ Event: detachedLifecycleState() in $_thisController in $state');
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
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
    setState(() {});
  }

  /// Called when this route has been pushed.
  @override
  void didPush() {
    debugPrint('############ Event: didPush() in $_thisController in $state');
    setState(() {});
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
