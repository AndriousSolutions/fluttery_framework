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
  _DevToolsSettingsState() : super(controller: DevToolSettingsController()) {
    con = controller as DevToolSettingsController;
  }

  late DevToolSettingsController con;

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
    final isSmall = context.isPhone && !kIsWeb;

    // Disable if running in Cupertino
    final disable = App.useCupertino;

    final tip = disable ? 'Enabled in Material Design'.tr : '';

    final List<Widget> widgets = <Widget>[
      listTile(
        leading: isSmall ? null : const Icon(Icons.picture_in_picture),
        title: isSmall
            ? Text('Performance overlay'.tr)
            : Text('Show rendering performance overlay'.tr),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay;
        },
        value: con.showPerformanceOverlay,
        onChanged: (bool value) {
          con.showPerformanceOverlay = value;
        },
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.accessibility),
        title: isSmall
            ? Text('Accessibility'.tr)
            : Text('Show accessibility information'.tr),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger;
        },
        value: con.showSemanticsDebugger,
        onChanged: (bool value) {
          con.showSemanticsDebugger = value;
        },
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.bug_report),
        title: isSmall ? Text('DEBUG banner'.tr) : Text('Show DEBUG banner'.tr),
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
          leading:
              isSmall ? null : const Icon(Icons.screen_lock_landscape_sharp),
          title: isSmall
              ? Text('Material 3'.tr)
              : Text('Use Material 3 Design'.tr),
          onTap: () {
            con.useMaterial3 = !con.useMaterial3;
          },
          value: con.useMaterial3,
          onChanged: (bool value) {
            con.useMaterial3 = value;
          },
        ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.border_clear),
        title:
            isSmall ? Text('Material grid'.tr) : Text('Show material grid'.tr),
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
    //
    final isSmall = context.isPhone && !kIsWeb;

    // Disable if running in Production
    const disable = kReleaseMode;

    final tip = disable ? 'Only in Development'.tr : '';

    // material grid and size construction lines are only available in checked mode
    widgets.addAll(<Widget>[
      listTile(
        leading: isSmall ? null : const Icon(Icons.border_all),
        title: isSmall
            ? Text('Construct lines'.tr)
            : Text('Paint construction lines'.tr),
        onTap: disable
            ? null
            : () => con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled,
        tip: tip,
        value: con.debugPaintSizeEnabled,
        onChanged:
            disable ? null : (bool value) => con.debugPaintSizeEnabled = value,
      ),
      listTile(
        leading: isSmall ? null : const Icon(Icons.format_color_text),
        title: isSmall
            ? Text('Character baselines'.tr)
            : Text('Show character baselines'.tr),
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
        leading: isSmall ? null : const Icon(Icons.mouse),
        title:
            isSmall ? Text('Flash taps'.tr) : Text('Flash interface taps'.tr),
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
        leading: isSmall ? null : const Icon(Icons.filter_none),
        title: isSmall
            ? Text('Boundary lines'.tr)
            : Text('Highlight layer boundaries'.tr),
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
        leading: isSmall ? null : const Icon(Icons.gradient),
        title: isSmall
            ? Text('Highlight layers'.tr)
            : Text('Highlight repainted layers'.tr),
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
        leading: isSmall ? null : const Icon(Icons.vignette),
        title: isSmall
            ? Text('Color text'.tr)
            : Text('Rotating colors repainting text'.tr),
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
        leading: isSmall ? null : const Icon(Icons.dirty_lens),
        title: isSmall
            ? Text('Log dirty widgets'.tr)
            : Text('Log dirty widgets rebuilt'.tr),
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
        leading: isSmall ? null : const Icon(Icons.dirty_lens_rounded),
        title: isSmall
            ? Text('Callback for every rebuild'.tr)
            : Text('Callback called for every dirty widget rebuilt'.tr),
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
        leading: isSmall ? null : const Icon(Icons.arrow_circle_right_outlined),
        title: isSmall
            ? Text('Log BuildScope'.tr)
            : Text('Log to BuildOwner.buildScope'.tr),
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
        leading: isSmall ? null : const Icon(Icons.update),
        title: isSmall
            ? Text('Log widget rebuilds'.tr)
            : Text('Log call stacks marking widgets to rebuild'.tr),
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
        leading: isSmall ? null : const Icon(Icons.location_history_outlined),
        title: isSmall
            ? Text("'Timeline' for every build".tr)
            : Text("Adds 'Timeline' events for every Widget build".tr),
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
        leading: isSmall ? null : const Icon(Icons.foundation),
        title: isSmall
            ? Text("'Timeline' for every user build".tr)
            : Text("Adds 'Timeline' for every user-created [Widget] built".tr),
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
        leading: isSmall ? null : const Icon(Icons.wrong_location),
        title: isSmall
            ? Text('Deprecated widgets'.tr)
            : Text('Show banners for deprecated widgets'.tr),
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
