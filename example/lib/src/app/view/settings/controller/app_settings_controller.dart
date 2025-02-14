//
import '/src/controller.dart';

///
class AppSettingsController extends StateXController with AppOptionSettings {
  /// Singleton Pattern
  factory AppSettingsController() => _this ??= AppSettingsController._();
  AppSettingsController._() {
    init();
  }
  static AppSettingsController? _this;

  /// init settings
  void init() {
    //
    _splashScreen = Prefs.getBool('splashScreen');

    /// Delay the initAsync() for a time
    _initAsyncDelay = Prefs.getBool('initAsyncDelay');

    _useRouterConfig = Prefs.getBool('useRouterConfig');

    _useRoutes = Prefs.getBool('useRoutes');

    _useHome = Prefs.getBool('useHome');

    _useOnHome = Prefs.getBool('useOnHome', true);  // Default option

    _useInheritedWidget = Prefs.getBool('useInheritedWidget');

    _errorInBuilder = Prefs.getBool('errorInBuilder');

    _initAsyncError = Prefs.getBool('initAsyncError');

    _buttonError = Prefs.getBool('buttonError');

    if (App.inFlutterTest) {
      // Set to the onHome() function
      setForOnHome();
    }else{
      // Ensure ae least one option is selected
      goOnHome();
    }
  }

  @override
  bool get useRouterConfig => _useRouterConfig;
  @override
  set useRouterConfig(bool? use) {
    if (use != null) {
      _useRouterConfig = use;
      Prefs.setBool('useRouterConfig', use);
    }
  }

  // Use Router Config. instead
  bool _useRouterConfig = false;

  @override
  bool get useRoutes => _useRoutes;
  @override
  set useRoutes(bool? use) {
    if (use != null) {
      _useRoutes = use;
      Prefs.setBool('useRoutes', use);
    }
  }

  // Use routes instead
  bool _useRoutes = false;

  @override
  bool get useHome => _useHome;
  @override
  set useHome(bool? use) {
    if (use != null) {
      _useHome = use;
      Prefs.setBool('useHome', use);
    }
  }

  // Use the home parameter
  bool _useHome = false;

  @override
  bool get useOnHome => _useOnHome;
  @override
  set useOnHome(bool? use) {
    if (use != null) {
      _useOnHome = use;
      Prefs.setBool('useOnHome', use);
    }
  }

  // Use the 'onHome' function
  bool _useOnHome = false;

  /// Test for least one option is selected
  bool hasNoHome() {
    var noHome = !useHome;
    if (noHome) {
      noHome = !useOnHome;
    }
    if (noHome) {
      noHome = !useRoutes;
    }
    if (noHome) {
      noHome = !useRouterConfig;
    }
    return noHome;
  }

  /// Ensure at least one option is used
  bool goOnHome() {
    final noHome = hasNoHome();
    if (noHome) {
      setState(() {});
      useOnHome = true;
    }
    return noHome;
  }

  /// During testing, set app to use the home parameter
  void setForOnHome() {
    // If running in a Flutter test
    // assert(() {
      useHome = false;
      useOnHome = true;
      useRoutes = false;
      useRouterConfig = false;
      // debugPrint("============ Set app to use 'home' parameter");
    //   return true;
    // }());
  }

  @override
  bool get useInheritedWidget => _useInheritedWidget;
  @override
  set useInheritedWidget(bool? use) {
    if (use != null) {
      _useInheritedWidget = use;
      Prefs.setBool('useInheritedWidget', use);
    }
  }

  // Have a StateX object use its built-in InheritedWidget
  bool _useInheritedWidget = false;

  /// Error in builder()
  @override
  bool get errorInBuilder => _errorInBuilder;
  @override
  set errorInBuilder(bool? error) {
    if (error != null) {
      _errorInBuilder = error;
      Prefs.setBool('errorInBuilder', error);
    }
  }

  // Throw an error in a build() function
  bool _errorInBuilder = false;

  /// Store the boolean allowing for errors or not.
  @override
  bool get initAsyncError => _initAsyncError;
  @override
  set initAsyncError(bool? error) {
    if (error != null) {
      _initAsyncError = error;
      Prefs.setBool('initAsyncError', error);
    }
  }

  // Throw an error in an initAsync() function
  bool _initAsyncError = false;

  /// Delay the initAsync() for a time
  @override
  bool get initAsyncDelay => _initAsyncDelay;
  @override
  set initAsyncDelay(bool? delay) {
    if (delay != null) {
      _initAsyncDelay = delay;
      Prefs.setBool('initAsyncDelay', delay);
    }
  }

  // Set a delay in an initAsync() function
  bool _initAsyncDelay = false;

  /// Display a Splash Screen
  @override
  bool get splashScreen => _splashScreen;
  @override
  set splashScreen(bool? splash) {
    if (splash != null) {
      _splashScreen = splash;
      Prefs.setBool('splashScreen', splash);
    }
  }

  // Display a Splash Screen at Start up
  bool _splashScreen = false;

  /// Throw button error
  @override
  bool get buttonError => _buttonError;
  @override
  set buttonError(bool? error) {
    if (error != null) {
      _buttonError = error;
      Prefs.setBool('buttonError', error);
    }
  }

  // Throw an error with a push of a button
  bool _buttonError = false;

  /// Call the setState() functions
  void setSettingState() {
    setState(() {});
    appState?.setState(() {});
  }
}
