library;

///
///  The Controller for this app's Home Page StatefulWidget.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class GridAppController extends StateXController {
  ///
  factory GridAppController() => _this ??= GridAppController._();
  GridAppController._() : super();
  static GridAppController? _this;

  /// The List of Widgets
  List<Widget> get children => _imageList();

  List<Widget> _imageList() {
    // Default number is assigned if one is not provided.
    final List<Widget> images = [];
    final animals = [1, 2, 3, 4];

    int cnt = 0;
    int dog = 0;
    int cat = 0;
    int fox = 0;
    int bird = 0;

    const number = 12;
    const limit = 3;

    while (cnt < number) {
      // Shuffle the elements
      animals.shuffle();
      switch (animals[0]) {
        case 1:
          if (dog == limit) {
            // try again.
            continue;
          } else {
            dog++;
            images.add(RandomDog(key: Key('dog$dog')));
          }
          break;
        case 2:
          if (cat == limit) {
            // try again.
            continue;
          } else {
            cat++;
            images.add(RandomCat(key: Key('cat$cat')));
          }
          break;
        case 3:
          if (fox == limit) {
            // try again.
            continue;
          } else {
            fox++;
            images.add(RandomFox(key: Key('fox$fox')));
          }
          break;
        case 4:
          if (bird == limit) {
            // try again.
            continue;
          } else {
            bird++;
            images.add(RandomBird(key: Key('bird$bird')));
          }
          break;
      }
      cnt++;
    }
    return images;
  }

  ///
  void newBirds() => BirdController().newAnimals();

  ///
  void newCats() => CatController().newAnimals();

  ///
  void newDogs() => DogController().newAnimals();

  ///
  void newFoxes() => FoxController().newAnimals();

  /// **************  Life cycle events ****************

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
