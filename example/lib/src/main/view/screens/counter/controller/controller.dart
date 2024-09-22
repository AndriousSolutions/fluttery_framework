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
    final homeState = stateOf<HomePage>();

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

  /// Called to complete any asynchronous operations.
  @override
  Future<bool> initAsync() async {
    // A controller can have many State objects 'registered' with it
    // Return if the current State is Page2State
    if (state is Page1State || state is Page2State) {
      return true;
    }
    // Simply wait for 5 seconds at startup.
    /// In production, this is where databases are opened, logins attempted, etc.
    return Future.delayed(const Duration(seconds: 5), () {
      return true;
    });
  }

  /// The framework will call this method exactly once.
  /// Only when the [StateX] object is first created.
  @override
  void initState() {
    super.initState();
    if (inDebugMode) {
      debugPrint('############ Event: initState in $this');
    }
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      debugPrint('############ Event: deactivate in $this');
    }
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
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
      debugPrint('############ now disposed in $this');
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
  void didUpdateWidget(StatefulWidget oldWidget) {
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
    setState(() {});
  }

  /// Called when this route has been pushed.
  @override
  void didPush() {
    if (inDebugMode) {
      debugPrint('############ Event: didPush in $this');
    }
    setState(() {});
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
      debugPrint(
          '############ Event: didChangeAppLifecycleState($state) in $this');
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
