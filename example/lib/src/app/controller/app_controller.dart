//
import '/src/controller.dart';

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import '/src/view.dart';

///
class AppController extends AppStateXController with AppOptionSettings {
  ///
  factory AppController() => _this ??= AppController._();

  AppController._() {
    // App's Settings
    _appSettings = AppSettingsController();
  }
  static AppController? _this;

  /// Switch to the other User Interface.
  void changeUI() {
    //
    Navigator.popUntil(App.context!, ModalRoute.withName('/'));

    // This has to be called first.
    App.changeUI(App.useMaterial ? 'Cupertino' : 'Material');

    Prefs.setBool('switchUI', App.appState?.switchUI ?? false);
  }

  /// Allow to switch Interface
  bool get switchUI => Prefs.getBool('switchUI');

  /// Switch to the other application.
  Future<void> changeApp() async {
    const widget = GridPage();
    Route<dynamic> route;
    if (App.useMaterial) {
      route = MaterialPageRoute(builder: (_) => widget);
    } else {
      route = CupertinoPageRoute(builder: (_) => widget);
    }
    final context = App.context;
    if (context != null) {
      _allowChangeApp = false;
      await Navigator.push(context, route);
      _allowChangeApp = true;
    }
  }

  ///
  Future<void> changeLocale() async {
    ///
    final app = appState!;

    final locale = app.locale!;

    final locales = app.supportedLocales;

    // record selected locale
    Locale? appLocale;

    final spinner = SpinnerCupertino<Locale>(
      initValue: locale,
      values: locales,
      itemBuilder: (BuildContext context, int index) => Text(
        locales[index].countryCode == null
            ? locales[index].languageCode
            : '${locales[index].languageCode}-${locales[index].countryCode}',
        style: const TextStyle(fontSize: 20),
      ),
      onSelectedItemChanged: (int index) async {
        appLocale = L10n.getLocale(index);
      },
      mouseUse: kIsWeb || UniversalPlatform.isWindows,
    );

    await DialogBox(
      context: app.lastContext!,
      title: 'Current Language'.tr,
      body: [spinner],
      press01: () {},
      press02: () => App.changeLocale(appLocale),
    ).show();
  }

  /// Change the app's colour theme
  Future<void> changeColor() async {
    // Get the current colour.
    ColorPicker.color = Color(App.themeData!.primaryColor.toARGB32());

    await ColorPicker.showColorPicker(
      context: App.context!,
      onColorChange: (Color value) {
        /// Implement to take in a color change.
      },
      onChange: ([ColorSwatch<int?>? value]) {
        App.setThemeData(swatch: value);
        App.setState(() {});
      },
    );
  }

  ///
  void aboutApp() => showAboutDialog(
        context: App.context!,
        applicationName: App.appState?.title ?? '',
        applicationVersion: 'version: ${App.version} build: ${App.buildNumber}',
      );

  // /// Supply the app's popupmenu
  // /// an immutable menu
  // Widget get menu => AppPopupMenu(
  //       key: const Key('appMenuButton'),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       position: PopupMenuPosition.under,
  //       menuEntries: [
  //         PopupMenuItem(
  //           key: const Key('interfaceMenuItem'),
  //           value: 'interface',
  //           child: Text(
  //               '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
  //         ),
  //         PopupMenuItem(
  //           key: const Key('applicationMenuItem'),
  //           value: 'application',
  //           child: Text('Application: Grid App'.tr),
  //         ),
  //         PopupMenuItem(
  //           key: const Key('localeMenuItem'),
  //           value: 'locale',
  //           child: Text(
  //               '${'Locale:'.tr} ${App.appState!.locale!.toLanguageTag()}'),
  //         ),
  //         if (App.useMaterial)
  //           PopupMenuItem(
  //             key: const Key('colorMenuItem'),
  //             value: 'color',
  //             child: L10n.t('Colour Theme'),
  //           ),
  //         PopupMenuItem(
  //           key: const Key('aboutMenuItem'),
  //           value: 'about',
  //           child: L10n.t('About'),
  //         ),
  //       ],
  //       inSelected: (String value) async {
  //         switch (value) {
  //           case 'interface':
  //             changeUI();
  //             break;
  //           case 'application':
  //             await changeApp();
  //             break;
  //           case 'locale':
  //             await changeLocale();
  //             break;
  //           case 'color':
  //             await changeColor();
  //             break;
  //           case 'about':
  //             aboutApp();
  //             break;
  //           default:
  //         }
  //       },
  //     );

  /// Supply the App's routes
  Map<String, Widget> get routes => {
        '/': const CounterPage(),
        '/Page1': const Page1(),
        '/Page2': const Page2(),
        '/Page3': const Page3(),
      };

  ///
  Route<dynamic>? onGenerateRoute(RouteSettings? settings) {
    final routes = <String, WidgetBuilder>{};
    this.routes.forEach((key, widget) => routes.addAll({key: (_) => widget}));
    return appState?.routeGenerator(settings, routes);
  }

  /// **************  App settings **************

  AppSettingsController? _appSettings;

  /// Use the Router Configuration or not
  @override
  bool get useRouterConfig => _appSettings?.useRouterConfig ?? false;

  @override
  set useRouterConfig(bool? use) => _appSettings?.useRouterConfig = use;

  /// Use the provided Routes instead
  @override
  bool get useRoutes => _appSettings?.useRoutes ?? false;

  @override
  set useRoutes(bool? use) => _appSettings?.useRoutes = use;

  /// Use InheritedWidget
  @override
  bool get useInheritedWidget => _appSettings?.useInheritedWidget ?? false;

  /// Use the home parameter
  @override
  bool get useHome =>
      _appSettings?.useHome ?? false; //!useRoutes && !useInheritedWidget;

  /// During testing, set app to use the onHome function
  void setForHome() => _appSettings?.setForOnHome();

  /// Test if no 'home' to start with has been set
  bool hasNoHome() => _appSettings?.hasNoHome() ?? false;

  /// Set the onHome function
  void setForOnHome() => _appSettings?.setForOnHome();

  /// Allow to change app
  bool get allowChangeApp => useOnHome && _allowChangeApp;
  bool _allowChangeApp = true;

  /// Use the onHome() function
  @override
  bool get useOnHome => _appSettings?.useOnHome ?? true;

  /// Error in builder()
  @override
  bool get errorInBuilder => _appSettings?.errorInBuilder ?? false;

  @override
  set errorInBuilder(bool? error) => _appSettings?.errorInBuilder = error;

  /// Error right at the start
  @override
  bool get initAsyncError => _appSettings?.initAsyncError ?? false;

  @override
  set initAsyncError(bool? error) => _appSettings?.initAsyncError = error;

  /// Delay the initAsync() for a time
  @override
  bool get initAsyncDelay => _appSettings?.initAsyncDelay ?? false;

  /// Throw button error
  @override
  bool get buttonError => _appSettings?.buttonError ?? false;

  /// Throw a specific Error
  void throwErrorOnce(Error? error) {
    // Allow for null parameter
    if (error != null) {
      // Allow one 'error' to occur
      appState?.ignoreErrorInTesting = true;
      // Note, this will only work during testing.
      if (appState?.ignoreErrorInTesting ?? false) {
        throw error;
      }
    }
  }

  /// A flag indicating whether an Error or Exception can occur
  bool get allowErrorOnce => appState?.ignoreErrorInTesting ?? false;

  /// Set a means to throw an error but only during testing.
  set allowErrorOnce(bool? allow) => appState?.ignoreErrorInTesting = allow;

  /// **************  Life cycle events ****************

  /// Called to complete any asynchronous operations.
  /// In production, this is where databases are opened, logins attempted, etc.
  @override
  Future<bool> initAsync() async {
    final init = await super.initAsync();

    // ignore: unused_local_variable
    final widget = appState!.widget as FlutteryExampleApp;

    // If delay here in the Async()
    if (initAsyncDelay) {
      // Don't delay if in testing for example
      if (App.inWidgetsFlutterBinding) {
        // For demonstration purposes, wait for the Splash Screen to appear for a time at startup.
        await Future<bool>.delayed(const Duration(seconds: 10), () {
          return true;
        });
      }
    }

    // Throw an error here and see how it's handled.
    if (initAsyncError) {
      throw Exception('Error in initAsync()!');
    }

    if (inDebugMode) {
      debugPrint('############ Event: initAsync() in $this');
    }
    return init;
  }

  // You can address any errors in initAsync() function
  @override
  void onAsyncError(FlutterErrorDetails details) {
    // Identify a particular error and ensure it won't happen at restart
    if (details.exceptionAsString().contains('Error in initAsync()!')) {
      initAsyncError = false;
      App.logErrorDetails(details);
    }
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      debugPrint('############ Event: deactivate() in $this');
    }
    _appSettings?.goOnHome();
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
      debugPrint('############ Event: activate() in $this');
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
      debugPrint('############ Event: pausedAppLifecycleState() in $this');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: resumedAppLifecycleState() in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: inactiveAppLifecycleState() in $this');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: detachedAppLifecycleState() in $this');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    if (inDebugMode) {
      debugPrint('############ Event: didUpdateWidget() in $this');
    }
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeDependencies() in $this');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    if (inDebugMode) {
      debugPrint('############ Event: reassemble() in $this');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      debugPrint('############ Event: didPopRoute() in $this');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      debugPrint('############ Event: didPushRouteInformation() in $this');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when this State is *first* added to as a Route observer?!
  @override
  void didPush() {
    if (inDebugMode) {
      debugPrint('############ Event: didPush() in $this');
    }
    super.didPush();
  }

  /// New route has been pushed, and this State object's route is no longer current.
  @override
  void didPushNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPushNext() in $this');
    }
    super.didPushNext();
  }

  /// Called when this State is popped off a route.
  @override
  void didPop() {
    if (inDebugMode) {
      debugPrint('############ Event: didPop() in $this');
    }
    super.didPop();
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    if (inDebugMode) {
      debugPrint('############ Event: didPopNext() in $this');
    }
    super.didPopNext();
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeMetrics() in $this');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeTextScaleFactor() in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (inDebugMode) {
      debugPrint('############ Event: didChangePlatformBrightness() in $this');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (inDebugMode) {
      debugPrint('############ Event: didChangeLocale() in $this');
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
          '############ Event: didChangeAppLifecycleState() in $appState for $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    if (inDebugMode) {
      debugPrint('############ Event: didHaveMemoryPressure() in $this');
    }
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    if (inDebugMode) {
      debugPrint(
          '############ Event: didChangeAccessibilityFeatures() in $this');
    }
  }
}
