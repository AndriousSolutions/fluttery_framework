//
import '/src/controller.dart';

///
class AppSettingsController extends StateXController with AppOptionSettings {
  /// Singleton Pattern
  factory AppSettingsController() => _this ??= AppSettingsController._();

  AppSettingsController._();
  static AppSettingsController? _this;

  /// Called in the Settings screen
  @override
  void initState() {
    super.initState();
    // Set the 'onHome' setting if necessary
    goOnHome();
  }

  /// Delay the initAsync() for a time
  @override
  bool get initAsyncDelay => Prefs.getBool('initAsyncDelay');

  @override
  set initAsyncDelay(bool? delay) => Prefs.setBool('initAsyncDelay', delay);

  @override
  bool get useRoutes => _useRoutes = Prefs.getBool('useRoutes');

  @override
  set useRoutes(bool? use) {
    if (use != null) {
      _useRoutes = use;
      Prefs.setBool('useRoutes', use);
    }
  }

  bool _useRoutes = false;

  @override
  bool get useHome => _useHome = Prefs.getBool('useHome');

  @override
  set useHome(bool? use) {
    if (use != null) {
      _useHome = use;
      Prefs.setBool('useHome', use);
    }
  }

  bool _useHome = true;

  @override
  bool get useOnHome {
    _useOnHome = Prefs.getBool('useOnHome', true);
    if (!_useOnHome) {
      if (App.inFlutterTest && hasNoHome()) {
        // Set to the onHome() function
        setForOnHome();
      }
    }
    return _useOnHome;
  }

  @override
  set useOnHome(bool? use) {
    if (use != null) {
      _useOnHome = use;
      Prefs.setBool('useOnHome', use);
    }
  }

  bool _useOnHome = false;

  @override
  bool get useRouterConfig =>
      _useRouterConfig = Prefs.getBool('useRouterConfig');

  @override
  set useRouterConfig(bool? use) {
    if (use != null) {
      _useRouterConfig = use;
      Prefs.setBool('useRouterConfig', use);
    }
  }

  bool _useRouterConfig = false;

  @override
  bool get useInheritedWidget => Prefs.getBool('useInheritedWidget');

  @override
  set useInheritedWidget(bool? use) => Prefs.setBool('useInheritedWidget', use);

  /// Error in builder()
  @override
  bool get errorInBuilder => Prefs.getBool('errorInBuilder', false);

  @override
  set errorInBuilder(bool? error) => Prefs.setBool('errorInBuilder', error);

  /// Store the boolean allowing for errors or not.
  @override
  bool get initAsyncError => Prefs.getBool('initAsyncError');

  @override
  set initAsyncError(bool? error) => Prefs.setBool('initAsyncError', error);

  /// Throw button error
  @override
  bool get buttonError => Prefs.getBool('buttonError');

  @override
  set buttonError(bool? error) => Prefs.setBool('buttonError', error);

  /// Call the setState() functions
  void setSettingState() {
    setState(() {});
    appState?.setState(() {});
  }

  /// Ensure at least one option is used
  bool goOnHome() {
    final noHome = hasNoHome();
    if (noHome) {
      setState(() {});
      useOnHome = true;
    }
    return useOnHome;
  }

  /// Test for least one option is selected
  bool hasNoHome() {
    var noHome = !_useHome;
    if (noHome) {
      noHome = !_useOnHome;
    }
    if (noHome) {
      noHome = !_useRoutes;
    }
    if (noHome) {
      noHome = !_useRouterConfig;
    }
    return noHome;
  }

  /// During testing, set app to use the home parameter
  void setForOnHome() {
    useHome = false;
    useOnHome = true;
    useRoutes = false;
    useRouterConfig = false;
  }
}
