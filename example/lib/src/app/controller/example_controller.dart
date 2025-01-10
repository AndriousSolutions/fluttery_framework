//
import '/src/controller.dart';

import '/src/model.dart' show Settings;

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import '/src/view.dart';

///
class ExampleAppController extends AppStateXController {
  ///
  factory ExampleAppController() => _this ??= ExampleAppController._();
  ExampleAppController._();
  static ExampleAppController? _this;

  /// Use the Router Configuration or not
  bool useRouterConfig = false;

  /// Error in builder()
  bool errorInBuilder = false;

  /// Store the boolean allowing for errors or not.
  bool initAsyncError = false;

  /// Error right at the start
  bool errorAtStartup = false;

  /// Assign to the 'leading' widget on the interface.
  void leading() => changeUI();

  /// Switch to the other User Interface.
  void changeUI() {
    //
//    Navigator.popUntil(App.context!, ModalRoute.withName('/'));
    App.popUntil(ModalRoute.withName('/'));

    // This has to be called first.
    App.changeUI(App.useMaterial ? 'Cupertino' : 'Material');

    bool switchUI;
    if (App.useMaterial) {
      if (UniversalPlatform.isAndroid) {
        switchUI = false;
      } else {
        switchUI = true;
      }
    } else {
      if (UniversalPlatform.isAndroid) {
        switchUI = true;
      } else {
        switchUI = false;
      }
    }
    Prefs.setBool('switchUI', switchUI);
  }

  /// Allow to switch Interface
  bool get switchUI => Prefs.getBool('switchUI');

  /// Indicate if the Counter app is to run.
  bool get counterApp => _appNames[_appCount] == 'Counter';

  /// Indicate if the Words app is to run.
  bool get wordsApp => _appNames[_appCount] == 'Word Pairs';

  /// Indicate if the Contacts app is to run.
  bool get contactsApp => _appNames[_appCount] == 'Contacts';

  int _appCount = 0;
  final _appNames = ['Counter', 'Word Pairs', 'Inherited'];

  ///
  Widget onHome() {
    //
    _appCount = Prefs.getInt('appRun');

    // Ensure a valid index has been saved.
    if (_appCount < 0 || _appCount > _appNames.length - 1) {
      _appCount = 0;
    }

    Widget? widget;

    switch (_appNames[_appCount]) {
      case 'Word Pairs':
        widget = const WordPairs();
        break;
      case 'Counter':
        widget = CounterPage(
          key: UniqueKey(), //  UniqueKey() for built-in InheritedWidget
        );
        break;
      case 'Inherited':
        widget = const HomePage();
        break;
      default:
        widget = const SizedBox();
    }
    return widget;
  }

  /// Supply what the interface
  String get application => _appNames[_appCount];

  /// Switch to the other application.
  Future<void> changeApp([String? appName = '']) async {
    //
    if (appName == null ||
        appName.isEmpty ||
        !_appNames.contains(appName.trim())) {
      //
      _appCount++;

      if (_appCount == _appNames.length) {
        _appCount = 0;
      }
    } else {
      _appCount = _appNames.indexOf(appName.trim());
    }

    await Prefs.setBool('words', _appNames[_appCount] == 'Word');

    // Rerun the whole app with App.setState(() {})
    await Prefs.setInt('appRun', _appCount);

    App.setState(() {});
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
    );

    await DialogBox(
      context: app.lastContext!,
      title: 'Current Language'.tr,
      body: [spinner],
      press01: () {},
      press02: () => App.changeLocale(appLocale),
      switchButtons: Settings.getLeftHanded(),
    ).show();
  }

  /// Change the app's colour theme
  Future<void> changeColor() async {
    // Get the current colour.
    ColorPicker.color = Color(App.themeData!.primaryColor.toARGB32);

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

  /// Supply the app's popupmenu
  /// an immutable menu
  Widget get menu => AppPopupMenu(
        key: const Key('appMenuButton'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        position: PopupMenuPosition.under,
        menuEntries: [
          PopupMenuItem(
            key: const Key('interfaceMenuItem'),
            value: 'interface',
            child: Text(
                '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
          ),
          PopupMenuItem(
            key: const Key('applicationMenuItem'),
            value: 'application',
            child: Text('${'Application:'.tr} $application'),
          ),
          PopupMenuItem(
            key: const Key('localeMenuItem'),
            value: 'locale',
            child: Text(
                '${'Locale:'.tr} ${App.appState!.locale!.toLanguageTag()}'),
          ),
          if (App.useMaterial)
            PopupMenuItem(
              key: const Key('colorMenuItem'),
              value: 'color',
              child: L10n.t('Colour Theme'),
            ),
          PopupMenuItem(
            key: const Key('aboutMenuItem'),
            value: 'about',
            child: L10n.t('About'),
          ),
        ],
        inSelected: (String value) async {
          switch (value) {
            case 'interface':
              changeUI();
              break;
            case 'application':
              await changeApp();
              break;
            case 'locale':
              await changeLocale();
              break;
            case 'color':
              await changeColor();
              break;
            case 'about':
              aboutApp();
              break;
            default:
          }
        },
      );

  /// **************  Life cycle events ****************

  /// Called to complete any asynchronous operations.
  /// In production, this is where databases are opened, logins attempted, etc.
  @override
  Future<bool> initAsync() async {
    //
    final init = await super.initAsync();

    // ignore: unused_local_variable
    final widget = appState!.widget as FlutteryExampleApp;

    // Don't delay if in testing for example
    if (App.inWidgetsFlutterBinding) {
      // For demonstration purposes, wait for the Splash Screen to appear for a time at startup.
      await Future<bool>.delayed(const Duration(seconds: 10), () {
        return true;
      });
    }

    //
    if (initAsyncError) {
      initAsyncError = false;
      throw Exception('Error in initAsync()!');
    }

    if (inDebugMode) {
      debugPrint('############ Event: initAsync() in $this');
    }
    return init;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      debugPrint('############ Event: deactivate() in $this');
    }
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
      debugPrint('############ Event: pausedLifecycleState() in $this');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: resumedLifecycleState() in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: inactiveLifecycleState() in $this');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    if (inDebugMode) {
      debugPrint('############ Event: detachedLifecycleState() in $this');
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
