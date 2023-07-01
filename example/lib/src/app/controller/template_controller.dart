//
import 'dart:async' show unawaited;

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/model.dart' show Settings;

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import 'package:fluttery_framework_example/src/view.dart';

///
///
class ExampleAppController extends AppController {
  factory ExampleAppController() => _this ??= ExampleAppController._();
  ExampleAppController._()
      : wordPairsTimer = WordPairsController(),
        super();
  static ExampleAppController? _this;

  final WordPairsController wordPairsTimer;

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
  final _appNames = ['Counter', 'Word Pairs', 'Contacts', 'Inherited'];

  Widget onHome() {
    //
    _appCount = Prefs.getInt('appRun');

    // Possibly running in a test and can't run the Contacts app
    // There's no sqlite in the test environment
    if (App.inFlutterTest && _appCount == 2) {
      _appCount = 0;
    }

    final Key key = UniqueKey();

    Widget? widget;

    switch (_appNames[_appCount]) {
      case 'Word Pairs':
        widget = WordPairs(key: key);
        break;
      case 'Counter':
        widget = CounterPage(key: key);
        break;
      case 'Contacts':
        widget = ContactsList(key: key);
        break;
      case 'Inherited':
        widget = HomePage(key: key);
        break;
      default:
        widget = const SizedBox();
    }
    return widget;
  }

  // Supply what the interface
  String get application => _appNames[_appCount];

  /// Switch to the other application.
  void changeApp([String? appName = '']) {
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

    unawaited(Prefs.setBool('words', _appNames[_appCount] == 'Word'));

    // Rerun the whole app with App.setState(() {})
    Prefs.setInt('appRun', _appCount).then((value) => App.setState(() {}));
  }

  Locale appLocale() {
    Locale locale;

    /// Prefer the preference
    final localeTag = Prefs.getString('locale');
    final codes = localeTag.split('-');
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
      App.locale = locale;
    } else {
      // the app's locale
      // Possibly the device's locale.
      locale = App.locale!;
    }
    return locale;
  }

  Future<void> changeLocale() async {
    //

    /// Prefer the preference
    final localeTag = Prefs.getString('locale');

    final codes = localeTag.split('-');

    Locale locale;
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
    } else {
      locale = App.locale!;
    }

    final locales = App.supportedLocales!;

    final initialItem = locales.indexOf(locale);

    final spinner = ISOSpinner(
        initialItem: initialItem,
        supportedLocales: locales,
        onSelectedItemChanged: (int index) async {
          // Retrieve the available locales.
          final locale = L10n.getLocale(index);
          if (locale != null) {
            await Prefs.setString('locale', locale.toLanguageTag());
//            App.locale = locale;
            App.setState(() {});
          }
        });

    await DialogBox(
      title: 'Current Language'.tr,
      body: [spinner],
      press01: () {
        spinner.onSelectedItemChanged(initialItem);
      },
      press02: () {},
      switchButtons: Settings.getLeftHanded(),
    ).show();

    // If the current app is the 'counter' app
    if (counterApp) {
      // Has to be initialized again for some reason??
      initTimer();
    }
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
      shrinkWrap: true,
    );
  }

  void aboutApp() => showAboutDialog(
        context: App.context!,
        applicationName: App.appState?.title ?? '',
        applicationVersion: 'version: ${App.version} build: ${App.buildNumber}',
      );

  // /// Retrieve the app's own controller.
  // TemplateController get appController =>
  //     _appController ??= App.vw!.con as TemplateController;
  // TemplateController? _appController;

  /// Start up the timer
  void initTimer() => wordPairsTimer.initTimer();

  /// Cancel the timer
  void cancelTimer() => wordPairsTimer.cancelTimer();

  /// Supply the app's popupmenu
  /// an immutable menu
  Widget get menu => PopupMenu(
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
            child: Text('${'Locale:'.tr} ${App.locale!.toLanguageTag()}'),
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
        onSelected: (String value) async {
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
    if (ExampleAppController().allowErrors) {
      throw AssertionError('error thrown in Page1State.initAsync()');
    }
    return init;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: deactivate in $state');
    }
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: activate in $state');
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
  void pausedLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: pausedLifecycleState in $state');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: resumedLifecycleState in $state');
    }
  }

  /// If a State object is unexpectedly re-created
  /// You have to 'update' the properties of the new StateX object using the
  /// old StateX object because it's going to be disposed of.
  @override
  void updateNewStateX(oldState) {
    /// When a State object destroyed and a new one is re-created!
    /// This new StateX object may need to be updated with the old State object
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: updateNewStateX in $state');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: inactiveLifecycleState in $state');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: detachedLifecycleState in $state');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didUpdateWidget in $state');
    }
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeDependencies in $state');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: reassemble in $state');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPopRoute in $state');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  @override
  Future<bool> didPushRoute(String route) async {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushRoute in $state');
    }
    return super.didPushRoute(route);
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushRouteInformation in $state');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeMetrics in $state');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeTextScaleFactor in $state');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangePlatformBrightness in $state');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeLocale in $state');
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
          '############ Event: didChangeAppLifecycleState in ${this.state} for $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didHaveMemoryPressure in $state');
    }
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeAccessibilityFeatures in $state');
    }
  }
}
