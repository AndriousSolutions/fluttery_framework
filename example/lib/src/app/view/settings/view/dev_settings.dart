//
import 'package:fluttery_framework/view.dart' as v;

import '/src/controller.dart';

import '/src/view.dart';

///
class DevSettingsDrawer extends v.AppDrawer {
  ///
  DevSettingsDrawer({super.key}) {
    /// Don't offer these development tools if testing the app
    if (!App.inFlutterTest) {
      if (App.useMaterial) {
        add(const DevToolsSettings.column());
      } else {
        add(const DevToolsSettings.disabled());
      }
    }
  }
}

///
class DevToolsSettings extends StatefulWidget {
  /// Provide the Dev Tool options in a ListView
  const DevToolsSettings({super.key, this.shrinkWrap})
      : column = false,
        useAssert = true;

  /// Wrap the options in a Column
  const DevToolsSettings.column({super.key, this.shrinkWrap})
      : column = true,
        useAssert = true;

  /// Only disable those options not available
  const DevToolsSettings.disabled({super.key, this.shrinkWrap})
      : column = true,
        useAssert = false;

  ///
  final bool? shrinkWrap;

  /// Wrap the options in a Column
  final bool column;

  /// Use assert to remove options only available during development.
  final bool useAssert;

  @override
  State createState() => _DevToolsSettingsState();
}

///
class _DevToolsSettingsState extends StateX<DevToolsSettings> {
  _DevToolsSettingsState() : super(controller: DevToolsController()) {
    con = controller as DevToolsController;
  }

  late DevToolsController con;

  @override
  Widget builder(BuildContext context) {
    Widget wid;
    if (widget.column) {
      wid = Column(
        children: devSettings,
      );
    } else {
      wid = ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: widget.shrinkWrap ?? false,
        children: devSettings,
      );
    }
    return wid;
  }

  ///
  List<Widget> get devSettings {
    //
    // Disable if running in Cupertino
    final disable = App.useCupertino;

    final tip = disable ? 'Enabled in Material Design'.tr : '';

    final List<Widget> widgets = <Widget>[
      listTile(
        leading: const Icon(Icons.picture_in_picture),
        title: Text('Show rendering performance overlay'.tr),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay;
        },
        value: con.showPerformanceOverlay,
        onChanged: (bool value) {
          con.showPerformanceOverlay = value;
        },
      ),
      listTile(
        leading: const Icon(Icons.accessibility),
        title: Text('Show accessibility information'.tr),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger;
        },
        value: con.showSemanticsDebugger,
        onChanged: (bool value) {
          con.showSemanticsDebugger = value;
        },
      ),
      listTile(
        leading: const Icon(Icons.bug_report),
        title: Text('Show DEBUG banner'.tr),
        onTap: () {
          con.debugShowCheckedModeBanner = !con.debugShowCheckedModeBanner;
        },
        value: con.debugShowCheckedModeBanner,
        onChanged: (bool value) {
          con.debugShowCheckedModeBanner = value;
        },
      ),
      if (App.useMaterial)
        listTile(
          leading: const Icon(Icons.screen_lock_landscape_sharp),
          title: Text('Use Material 3 Design'.tr),
          onTap: () {
            con.useMaterial3 = !con.useMaterial3;
          },
          value: con.useMaterial3,
          onChanged: (bool value) {
            con.useMaterial3 = value;
          },
        ),
      listTile(
        leading: const Icon(Icons.border_clear),
        title: Text('Show material grid'.tr),
        onTap: disable
            ? null
            : () {
                con.debugShowMaterialGrid = !con.debugShowMaterialGrid;
              },
        tip: tip,
        value: con.debugShowMaterialGrid,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugShowMaterialGrid = value;
              },
      ),
    ];

    // An approach to determine if running in your IDE or not is the assert()
    // i.e. When your in your Debugger or not.
    if (widget.useAssert) {
      // The compiler removes assert functions and their content when in Production.
      assert(() {
        devToolsOptions(widgets);
        return true;
      }());
    } else {
      devToolsOptions(widgets);
    }
    return widgets;
  }

  /// Supply those Dev tools available only during Development
  void devToolsOptions(List<Widget> widgets) {
    // Disable if running in Production
    const disable = kReleaseMode;

    final tip = disable ? 'Only in Development'.tr : '';

    // material grid and size construction lines are only available in checked mode
    widgets.addAll(<Widget>[
      listTile(
        leading: const Icon(Icons.border_all),
        title: Text('Paint construction lines'.tr),
        onTap: disable
            ? null
            : () => con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled,
        tip: tip,
        value: con.debugPaintSizeEnabled,
        onChanged:
            disable ? null : (bool value) => con.debugPaintSizeEnabled = value,
      ),
      listTile(
        leading: const Icon(Icons.format_color_text),
        title: Text('Show character baselines'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintBaselinesEnabled =
                    !con.debugPaintBaselinesEnabled;
              },
        tip: tip,
        value: con.debugPaintBaselinesEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintBaselinesEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.mouse),
        title: Text('Flash interface taps'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled;
              },
        tip: tip,
        value: con.debugPaintPointersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintPointersEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.filter_none),
        title: Text('Highlight layer boundaries'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintLayerBordersEnabled =
                    !con.debugPaintLayerBordersEnabled;
              },
        tip: tip,
        value: con.debugPaintLayerBordersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintLayerBordersEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.gradient),
        title: Text('Highlight repainted layers'.tr),
        onTap: disable
            ? null
            : () {
                con.debugRepaintRainbowEnabled =
                    !con.debugRepaintRainbowEnabled;
              },
        tip: tip,
        value: con.debugRepaintRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintRainbowEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.vignette),
        title: Text('Rotating colors repainting text'.tr),
        onTap: disable
            ? null
            : () {
                con.debugRepaintTextRainbowEnabled =
                    !con.debugRepaintTextRainbowEnabled;
              },
        tip: tip,
        value: con.debugRepaintTextRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintTextRainbowEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.dirty_lens),
        title: Text('Log dirty widgets rebuilt'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintRebuildDirtyWidgets =
                    !con.debugPrintRebuildDirtyWidgets;
              },
        tip: tip,
        value: con.debugPrintRebuildDirtyWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintRebuildDirtyWidgets = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.dirty_lens_rounded),
        title: Text('Callback called for every dirty widget rebuilt'.tr),
        onTap: disable
            ? null
            : () {
                con.debugOnRebuildDirtyWidget = !con.debugOnRebuildDirtyWidget;
              },
        tip: tip,
        value: con.debugOnRebuildDirtyWidget,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugOnRebuildDirtyWidget = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.arrow_circle_right_outlined),
        title: Text('Log to BuildOwner.buildScope'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintBuildScope = !con.debugPrintBuildScope;
              },
        tip: tip,
        value: con.debugPrintBuildScope,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintBuildScope = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.update),
        title: Text('Log call stacks marking widgets to rebuilt'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintScheduleBuildForStacks =
                    !con.debugPrintScheduleBuildForStacks;
              },
        tip: tip,
        value: con.debugPrintScheduleBuildForStacks,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintScheduleBuildForStacks = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.language),
        title: Text(
            'Log widgets with global keys when deactivated and reactivated'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintGlobalKeyedWidgetLifecycle =
                    !con.debugPrintGlobalKeyedWidgetLifecycle;
              },
        tip: tip,
        value: con.debugPrintGlobalKeyedWidgetLifecycle,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintGlobalKeyedWidgetLifecycle = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.location_history_outlined),
        title: Text("Adds 'Timeline' events for every Widget built".tr),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabled = !con.debugProfileBuildsEnabled;
              },
        tip: tip,
        value: con.debugProfileBuildsEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabled = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.foundation),
        title: Text("Adds 'Timeline' for every user-created [Widget] built".tr),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabledUserWidgets =
                    !con.debugProfileBuildsEnabledUserWidgets;
              },
        tip: tip,
        value: con.debugProfileBuildsEnabledUserWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabledUserWidgets = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.view_timeline),
        title: Text(
            "Adds debugging info. to 'Timeline' related to Widget builds".tr),
        onTap: disable
            ? null
            : () {
                con.debugEnhanceBuildTimelineArguments =
                    !con.debugEnhanceBuildTimelineArguments;
              },
        tip: tip,
        value: con.debugEnhanceBuildTimelineArguments,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugEnhanceBuildTimelineArguments = value;
              },
      ),
      listTile(
        leading: const Icon(Icons.wrong_location),
        title: Text('Show banners for deprecated widgets'.tr),
        onTap: disable
            ? null
            : () {
                con.debugHighlightDeprecatedWidgets =
                    !con.debugHighlightDeprecatedWidgets;
              },
        tip: tip,
        value: con.debugHighlightDeprecatedWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugHighlightDeprecatedWidgets = value;
              },
      ),
    ]);
  }
}

///
class DevToolsController extends StateXController {
  /// Singleton Pattern
  factory DevToolsController() => _this ??= DevToolsController._();
  DevToolsController._();
  static DevToolsController? _this;

  @override
  void initState() {
    super.initState();
    _useMaterial3 = App.themeData?.useMaterial3 ?? false;
  }

  ///
  bool get debugShowCheckedModeBanner => _debugShowCheckedModeBanner;
  set debugShowCheckedModeBanner(bool? v) {
    if (v != null) {
      _debugShowCheckedModeBanner = v;
      setSettingState();
    }
  }

  //
  bool _debugShowCheckedModeBanner = true;

  ///
  bool get debugShowMaterialGrid => _debugShowMaterialGrid;
  set debugShowMaterialGrid(bool? v) {
    if (v != null) {
      _debugShowMaterialGrid = v;
      setSettingState();
    }
  }

  //
  bool _debugShowMaterialGrid = false;

  ///
  bool get debugPaintSizeEnabled => _debugPaintSizeEnabled;
  set debugPaintSizeEnabled(bool? v) {
    if (v != null) {
      _debugPaintSizeEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugPaintSizeEnabled = false;

  ///
  bool get debugPaintBaselinesEnabled => _debugPaintBaselinesEnabled;
  set debugPaintBaselinesEnabled(bool? v) {
    if (v != null) {
      _debugPaintBaselinesEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugPaintBaselinesEnabled = false;

  ///
  bool get debugPaintLayerBordersEnabled => _debugPaintLayerBordersEnabled;
  set debugPaintLayerBordersEnabled(bool? v) {
    if (v != null) {
      _debugPaintLayerBordersEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugPaintLayerBordersEnabled = false;

  ///
  bool get debugPaintPointersEnabled => _debugPaintPointersEnabled;
  set debugPaintPointersEnabled(bool? v) {
    if (v != null) {
      _debugPaintPointersEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugPaintPointersEnabled = false;

  ///
  bool get debugRepaintRainbowEnabled => _debugRepaintRainbowEnabled;
  set debugRepaintRainbowEnabled(bool? v) {
    if (v != null) {
      _debugRepaintRainbowEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugRepaintRainbowEnabled = false;

  ///
  bool get debugRepaintTextRainbowEnabled => _debugRepaintTextRainbowEnabled;
  set debugRepaintTextRainbowEnabled(bool? v) {
    if (v != null) {
      _debugRepaintTextRainbowEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugRepaintTextRainbowEnabled = false;

  ///
  bool get debugPrintRebuildDirtyWidgets => _debugPrintRebuildDirtyWidgets;
  set debugPrintRebuildDirtyWidgets(bool? v) {
    if (v != null) {
      _debugPrintRebuildDirtyWidgets = v;
      setSettingState();
    }
  }

  //
  bool _debugPrintRebuildDirtyWidgets = false;

  ///
  bool get debugOnRebuildDirtyWidget => _debugOnRebuildDirtyWidget;
  set debugOnRebuildDirtyWidget(bool? v) {
    if (v != null) {
      _debugOnRebuildDirtyWidget = v;
      setSettingState();
    }
  }

  //
  bool _debugOnRebuildDirtyWidget = false;

  ///
  // ignore: avoid_positional_boolean_parameters
  void onDebugOnRebuildDirtyWidget(Element e, bool builtOnce) {
    debugPrint('element: ${e.toStringShort()}  builtOnce: $builtOnce');
  }

  ///
  bool get debugPrintBuildScope => _debugPrintBuildScope;
  set debugPrintBuildScope(bool? v) {
    if (v != null) {
      _debugPrintBuildScope = v;
      setSettingState();
    }
  }

  //
  bool _debugPrintBuildScope = false;

  ///
  bool get debugPrintGlobalKeyedWidgetLifecycle =>
      _debugPrintGlobalKeyedWidgetLifecycle;
  set debugPrintGlobalKeyedWidgetLifecycle(bool? v) {
    if (v != null) {
      _debugPrintGlobalKeyedWidgetLifecycle = v;
      setSettingState();
    }
  }

  //
  bool _debugPrintGlobalKeyedWidgetLifecycle = false;

  ///
  bool get debugPrintScheduleBuildForStacks =>
      _debugPrintScheduleBuildForStacks;
  set debugPrintScheduleBuildForStacks(bool? v) {
    if (v != null) {
      _debugPrintScheduleBuildForStacks = v;
      setSettingState();
    }
  }

  //
  bool _debugPrintScheduleBuildForStacks = false;

  ///
  bool get debugProfileBuildsEnabled => _debugProfileBuildsEnabled;
  set debugProfileBuildsEnabled(bool? v) {
    if (v != null) {
      _debugProfileBuildsEnabled = v;
      setSettingState();
    }
  }

  //
  bool _debugProfileBuildsEnabled = false;

  ///
  bool get debugProfileBuildsEnabledUserWidgets =>
      _debugProfileBuildsEnabledUserWidgets;
  set debugProfileBuildsEnabledUserWidgets(bool? v) {
    if (v != null) {
      _debugProfileBuildsEnabledUserWidgets = v;
      setSettingState();
    }
  }

  //
  bool _debugProfileBuildsEnabledUserWidgets = false;

  ///
  bool get debugEnhanceBuildTimelineArguments =>
      _debugEnhanceBuildTimelineArguments;
  set debugEnhanceBuildTimelineArguments(bool? v) {
    if (v != null) {
      _debugEnhanceBuildTimelineArguments = v;
      setSettingState();
    }
  }

  //
  bool _debugEnhanceBuildTimelineArguments = false;

  ///
  bool get debugHighlightDeprecatedWidgets => _debugHighlightDeprecatedWidgets;
  set debugHighlightDeprecatedWidgets(bool? v) {
    if (v != null) {
      _debugHighlightDeprecatedWidgets = v;
      setSettingState();
    }
  }

  //
  bool _debugHighlightDeprecatedWidgets = false;

  ///
  bool get showPerformanceOverlay => _showPerformanceOverlay;
  set showPerformanceOverlay(bool? v) {
    if (v != null) {
      _showPerformanceOverlay = v;
      setSettingState();
    }
  }

  //
  bool _showPerformanceOverlay = false;

  ///
  bool get showSemanticsDebugger => _showSemanticsDebugger;
  set showSemanticsDebugger(bool? v) {
    if (v != null) {
      _showSemanticsDebugger = v;
      setSettingState();
    }
  }

  //
  bool _showSemanticsDebugger = false;

  ///
  bool get useMaterial3 => _useMaterial3;
  set useMaterial3(bool? v) {
    if (v != null) {
      _useMaterial3 = v;
      final themeData = App.themeData;
      if (themeData != null) {
        final colorScheme = themeData.colorScheme;
        App.themeData =
            ThemeData.from(colorScheme: colorScheme, useMaterial3: v);
        setSettingState();
      }
    }
  }

  //
  bool _useMaterial3 = true;

  /// Call the setState() functions
  void setSettingState() {
    setState(() {});
    appState?.setState(() {});
  }
}
