//
import '/src/controller.dart';

import '/src/view.dart';

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
    final List<Widget> widgets = <Widget>[
      ListTile(
        leading: const Icon(Icons.picture_in_picture),
        title: const Text('Show rendering performance overlay'),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay;
        },
        trailing: Switch(
          value: con.showPerformanceOverlay,
          onChanged: (bool value) {
            con.showPerformanceOverlay = value;
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.accessibility),
        title: const Text('Show accessibility information'),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger;
        },
        trailing: Switch(
          value: con.showSemanticsDebugger,
          onChanged: (bool value) {
            con.showSemanticsDebugger = value;
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.bug_report),
        title: const Text('Show DEBUG banner'),
        onTap: () {
          con.debugShowCheckedModeBanner = !con.debugShowCheckedModeBanner;
        },
        trailing: Switch(
          value: con.debugShowCheckedModeBanner,
          onChanged: (bool value) {
            con.debugShowCheckedModeBanner = value;
          },
        ),
      ),
      if (App.useMaterial)
        ListTile(
          leading: const Icon(Icons.screen_lock_landscape_sharp),
          title: const Text('Use Material 3 Design'),
          onTap: () {
            con.useMaterial3 = !con.useMaterial3;
          },
          trailing: Switch(
            value: con.useMaterial3,
            onChanged: (bool value) {
              con.useMaterial3 = value;
            },
          ),
        ),
      ListTile(
        leading: const Icon(Icons.border_clear),
        title: const Text('Show material grid'),
        onTap: () {
          con.debugShowMaterialGrid = !con.debugShowMaterialGrid;
        },
        trailing: Switch(
          value: con.debugShowMaterialGrid,
          onChanged: (bool value) {
            con.debugShowMaterialGrid = value;
          },
        ),
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
      _listTile(
        leading: const Icon(Icons.border_all),
        title: const Text('Paint construction lines'),
        onTap: disable
            ? null
            : () => con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled,
        message: tip,
        value: con.debugPaintSizeEnabled,
        onChanged:
            disable ? null : (bool value) => con.debugPaintSizeEnabled = value,
      ),
      _listTile(
        leading: const Icon(Icons.format_color_text),
        title: const Text('Show character baselines'),
        onTap: disable
            ? null
            : () {
                con.debugPaintBaselinesEnabled =
                    !con.debugPaintBaselinesEnabled;
              },
        message: tip,
        value: con.debugPaintBaselinesEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintBaselinesEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.mouse),
        title: const Text('Flash interface taps'),
        onTap: disable
            ? null
            : () {
                con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled;
              },
        message: tip,
        value: con.debugPaintPointersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintPointersEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.filter_none),
        title: const Text('Highlight layer boundaries'),
        onTap: disable
            ? null
            : () {
                con.debugPaintLayerBordersEnabled =
                    !con.debugPaintLayerBordersEnabled;
              },
        message: tip,
        value: con.debugPaintLayerBordersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintLayerBordersEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.gradient),
        title: const Text('Highlight repainted layers'),
        onTap: disable
            ? null
            : () {
                con.debugRepaintRainbowEnabled =
                    !con.debugRepaintRainbowEnabled;
              },
        message: tip,
        value: con.debugRepaintRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintRainbowEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.vignette),
        title: const Text('Rotating colors repainting text'),
        onTap: disable
            ? null
            : () {
                con.debugRepaintTextRainbowEnabled =
                    !con.debugRepaintTextRainbowEnabled;
              },
        message: tip,
        value: con.debugRepaintTextRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintTextRainbowEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.dirty_lens),
        title: const Text('Log dirty widgets rebuilt'),
        onTap: disable
            ? null
            : () {
                con.debugPrintRebuildDirtyWidgets =
                    !con.debugPrintRebuildDirtyWidgets;
              },
        message: tip,
        value: con.debugPrintRebuildDirtyWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintRebuildDirtyWidgets = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.dirty_lens_rounded),
        title: const Text('Callback called for every dirty widget rebuilt'),
        onTap: disable
            ? null
            : () {
                con.debugOnRebuildDirtyWidget = !con.debugOnRebuildDirtyWidget;
              },
        message: tip,
        value: con.debugOnRebuildDirtyWidget,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugOnRebuildDirtyWidget = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.arrow_circle_right_outlined),
        title: const Text('Log to BuildOwner.buildScope'),
        onTap: disable
            ? null
            : () {
                con.debugPrintBuildScope = !con.debugPrintBuildScope;
              },
        message: tip,
        value: con.debugPrintBuildScope,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintBuildScope = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.update),
        title: const Text('Log call stacks marking widgets to rebuilt'),
        onTap: disable
            ? null
            : () {
                con.debugPrintScheduleBuildForStacks =
                    !con.debugPrintScheduleBuildForStacks;
              },
        message: tip,
        value: con.debugPrintScheduleBuildForStacks,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintScheduleBuildForStacks = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.language),
        title: const Text(
            'Log widgets with global keys when deactivated and reactivated'),
        onTap: disable
            ? null
            : () {
                con.debugPrintGlobalKeyedWidgetLifecycle =
                    !con.debugPrintGlobalKeyedWidgetLifecycle;
              },
        message: tip,
        value: con.debugPrintGlobalKeyedWidgetLifecycle,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintGlobalKeyedWidgetLifecycle = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.location_history_outlined),
        title: const Text("Adds 'Timeline' events for every Widget built"),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabled = !con.debugProfileBuildsEnabled;
              },
        message: tip,
        value: con.debugProfileBuildsEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabled = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.foundation),
        title:
            const Text("Adds 'Timeline' for every user-created [Widget] built"),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabledUserWidgets =
                    !con.debugProfileBuildsEnabledUserWidgets;
              },
        message: tip,
        value: con.debugProfileBuildsEnabledUserWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabledUserWidgets = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.view_timeline),
        title: const Text(
            "Adds debugging info. to 'Timeline' related to Widget builds"),
        onTap: disable
            ? null
            : () {
                con.debugEnhanceBuildTimelineArguments =
                    !con.debugEnhanceBuildTimelineArguments;
              },
        message: tip,
        value: con.debugEnhanceBuildTimelineArguments,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugEnhanceBuildTimelineArguments = value;
              },
      ),
      _listTile(
        leading: const Icon(Icons.wrong_location),
        title: const Text('Show banners for deprecated widgets'),
        onTap: disable
            ? null
            : () {
                con.debugHighlightDeprecatedWidgets =
                    !con.debugHighlightDeprecatedWidgets;
              },
        message: tip,
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

/// Supply the appropriate ListTile widget
Widget _listTile({
  Widget? leading,
  Widget? title,
  GestureTapCallback? onTap,
  String? message,
  required bool value,
  ValueChanged<bool>? onChanged,
}) =>
    ListTile(
      leading: leading,
      title: title,
      onTap: onTap,
      trailing: Tooltip(
        message: message,
        preferBelow: false,
        verticalOffset: 20,
        height: 24,
        child: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );

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
