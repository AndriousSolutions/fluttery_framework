//
import '/src/controller.dart';

import '/src/view.dart';

/// The App's menu
class AppMenu extends AppPopupMenu {
  /// Only one instance of the class
  factory AppMenu() => _this ??= AppMenu._();

  AppMenu._()
      : _con = AppController(),
        super(
          key: const Key('appMenuButton'),
          controller: AppMenuController(),
        );
  static AppMenu? _this;

  /// The App's controller
  final AppController _con;

  /// Supply the app's popupmenu
  /// a mutable menu
  /// Supply the menu options
  @override
  List<PopupMenuEntry<String>>? onMenuEntries() => [
        if (App.allowChangeUI)
          PopupMenuItem(
            key: const Key('interfaceMenuItem'),
            value: 'interface',
            child: Text(
                '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
          ),
        if (_con.allowChangeApp)
          PopupMenuItem(
            key: const Key('applicationMenuItem'),
            value: 'application',
            child: Text('Application: Grid App'.tr),
          ),
        if (App.allowChangeLocale)
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
            child: Text('Colour Theme'.tr),
          ),
        PopupMenuItem(
          key: const Key('aboutMenuItem'),
          value: 'about',
          child: Text('About'.tr),
        ),
      ];

  /// When an menu item is selected
  @override
  Future<void> onSelected(String value) async {
    switch (value) {
      case 'interface':
        _con.changeUI();
        break;
      case 'application':
        await _con.changeApp();
        break;
      case 'locale':
        await _con.changeLocale();
        break;
      case 'color':
        await _con.changeColor();
        break;
      case 'about':
        _con.aboutApp();
        break;
      default:
    }
  }
}

/// Uses the String type as menu options
class AppMenuController extends AppPopupMenuController {
  ///
  factory AppMenuController() => _this ??= AppMenuController._();
  AppMenuController._();
  static AppMenuController? _this;
}
