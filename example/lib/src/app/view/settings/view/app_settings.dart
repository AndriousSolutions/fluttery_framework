// ignore_for_file: unnecessary_lambdas, avoid_positional_boolean_parameters, invalid_use_of_protected_member
import 'package:fluttery_framework/view.dart' as v;

//
import '/src/controller.dart';

//
import '/src/view.dart';

/// The App Settings
class AppSettingsDrawer extends v.AppDrawer {
  ///
  AppSettingsDrawer({super.key}) {
    if (App.useMaterial) {
      add(const AppSettings.column(key: Key('AppSettings')));
    } else {
      add(const AppSettings.disabled(key: Key('AppSettings')));
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
class _AppSettingsState extends State<AppSettings> {
  _AppSettingsState() {
    con = AppSettingsController();
  }

  late AppSettingsController con;

  @override
  void initState() {
    super.initState();
    con.goOnHome();
  }

  @override
  Widget build(BuildContext context) {
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

    // Disable if running in Cupertino
    const disable = kIsWeb;

    final tip = disable ? 'Not Web enabled'.tr : '';
    //
    final List<Widget> widgets = <Widget>[
      listTile(
        key: const Key('delay'),
        leading: isSmall ? null : const Icon(Icons.dark_mode),
        title: isSmall ? Text('Delay'.tr) : Text('Delay Startup'.tr),
        onTap: () => disable ? null : onTapInitAsyncDelay(state: this),
        tip: disable ? tip : tipDelay,
        value: con.initAsyncDelay,
        onChanged: (v) =>
            disable ? null : onTapInitAsyncDelay(use: v, state: this),
      ),
      listTile(
        key: const Key('home'),
        leading: isSmall ? null : const Icon(Icons.home),
        title: isSmall
            ? Text('home parameter'.tr)
            : Text('Use the home parameter'.tr),
        onTap: () => disable ? null : onTapUseHome(state: this),
        tip: disable ? tip : tipHome,
        value: con.useHome,
        onChanged: (v) => disable ? null : onTapUseHome(use: v, state: this),
      ),
      listTile(
        key: const Key('onHome'),
        leading: isSmall ? null : const Icon(Icons.home_outlined),
        title: isSmall ? Text("'onHome'".tr) : Text("Use 'onHome' function".tr),
        onTap: () => disable ? null : onTapUseOnHome(state: this),
        tip: disable ? tip : tipOnHome,
        value: con.useOnHome,
        onChanged: (v) => disable ? null : onTapUseOnHome(use: v, state: this),
      ),
      listTile(
        key: const Key('routes'),
        leading: isSmall ? null : const Icon(Icons.remove_road_sharp),
        title: isSmall ? Text('Routes'.tr) : Text('Use Routes instead'.tr),
        onTap: () => disable ? null : onTapUseRoutes(state: this),
        tip: disable ? tip : tipRoutes,
        value: con.useRoutes,
        onChanged: (v) => disable ? null : onTapUseRoutes(use: v, state: this),
      ),
      listTile(
        key: const Key('router'),
        leading: isSmall ? null : const Icon(Icons.add_road),
        title: isSmall ? Text('Router'.tr) : Text('Use Router Config.'.tr),
        onTap: () => disable ? null : onTapUseRouterConfig(state: this),
        tip: disable ? tip : tipRouterConfig,
        value: con.useRouterConfig,
        onChanged: (v) =>
            disable ? null : onTapUseRouterConfig(use: v, state: this),
      ),
      listTile(
        key: const Key('inheritedWidget'),
        leading: isSmall ? null : const Icon(Icons.live_help_rounded),
        title: isSmall
            ? Text('InheritedWidget'.tr)
            : Text('Use InheritedWidget'.tr),
        onTap: () => onTapInherited(state: this),
        tip: tipInherited,
        value: con.useInheritedWidget,
        onChanged: (v) => onTapInherited(use: v, state: this),
      ),
      listTile(
        key: const Key('button error'),
        leading: isSmall ? null : const Icon(Icons.radio_button_on_sharp),
        title: isSmall ? Text('Button Error'.tr) : Text('Error Push button'.tr),
        onTap: () {
          con.buttonError = !con.buttonError;
          if (con.buttonError) {
            tipButtonError = 'Push button will error.'.tr;
            _showSnackBar(tipButtonError);
          } else {
            tipButtonError = '';
          }
          setState(() {});
        },
        tip: tipButtonError,
        value: con.buttonError,
        onChanged: (bool value) {
          con.buttonError = value;
          if (value) {
            tipButtonError = 'Push button will error.'.tr;
            _showSnackBar(tipButtonError);
          } else {
            tipButtonError = '';
          }
          setState(() {});
        },
      ),
      listTile(
        key: const Key('initAsync error'),
        leading: isSmall ? null : const Icon(Icons.insert_invitation_sharp),
        title: isSmall
            ? Text('initAsync Error'.tr)
            : Text('Error in initAsync'.tr),
        onTap: () {
          con.initAsyncError = !con.initAsyncError;
          if (con.initAsyncError) {
            tipAsyncError = 'Page 1 will error.'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipAsyncError);
          } else {
            tipAsyncError = '';
          }
          setState(() {});
        },
        value: con.initAsyncError,
        onChanged: (bool value) {
          con.initAsyncError = value;
          if (value) {
            tipAsyncError = 'Page 1 will error.'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipAsyncError);
          } else {
            tipAsyncError = '';
          }
          setState(() {});
        },
      ),
      listTile(
        key: const Key('App initAsync error'),
        leading: isSmall ? null : const Icon(Icons.insert_invitation_sharp),
        title: isSmall
            ? Text('App initAsync Error'.tr)
            : Text('Error in initAsync'.tr),
        onTap: () {
          con.initAppAsyncError = !con.initAppAsyncError;
          if (con.initAppAsyncError) {
            tipAppAsyncError = 'Must restart app'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipAppAsyncError);
          } else {
            tipAppAsyncError = '';
          }
          // App.appState?.hotReload();
          setState(() {});
        },
        value: con.initAppAsyncError,
        onChanged: (bool value) {
          con.initAppAsyncError = value;
          if (value) {
            tipAppAsyncError = 'Must restart app'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipAppAsyncError);
          } else {
            tipAppAsyncError = '';
          }
          // App.appState?.hotReload();
          setState(() {});
        },
      ),
      listTile(
        key: const Key('builder error'),
        leading: isSmall ? null : const Icon(Icons.build),
        title: isSmall ? Text('Builder Error'.tr) : Text('Error in Builder'.tr),
        onTap: () {
          con.errorInBuild = !con.errorInBuild;
          if (con.errorInBuild) {
            tipBuilderError = 'Page 2 will error.'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipBuilderError);
          } else {
            tipBuilderError = '';
          }
          setState(() {});
          // con.setSettingState(); // Don't invoke the error yet
        },
        tip: tipBuilderError,
        value: con.errorInBuild,
        onChanged: (bool value) {
          con.errorInBuild = value;
          if (value) {
            tipBuilderError = 'Page 2 will error'.tr;
            // Show snack bar when appropriate
            _showSnackBar(tipBuilderError);
          } else {
            tipBuilderError = '';
          }
          setState(() {});
          // con.setSettingState(); // Don't invoke the error yet
        },
      ),
    ];
    return widgets;
  }

  ///
  void onTapInitAsyncDelay({bool? use, State? state}) {
    use ??= !con.initAsyncDelay;
    con.initAsyncDelay = use;
    state?.setState(() {});
    if (!use) {
      tipDelay = '';
    } else if (use) {
      tipDelay = 'Must restart app'.tr;
    } else {
      tipDelay = '';
    }
    // Show snack bar when appropriate
    _showSnackBar(tipDelay);
  }

  ///
  void onTapUseHome({bool? use, State? state}) {
    use ??= !con.useHome;
    con.useHome = use;
    toggleSwitches(value: use, tip: 'Home only'.tr);
    state?.setState(() {});
    if (use) {
      tipHome = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipHome = 'At least one must be on'.tr;
      }
    }
    // Show snack bar when appropriate
    _showSnackBar(tipHome);
  }

  ///
  void onTapUseOnHome({bool? use, State? state}) {
    use ??= !con.useOnHome;
    con.useOnHome = use;
    toggleSwitches(value: use, tip: 'onHome() function only'.tr);
    state?.setState(() {});
    if (use) {
      tipOnHome = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipOnHome = 'At least one must be on'.tr;
      }
    }
    // Show snack bar when appropriate
    _showSnackBar(tipOnHome);
  }

  ///
  void onTapUseRoutes({bool? use, State? state}) {
    use ??= !con.useRoutes;
    con.useRoutes = use;
    toggleSwitches(value: use, tip: 'Routes only'.tr);
    state?.setState(() {});
    if (use) {
      tipRoutes = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipRoutes = 'At least one must be on'.tr;
      }
    }
    // Show snack bar when appropriate
    _showSnackBar(tipRoutes);
  }

  ///
  void onTapUseRouterConfig({bool? use, State? state}) {
    use ??= !con.useRouterConfig;
    con.useRouterConfig = use;
    toggleSwitches(value: use, tip: 'Router Config. only'.tr);
    state?.setState(() {});
    if (use) {
      tipRouterConfig = 'Must restart app'.tr;
    } else {
      if (con.hasNoHome()) {
        tipRouterConfig = 'At least one must be on'.tr;
      }
    }
    // Show snack bar when appropriate
    _showSnackBar(tipRouterConfig);
  }

  ///
  void onTapInherited({bool? use, State? state}) {
    use ??= !con.useInheritedWidget;
    state?.setState(() {});
    if (use) {
      con.useInheritedWidget = con.useOnHome =
          toggleSwitches(value: use, tip: 'onHome() function only'.tr);
      tipOnHome = 'onHome() function only'.tr;
      App.appState?.setState(() {});
    } else {
      con.useInheritedWidget = use;
      if (con.hasNoHome()) {
        tipInherited = 'At least one must be on'.tr;
      }
    }
    // Show snack bar when appropriate
    _showSnackBar(tipInherited);
  }

  /// Toggle the appropriate switches
  bool toggleSwitches({required bool value, required String tip}) {
    //
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
      // } else {
//goOnHome();
    }
    return value;
  }

  // Ensure at least the home parameter is used
  void goOnHome() {
    tipRouterConfig = tipRoutes = tipHome = tipOnHome = '';
    if (con.goOnHome()) {
      tipOnHome = 'At least one must be on'.tr;
      // Show snack bar when appropriate
      _showSnackBar(tipOnHome);
    }
  }

  // There's no 'home' option selected.
  bool hasNoHome() => con.hasNoHome();

  /// Messages displayed to the user while changing settings
  var tipDelay = '';
  var tipRoutes = '';
  var tipHome = '';
  var tipOnHome = '';
  var tipRouterConfig = '';
  var tipInherited = '';
  var tipButtonError = '';
  var tipBuilderError = '';
  var tipAsyncError = '';
  var tipAppAsyncError = '';

  /// Show a snack bar when appropriate
  void _showSnackBar([String? tip]) {
    if (UniversalPlatform.isMobile) {
      final content = tip ?? '';
      if (content.isNotEmpty) {
        // Displays a snack bar.
        App.snackBar(message: content);
      }
    }
  }
}
