//
import '/src/controller.dart';

///
class DevToolSettingsController extends StateXController {
  /// Singleton Pattern
  factory DevToolSettingsController() =>
      _this ??= DevToolSettingsController._();

  DevToolSettingsController._();

  static DevToolSettingsController? _this;

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