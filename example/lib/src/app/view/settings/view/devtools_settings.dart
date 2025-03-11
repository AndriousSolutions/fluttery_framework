//
import 'package:fluttery_framework/view.dart' as v;

import '/src/controller.dart';

import '/src/view.dart';

///
class DevSettingsDrawer extends v.AppDrawer {
  ///
  DevSettingsDrawer({super.key}) {
    if (App.useMaterial) {
      add(const DevToolsSettings.column(key: Key('DevToolsSettings')));
    } else {
      add(const DevToolsSettings.disabled(key: Key('DevToolsSettings')));
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
class _DevToolsSettingsState extends State<DevToolsSettings> {
  _DevToolsSettingsState() {
    con = DevToolSettingsController();
  }

  late DevToolSettingsController con;

  @override
  Widget build(BuildContext context) {
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
    final isSmall = context.isPhone && !kIsWeb;

    // Disable if running in Cupertino
    final disable = App.useCupertino;

    final tip = disable ? 'Enabled in Material Design'.tr : '';

    final List<Widget> widgets = <Widget>[
      listTile(
        key: const Key('overlay'),
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall
            ? Text('Perform overlay'.tr)
            : Text('Show rendering performance overlay'.tr),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay;
          setState(() {});
        },
        value: con.showPerformanceOverlay,
        onChanged: (bool value) {
          con.showPerformanceOverlay = value;
          setState(() {});
        },
      ),
      listTile(
        key: const Key('accessibility'),
        leading: isSmall ? null : const Icon(Icons.accessibility),
        title: isSmall
            ? Text('Access'.tr)
            : Text('Show accessibility information'.tr),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger;
          setState(() {});
        },
        value: con.showSemanticsDebugger,
        onChanged: (bool value) {
          con.showSemanticsDebugger = value;
          setState(() {});
        },
      ),
      listTile(
        key: const Key('banner'),
        leading: isSmall ? null : const Icon(Icons.bug_report),
        title: isSmall ? Text('DEBUG banner'.tr) : Text('Show DEBUG banner'.tr),
        onTap: () {
          con.debugShowCheckedModeBanner = !con.debugShowCheckedModeBanner;
          setState(() {});
        },
        value: con.debugShowCheckedModeBanner,
        onChanged: (bool value) {
          con.debugShowCheckedModeBanner = value;
          setState(() {});
        },
      ),
      if (App.useMaterial)
        listTile(
          key: const Key('material 3'),
          leading:
              isSmall ? null : const Icon(Icons.screen_lock_landscape_sharp),
          title: isSmall
              ? Text('Material 3'.tr)
              : Text('Use Material 3 Design'.tr),
          onTap: () {
            con.useMaterial3 = !con.useMaterial3;
            setState(() {});
          },
          value: con.useMaterial3,
          onChanged: (bool value) {
            con.useMaterial3 = value;
            setState(() {});
          },
        ),
      listTile(
        key: const Key('grid'),
        leading: isSmall ? null : const Icon(Icons.border_clear),
        title:
            isSmall ? Text('Material grid'.tr) : Text('Show material grid'.tr),
        onTap: disable
            ? null
            : () {
                con.debugShowMaterialGrid = !con.debugShowMaterialGrid;
                setState(() {});
              },
        tip: tip,
        value: con.debugShowMaterialGrid,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugShowMaterialGrid = value;
                setState(() {});
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
    //
    final isSmall = context.isPhone && !kIsWeb;

    // Disable if running in Production
    const disable = kReleaseMode;

    final tip = disable ? 'Only in Development'.tr : '';

    // material grid and size construction lines are only available in checked mode
    widgets.addAll(<Widget>[
      listTile(
          key: const Key('construction'),
          leading: isSmall ? null : const Icon(Icons.border_all),
          title: isSmall
              ? Text('Construct lines'.tr)
              : Text('Paint construction lines'.tr),
          onTap: disable
              ? null
              : () {
                  con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled;
                  setState(() {});
                },
          tip: tip,
          value: con.debugPaintSizeEnabled,
          onChanged: disable
              ? null
              : (bool value) {
                  con.debugPaintSizeEnabled = value;
                  setState(() {});
                }),
      listTile(
        key: const Key('baselines'),
        leading: isSmall ? null : const Icon(Icons.format_color_text),
        title: isSmall
            ? Text('Character baselines'.tr)
            : Text('Show character baselines'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintBaselinesEnabled =
                    !con.debugPaintBaselinesEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugPaintBaselinesEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintBaselinesEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('taps'),
        leading: isSmall ? null : const Icon(Icons.mouse),
        title:
            isSmall ? Text('Flash taps'.tr) : Text('Flash interface taps'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugPaintPointersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintPointersEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('lines'),
        leading: isSmall ? null : const Icon(Icons.filter_none),
        title: isSmall
            ? Text('Boundary lines'.tr)
            : Text('Highlight layer boundaries'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPaintLayerBordersEnabled =
                    !con.debugPaintLayerBordersEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugPaintLayerBordersEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPaintLayerBordersEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('layers'),
        leading: isSmall ? null : const Icon(Icons.gradient),
        title: isSmall
            ? Text('Highlight layers'.tr)
            : Text('Highlight repainted layers'.tr),
        onTap: disable
            ? null
            : () {
                con.debugRepaintRainbowEnabled =
                    !con.debugRepaintRainbowEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugRepaintRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintRainbowEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('colors'),
        leading: isSmall ? null : const Icon(Icons.vignette),
        title: isSmall
            ? Text('Color text'.tr)
            : Text('Rotating colors repainting text'.tr),
        onTap: disable
            ? null
            : () {
                con.debugRepaintTextRainbowEnabled =
                    !con.debugRepaintTextRainbowEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugRepaintTextRainbowEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugRepaintTextRainbowEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('dirty'),
        leading: isSmall ? null : const Icon(Icons.dirty_lens),
        title: isSmall
            ? Text('Log dirty widgets'.tr)
            : Text('Log dirty widgets rebuilt'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintRebuildDirtyWidgets =
                    !con.debugPrintRebuildDirtyWidgets;
                setState(() {});
              },
        tip: tip,
        value: con.debugPrintRebuildDirtyWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintRebuildDirtyWidgets = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('callback'),
        leading: isSmall ? null : const Icon(Icons.dirty_lens_rounded),
        title: isSmall
            ? Text('Callback for every rebuild'.tr)
            : Text('Callback called for every dirty widget rebuilt'.tr),
        onTap: disable
            ? null
            : () {
                con.debugOnRebuildDirtyWidget = !con.debugOnRebuildDirtyWidget;
                setState(() {});
              },
        tip: tip,
        value: con.debugOnRebuildDirtyWidget,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugOnRebuildDirtyWidget = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('scope'),
        leading: isSmall ? null : const Icon(Icons.arrow_circle_right_outlined),
        title: isSmall
            ? Text('Log Scope'.tr)
            : Text('Log to BuildOwner.buildScope'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintBuildScope = !con.debugPrintBuildScope;
                setState(() {});
              },
        tip: tip,
        value: con.debugPrintBuildScope,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintBuildScope = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('rebuilds'),
        leading: isSmall ? null : const Icon(Icons.update),
        title: isSmall
            ? Text('Log widget rebuilds'.tr)
            : Text('Log call stacks marking widgets to rebuild'.tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintScheduleBuildForStacks =
                    !con.debugPrintScheduleBuildForStacks;
                setState(() {});
              },
        tip: tip,
        value: con.debugPrintScheduleBuildForStacks,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintScheduleBuildForStacks = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('global'),
        leading: isSmall ? null : const Icon(Icons.language),
        title: isSmall
            ? Text("Log widget's global keys".tr)
            : Text(
                'Log widgets with global keys when deactivated and reactivated'
                    .tr),
        onTap: disable
            ? null
            : () {
                con.debugPrintGlobalKeyedWidgetLifecycle =
                    !con.debugPrintGlobalKeyedWidgetLifecycle;
                setState(() {});
              },
        tip: tip,
        value: con.debugPrintGlobalKeyedWidgetLifecycle,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugPrintGlobalKeyedWidgetLifecycle = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('build'),
        leading: isSmall ? null : const Icon(Icons.location_history_outlined),
        title: isSmall
            ? Text("'Timeline' for every build".tr)
            : Text("Adds 'Timeline' events for every Widget build".tr),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabled = !con.debugProfileBuildsEnabled;
                setState(() {});
              },
        tip: tip,
        value: con.debugProfileBuildsEnabled,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabled = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('timeline'),
        leading: isSmall ? null : const Icon(Icons.foundation),
        title: isSmall
            ? Text("'Timeline' for every user build".tr)
            : Text("Adds 'Timeline' for every user-created [Widget] built".tr),
        onTap: disable
            ? null
            : () {
                con.debugProfileBuildsEnabledUserWidgets =
                    !con.debugProfileBuildsEnabledUserWidgets;
                setState(() {});
              },
        tip: tip,
        value: con.debugProfileBuildsEnabledUserWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugProfileBuildsEnabledUserWidgets = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('debugging'),
        leading: isSmall ? null : const Icon(Icons.view_timeline),
        title: isSmall
            ? Text('Debug info.'.tr)
            : Text("Adds debugging info. to 'Timeline' related to Widget builds"
                .tr),
        onTap: disable
            ? null
            : () {
                con.debugEnhanceBuildTimelineArguments =
                    !con.debugEnhanceBuildTimelineArguments;
                setState(() {});
              },
        tip: tip,
        value: con.debugEnhanceBuildTimelineArguments,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugEnhanceBuildTimelineArguments = value;
                setState(() {});
              },
      ),
      listTile(
        key: const Key('deprecated'),
        leading: isSmall ? null : const Icon(Icons.wrong_location),
        title: isSmall
            ? Text('Deprecate widgets'.tr)
            : Text('Show banners for deprecated widgets'.tr),
        onTap: disable
            ? null
            : () {
                con.debugHighlightDeprecatedWidgets =
                    !con.debugHighlightDeprecatedWidgets;
                setState(() {});
              },
        tip: tip,
        value: con.debugHighlightDeprecatedWidgets,
        onChanged: disable
            ? null
            : (bool value) {
                con.debugHighlightDeprecatedWidgets = value;
                setState(() {});
              },
      ),
    ]);
  }
}
