//
import '/src/controller.dart';

import '/src/model.dart' show Settings;

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import '/src/view.dart';

///
class ExampleAppController extends AppController {
  factory ExampleAppController() => _this ??= ExampleAppController._();
  ExampleAppController._() : super();
  static ExampleAppController? _this;

  /// Store the boolean allowing for errors or not.
  bool allowErrors = false;

  /// Error right at the start
  bool errorAtStartup = false;

  // Assign to the 'leading' widget on the interface.
  void leading() => changeUI();

  /// Switch to the other User Interface.
  void changeUI() {
    //
    Navigator.popUntil(App.context!, ModalRoute.withName('/'));

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

  /// Indicate if the Counter app is to run.
  bool get counterApp => _appNames[_appCount] == 'Counter';

  /// Indicate if the Words app is to run.
  bool get wordsApp => _appNames[_appCount] == 'Word Pairs';

  /// Indicate if the Contacts app is to run.
  bool get contactsApp => _appNames[_appCount] == 'Contacts';

  int _appCount = 0;
//  final _appNames = ['Counter', 'Word Pairs', 'Contacts', 'Inherited'];
  final _appNames = ['Counter', 'Word Pairs', 'Inherited'];

  Widget onHome() {
    //
    _appCount = Prefs.getInt('appRun');

    // Possibly running in a test and can't run the Contacts app
    // There's no sqlite in the test environment
    if (App.inFlutterTest && _appCount == 2) {
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

  // Supply what the interface
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

    // Possibly running in a test and can't run the Contacts app
    // There's no sqlite in the test environment
    if (App.inFlutterTest && _appCount == 2) {
      _appCount = 0;
    }

    await Prefs.setBool('words', _appNames[_appCount] == 'Word');

    // Rerun the whole app with App.setState(() {})
    await Prefs.setInt('appRun', _appCount);

    App.setState(() {});
  }

  Future<void> changeLocale() async {
    //
    final appState = rootState! as AppState;

    final locale = appState.locale!;

    final locales = appState.supportedLocales;

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
      context: appState.lastContext!,
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
    ColorPicker.color = Color(App.themeData!.primaryColor.value);

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
              changeApp();
              break;
            case 'locale':
              changeLocale();
              break;
            case 'color':
              changeColor();
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
  @override
  Future<bool> initAsync() async {
    final init = await super.initAsync();

    //
    state?.add(MaterialController());

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: initAsync() in $this');
    }

    //
    if (ExampleAppController().allowErrors) {
      throw Exception('error thrown in template_controller() in $this');
    }
    return init;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: deactivate() in $this');
    }
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: activate() in $this');
    }
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU DON'T KNOW WHEN THIS WILL RUN in the Framework.
  /// PERFORM ANY TIME-CRITICAL OPERATION IN deactivate() INSTEAD!
  @override
  void dispose() {
    // Clear itself? Would that be advisable?
    _this = null;

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ now disposed.');
    }
    super.dispose();
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: pausedLifecycleState() in $this');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: resumedLifecycleState() in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: inactiveLifecycleState() in $this');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: detachedLifecycleState() in $this');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didUpdateWidget() in $this');
    }
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeDependencies() in $this');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: reassemble() in $this');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPopRoute() in $this');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushRouteInformation() in $this');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeMetrics() in $this');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeTextScaleFactor() in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangePlatformBrightness() in $this');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeLocale() in $this');
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
          '############ Event: didChangeAppLifecycleState() in ${this.state} for $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didHaveMemoryPressure() in $this');
    }
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeAccessibilityFeatures() in $this');
    }
  }
}
