// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
library;
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This widget works with the free Dog API.
///

import 'dart:ui';

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomDog extends StatefulWidget {
  ///
  const RandomDog({super.key});
  @override
  State<StatefulWidget> createState() => _RandomDogState();
}

class _RandomDogState extends ImageAPIStateX<RandomDog> {
  _RandomDogState()
      : super(
          controller: DogController(),
          uri: Uri(
            scheme: 'https',
            host: 'dog.ceo',
            path: 'api/breeds/image/random/1',
          ),
          message: 'message',
        );

  /// Place a breakpoint and see the process
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();

    /// Override this method to perform initialization that depends on the
    /// location at which this object was inserted into the tree.
    /// (i.e. Subscribe to another object it depends on during [initState],
    /// unsubscribe object and subscribe to a new object when it changes in
    /// [didUpdateWidget], and then unsubscribe from the object in [dispose].
    if (inDebugMode) {
      //ignore: avoid_print
      debugPrint('############ Event: initState in $this');
    }
  }

  /// The framework calls this method whenever it removes this [StateX] object
  /// from the tree.
  @override
  // ignore: unnecessary_overrides
  void deactivate() {
    super.deactivate();

    /// The framework calls this method whenever it removes this [State] object
    /// from the tree. It might reinsert it into another part of the tree.
    /// Subclasses should override this method to clean up any links between
    /// this object and other elements in the tree (e.g. if you have provided an
    /// ancestor with a pointer to a descendant's [RenderObject]).
    if (inDebugMode) {
      debugPrint('############ Event: deactivate in $this');
    }
  }

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  // ignore: unnecessary_overrides
  void activate() {
    super.activate();

    /// In some cases, however, after a [State] object has been deactivated, the
    /// framework will reinsert it into another part of the tree (e.g., if the
    /// subtree containing this [State] object is grafted from one location in
    /// the tree to another due to the use of a [GlobalKey]). If that happens,
    /// the framework will call [activate] to give the [State] object a chance to
    /// reacquire any resources that it released in [deactivate]. It will then
    /// also call [build] to give the object a chance to adapt to its new
    /// location in the tree.
    ///
    /// The framework does not call this method the first time a [State] object
    /// is inserted into the tree. Instead, the framework calls [initState] in
    /// that situation.
    if (inDebugMode) {
      debugPrint('############ Event: activate in $this');
    }
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU WILL HAVE NO IDEA WHEN THIS WILL RUN in the Framework.
  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();

    /// The framework calls this method when this [StateX] object will never
    /// build again. The [State] object's lifecycle is terminated.
    /// Subclasses should override this method to release any resources retained
    /// by this object (e.g., stop any active animations).
    if (inDebugMode) {
      debugPrint('############ Event: dispose in $this');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  // ignore: unnecessary_overrides
  void didUpdateWidget(RandomDog oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// The framework always calls build() after calling [didUpdateWidget], which
    /// means any calls to [setState] in [didUpdateWidget] are redundant.
    if (inDebugMode) {
      debugPrint('############ Event: didUpdateWidget in $this');
    }
  }

  /// Called when immediately after [initState].
  /// Otherwise called only if a dependency of an [InheritedWidget].
  @override
  // ignore: unnecessary_overrides
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///
    /// if a State object's [build] references an [InheritedWidget] with
    /// [context.dependOnInheritedWidgetOfExactType]
    /// its Widget is now a 'dependency' of that that InheritedWidget.
    /// Later, if that InheritedWidget's build() function is called, all its dependencies
    /// build() functions are also called but not before this method again.
    /// Subclasses rarely use this method, but its an option if needed.
    if (inDebugMode) {
      debugPrint('############ Event: didChangeDependencies in $this');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  // ignore: unnecessary_overrides
  void reassemble() {
    super.reassemble();

    /// Called whenever the application is reassembled during debugging, for
    /// example during hot reload.
    ///
    /// This method should rerun any initialization logic that depends on global
    /// state, for example, image loading from asset bundles (since the asset
    /// bundle may have changed).
    if (inDebugMode) {
      debugPrint('############ Event: reassemble in $this');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  ///
  /// Observers are notified in registration order until one returns
  /// true. If none return true, the application quits.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification, for example by closing an active dialog
  /// box, and false otherwise. The [WidgetsApp] widget uses this
  /// mechanism to notify the [Navigator] widget that it should pop
  /// its current route if possible.
  ///
  /// This method exposes the `popRoute` notification from
  // ignore: comment_references
  /// [SystemChannels.navigation].
  @override
  // ignore: unnecessary_overrides
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      debugPrint('############ Event: didPopRoute in $this');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification. Observers are notified in registration
  /// order until one returns true.
  ///
  /// This method exposes the `popRoute` notification from
  // ignore: comment_references
  /// [SystemChannels.navigation].
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      debugPrint('############ Event: didPushRouteInformation in $this');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when this State is *first* added to as a Route observer?!
  @override
  void didPush() {
    if (inDebugMode) {
      debugPrint('############ Event: didPush in $this');
    }
    super.didPush();
  }

  /// New route has been pushed, and this State object's route is no longer current.
  @override
  void didPushNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPushNext in $this');
    }
    super.didPushNext();
  }

  /// Called when this State is popped off a route.
  @override
  void didPop() {
    if (inDebugMode) {
      debugPrint('############ Event: didPop in $this');
    }
    super.didPop();
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPopNext in $this');
    }
    super.didPopNext();
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    /// Called when the application's dimensions change. For example,
    /// when a phone is rotated.
    ///
    /// In general, this is not overridden often as the layout system takes care of
    /// automatically recomputing the application geometry when the application
    /// size changes
    ///
    /// This method exposes notifications from [Window.onMetricsChanged].
    /// See sample code below. No need to call super if you override.
    ///   @override
    ///   void didChangeMetrics() {
    ///     setState(() { _lastSize = ui.window.physicalSize; });
    ///   }
    if (inDebugMode) {
      debugPrint('############ Event: didChangeMetrics in $this');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();

    /// Called when the platform's text scale factor changes.
    ///
    /// This typically happens as the result of the user changing system
    /// preferences, and it should affect all of the text sizes in the
    /// application.
    ///
    /// This method exposes notifications from [Window.onTextScaleFactorChanged].
    /// See sample code below. No need to call super if you override.
    ///   @override
    ///   void didChangeTextScaleFactor() {
    ///     setState(() { _lastTextScaleFactor = ui.window.textScaleFactor; });
    ///   }
    if (inDebugMode) {
      debugPrint('############ Event: didChangeTextScaleFactor in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (inDebugMode) {
      debugPrint('############ Event: didChangePlatformBrightness in $this');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    /// Called when the system tells the app that the user's locale has
    /// changed. For example, if the user changes the system language
    /// settings.
    ///
    /// This method exposes notifications from [Window.onLocaleChanged].
    if (inDebugMode) {
      debugPrint('############ Event: didChangeLocales in $this');
    }
  }

  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeAppLifecycleState in $this');
    }

    super.didChangeAppLifecycleState(state);

    /// Passing these possible values:
    /// AppLifecycleState.detached
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.hidden
    /// AppLifecycleState.paused (may enter the suspending state at any time)
  }

  /// The application is visible and responding to user input.
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: resumedLifecycleState in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  ///
  /// On iOS, this state corresponds to an app or the Flutter host view running
  /// in the foreground inactive state. Apps transition to this state when in
  /// a phone call, responding to a TouchID request, when entering the app
  /// switcher or the control center, or when the UIViewController hosting the
  /// Flutter app is transitioning.
  ///
  /// On Android, this corresponds to an app or the Flutter host view running
  /// in the foreground inactive state.  Apps transition to this state when
  /// another activity is focused, such as a split-screen app, a phone call,
  /// a picture-in-picture app, a system dialog, or another window.
  ///
  /// Apps in this state should assume that they may be ['pausedLifecycleState]' at any time.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: inactiveLifecycleState in $this');
    }
  }

  /// All views of an application are hidden, either because the application is
  /// about to be paused (on iOS and Android), or because it has been minimized
  /// or placed on a desktop that is no longer visible (on non-web desktop), or
  /// is running in a window or tab that is no longer visible (on the web).
  @override
  void hiddenAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: hiddenLifecycleState in $this');
    }
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: pausedLifecycleState in $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();

    /// Called when the system is running low on memory.
    ///
    /// This method exposes the `memoryPressure` notification from
    /// [SystemChannels.system].
    if (inDebugMode) {
      debugPrint('############ Event: didHaveMemoryPressure in $this');
    }
  }

  /// Called when a request is received from the system to exit the application.
  /// Exiting the application can proceed with
  ///    AppExitResponse.exit;
  /// Cancel and do not exit the application with
  ///    AppExitResponse.cancel;
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    if (inDebugMode) {
      debugPrint('############ Event: didRequestAppExit in $this');
    }
    await super.didRequestAppExit();
    return AppExitResponse.exit;
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();

    /// Called when the system changes the set of currently active accessibility
    /// features.
    if (inDebugMode) {
      debugPrint('############ Event: didChangeAccessibilityFeatures in $this');
    }
  }
}
