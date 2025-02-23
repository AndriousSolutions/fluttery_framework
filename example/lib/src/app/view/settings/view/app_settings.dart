// ignore_for_file: unnecessary_lambdas, avoid_positional_boolean_parameters
import 'package:fluttery_framework/view.dart' as v;

//
import '../controller/app_settings_controller.dart';

//
import '/src/view.dart';

/// The App Settings
class AppSettingsDrawer extends v.AppDrawer {
  ///
  AppSettingsDrawer({super.key}) {
    /// Don't offer these development tools if testing the app
    if (!App.inFlutterTest) {
      if (App.useMaterial) {
        add(const AppSettings.column());
      } else {
        add(const AppSettings.disabled());
      }
    }
  }
}

///
class AppSettings extends StatefulWidget {
  /// Provide the Dev Tool options in a ListView
  const AppSettings({super.key, this.shrinkWrap})
      : column = false,
        useAssert = true;

  /// Wrap the options in a Column
  const AppSettings.column({super.key, this.shrinkWrap})
      : column = true,
        useAssert = true;

  /// Only disable those options not available
  const AppSettings.disabled({super.key, this.shrinkWrap})
      : column = true,
        useAssert = false;

  ///
  final bool? shrinkWrap;

  /// Wrap the options in a Column
  final bool column;

  /// Use assert to remove options only available during development.
  final bool useAssert;

  @override
  State createState() => _AppSettingsState();
}

///
class _AppSettingsState extends StateX<AppSettings> {
  _AppSettingsState() : super(controller: AppSettingsController()) {
    con = controller as AppSettingsController;
  }

  late AppSettingsController con;

  @override
  Widget builder(BuildContext context) {
    Widget wid;
    if (widget.column) {
      wid = Column(
        children: appSettings,
      );
    } else {
      wid = ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: widget.shrinkWrap ?? false,
        children: appSettings,
      );
    }
    return wid;
  }

  ///
  List<Widget> get appSettings {
    //
    final isSmall = context.isPhone && !kIsWeb;
    //
    final List<Widget> widgets = <Widget>[
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Delay'.tr) : Text('Delay Startup'.tr),
        onTap: () => onTapInitAsyncDelay(),
        tip: tipDelay,
        value: con.initAsyncDelay,
        onChanged: onTapInitAsyncDelay,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Splash'.tr) : Text('Show Splash Screen'.tr),
        onTap: () => onTapSplashScreen(),
        tip: tipSplash,
        value: con.splashScreen,
        onChanged: onTapSplashScreen,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall
            ? Text('home parameter'.tr)
            : Text('Use the home parameter'.tr),
        onTap: () => onTapUseHome(),
        tip: tipHome,
        value: con.useHome,
        onChanged: onTapUseHome,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text("'onHome'".tr) : Text("Use 'onHome' function".tr),
        onTap: () => onTapUseOnHome(),
        tip: tipOnHome,
        value: con.useOnHome,
        onChanged: onTapUseOnHome,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Routes'.tr) : Text('Use Routes instead'.tr),
        onTap: () => onTapUseRoutes(),
        tip: tipRoutes,
        value: con.useRoutes,
        onChanged: onTapUseRoutes,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Router'.tr) : Text('Use Router Config.'.tr),
        onTap: () => onTapUseRouterConfig(),
        tip: tipRouterConfig,
        value: con.useRouterConfig,
        onChanged: onTapUseRouterConfig,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall
            ? Text('InheritedWidget'.tr)
            : Text('Use InheritedWidget'.tr),
        onTap: () => onTapInherited(),
        tip: tipInherited,
        value: con.useInheritedWidget,
        onChanged: onTapInherited,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Button Error'.tr) : Text('Error Push button'.tr),
        onTap: () {
          con.buttonError = !con.buttonError;
          con.setState(() {});
        },
        value: con.buttonError,
        onChanged: (bool value) {
          con.buttonError = value;
          con.setState(() {});
        },
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall ? Text('Builder Error'.tr) : Text('Error in Builder'.tr),
        onTap: () {
          con.errorInBuilder = !con.errorInBuilder;
          con.setSettingState();
        },
        value: con.errorInBuilder,
        onChanged: (bool value) {
          con.errorInBuilder = value;
          con.setSettingState();
        },
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall
            ? Text('initAsync Error'.tr)
            : Text('Error in initAsync'.tr),
        onTap: () {
          con.initAsyncError = !con.initAsyncError;
          con.setSettingState();
        },
        value: con.initAsyncError,
        onChanged: (bool value) {
          con.initAsyncError = value;
          con.setSettingState();
        },
      ),
    ];
    return widgets;
  }

  ///
  void onTapInitAsyncDelay([bool? value]) {
    value ??= !con.initAsyncDelay;
    con.initAsyncDelay = value;
    con.setState(() {});
    if (!value && con.splashScreen) {
      con.splashScreen = false;
      tipSplash = 'Splash off as well'.tr;
      tipDelay = '';
    } else if (value) {
      tipDelay = 'Must restart app'.tr;
      tipSplash = '';
    } else {
      tipDelay = '';
    }
  }

  ///
  void onTapSplashScreen([bool? value]) {
    value ??= !con.splashScreen;
    con.splashScreen = value;
    con.setState(() {});
    if (value && !con.initAsyncDelay) {
      con.initAsyncDelay = true;
      tipDelay = 'To Display Splash Screen'.tr;
      tipSplash = '';
    } else if (value) {
      tipSplash = 'Must restart app'.tr;
      tipDelay = '';
    } else {
      tipSplash = '';
    }
  }

  ///
  void onTapUseHome([bool? value]) {
    value ??= !con.useHome;
    con.useHome = toggleSwitches(value: value, tip: 'Home only'.tr);
    if (value) {
      tipHome = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipHome = 'At least one must be on'.tr;
      }
    }
  }

  ///
  void onTapUseOnHome([bool? value]) {
    value ??= !con.useOnHome;
    con.useOnHome =
        toggleSwitches(value: value, tip: 'onHome() function only'.tr);
    if (value) {
      tipOnHome = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipOnHome = 'At least one must be on'.tr;
      }
    }
  }

  ///
  void onTapUseRoutes([bool? value]) {
    value ??= !con.useRoutes;
    con.useRoutes = toggleSwitches(value: value, tip: 'Routes only'.tr);
    if (value) {
      tipRoutes = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipRoutes = 'At least one must be on'.tr;
      }
    }
  }

  ///
  void onTapUseRouterConfig([bool? value]) {
    value ??= !con.useRouterConfig;
    con.useRouterConfig =
        toggleSwitches(value: value, tip: 'Router Config. only'.tr);
    if (value) {
      tipRouterConfig = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipRouterConfig = 'At least one must be on'.tr;
      }
    }
  }

  ///
  void onTapInherited([bool? value]) {
    value ??= !con.useInheritedWidget;
    if (value) {
      con.useInheritedWidget = con.useOnHome =
          toggleSwitches(value: value, tip: 'onHome() function only'.tr);
      tipOnHome = 'onHome() function only'.tr;
      con.setState(() {});
      appState?.setState(() {});
    } else {
      if (con.hasNoHome()) {
        tipInherited = 'At least one must be on'.tr;
      }
    }
  }

  /// Toggle the appropriate switches
  bool toggleSwitches({required bool value, required String tip}) {
    con.setState(() {});
    if (value) {
      tip = tip.trim();
      if (con.useInheritedWidget) {
        con.useInheritedWidget = false;
        tipInherited = tip;
      } else {
        tipInherited = '';
      }
      if (con.useRoutes) {
        con.useRoutes = false;
        tipRoutes = tip;
      } else {
        tipRoutes = '';
      }
      if (con.useRouterConfig) {
        con.useRouterConfig = false;
        tipRouterConfig = tip;
      } else {
        tipRouterConfig = '';
      }
      if (con.useHome) {
        con.useHome = false;
        tipHome = tip;
      } else {
        tipHome = '';
      }
      if (con.useOnHome) {
        con.useOnHome = false;
        tipOnHome = tip;
      } else {
        tipOnHome = '';
      }
    } else {
      goOnHome();
    }
    return value;
  }

  // Ensure at least the home parameter is used
  void goOnHome() {
    tipRouterConfig = tipRoutes = tipHome = tipOnHome = '';
    if (con.goOnHome()) {
      tipOnHome = 'At least one must be on'.tr;
    }
  }

  /// Messages displayed to the user while changing settings
  var tipDelay = '';
  var tipSplash = '';
  var tipRoutes = '';
  var tipHome = '';
  var tipOnHome = '';
  var tipRouterConfig = '';
  var tipInherited = '';
}
