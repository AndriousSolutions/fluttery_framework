//
import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// The App's menu
class AppMenu {
  /// Only one instance of the class
  factory AppMenu() => _this ??= AppMenu._();
  static AppMenu? _this;

  AppMenu._() : _con = ExampleAppController() {
    //
    App.menu.key = const Key('appMenuButton');

    /// When an menu item is selected
    App.menu.onSelected = (String value) async {
      switch (value) {
        case 'interface':
          _con.changeUI();
          break;
        case 'application':
          _con.changeApp();
          break;
        case 'locale':
          _con.changeLocale();
          break;
        case 'color':
          _con.changeColor();
          break;
        case 'about':
          _con.aboutApp();
          break;
        default:
      }
    };
  }

  /// The App's controller
  final ExampleAppController _con;

  /// Supply the app's popupmenu
  /// a mutable menu
  Widget get popupMenuButton {
    /// Supply the menu options
    App.menu.menuEntries = [
      PopupMenuItem(
        key: const Key('interfaceMenuItem'),
        value: 'interface',
        child: Text(
            '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
      ),
      PopupMenuItem(
        key: const Key('applicationMenuItem'),
        value: 'application',
        child: Text('${'Application:'.tr} ${_con.application}'),
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
          child: Text('Colour Theme'.tr),
        ),
      PopupMenuItem(
        key: const Key('aboutMenuItem'),
        value: 'about',
        child: Text('About'.tr),
      ),
    ];
    return App.menu.popupMenuButton;
  }
}
