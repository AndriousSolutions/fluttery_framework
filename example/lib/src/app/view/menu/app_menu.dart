//
import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// The App's menu
class AppMenu extends AppPopupMenu {
  /// Only one instance of the class
  factory AppMenu() => _this ??= AppMenu._();
  static AppMenu? _this;

  AppMenu._()
      : _con = ExampleAppController(),
        super(
          key: const Key('appMenuButton'),
          controller: AppMenuController(),
        );

  /// The App's controller
  final ExampleAppController _con;

  /// Supply the app's popupmenu
  /// a mutable menu
  /// Supply the menu options
  @override
  List<PopupMenuEntry<String>>? onMenuEntries() => [
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

  /// When an menu item is selected
  @override
  void onSelected(String value) async {
    switch (value) {
      case 'interface':
        _con.changeUI();
        break;
      case 'application':
        await _con.changeApp();
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
  }
}

/// Uses the String type as menu options
class AppMenuController extends AppPopupMenuController {
  factory AppMenuController() => _this ??= AppMenuController._();
  static AppMenuController? _this;
  AppMenuController._();
}
