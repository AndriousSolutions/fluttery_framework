//
import 'dart:async' show unawaited;

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/model.dart' show Settings;

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import 'package:fluttery_framework_example/src/view.dart';

class TemplateController extends AppController {
  factory TemplateController() => _this ??= TemplateController._();
  TemplateController._()
      : wordPairsTimer = WordPairsController(),
        super();
  static TemplateController? _this;

  final WordPairsController wordPairsTimer;

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
  final _appNames = ['Counter', 'Word Pairs', 'Contacts'];

  Widget onHome() {
    //
    _appCount = Prefs.getInt('appRun');

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

    unawaited(Prefs.setBool('words', _appNames[_appCount] == 'Word'));

    Prefs.setInt('appRun', _appCount).then((value) => App.setState(() {}));
  }

  Locale appLocale() {
    Locale locale;

    /// Prefer the preference
    final localeTag = Prefs.getString('locale');
    final codes = localeTag.split('-');
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
    } else {
      // the app's locale
      locale = L10n.locale;
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
            App.locale = locale;
            await Prefs.setString('locale', locale.toLanguageTag());
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
        shrinkWrap: true);
  }

  void aboutApp() => showAboutDialog(
        context: App.context!,
        applicationName: App.state?.title ?? '',
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

  /// Clear itself
  @override
  void dispose() {
    _this = null;
    super.dispose();
  }

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
}
