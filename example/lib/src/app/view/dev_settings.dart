//
import '/src/controller.dart';

import '/src/view.dart';

///
class DevToolsSettings extends StatefulWidget {
  ///
  const DevToolsSettings({super.key, this.shrinkWrap}) : column = false;

  ///
  const DevToolsSettings.column({super.key, this.shrinkWrap}) : column = true;

  ///
  final bool? shrinkWrap;

  ///
  final bool? column;

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
    if (widget.column ?? false) {
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
    ];
    // An approach to determine if running in your IDE or not is the assert()
    // i.e. When your in your Debugger or not.
    // The compiler removes assert functions and their content when in Production.
    assert(() {
      // material grid and size construction lines are only available in checked mode
      widgets.addAll(<Widget>[
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
        ListTile(
          leading: const Icon(Icons.border_all),
          title: const Text('Paint construction lines'),
          onTap: () {
            con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled;
          },
          trailing: Switch(
            value: con.debugPaintSizeEnabled,
            onChanged: (bool value) {
              con.debugPaintSizeEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.format_color_text),
          title: const Text('Show character baselines'),
          onTap: () {
            con.debugPaintBaselinesEnabled = !con.debugPaintBaselinesEnabled;
          },
          trailing: Switch(
            value: con.debugPaintBaselinesEnabled,
            onChanged: (bool value) {
              con.debugPaintBaselinesEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.filter_none),
          title: const Text('Highlight layer boundaries'),
          onTap: () {
            con.debugPaintLayerBordersEnabled =
                !con.debugPaintLayerBordersEnabled;
          },
          trailing: Switch(
            value: con.debugPaintLayerBordersEnabled,
            onChanged: (bool value) {
              con.debugPaintLayerBordersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.mouse),
          title: const Text('Flash interface taps'),
          onTap: () {
            con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled;
          },
          trailing: Switch(
            value: con.debugPaintPointersEnabled,
            onChanged: (bool value) {
              con.debugPaintPointersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.gradient),
          title: const Text('Highlight repainted layers'),
          onTap: () {
            con.debugRepaintRainbowEnabled = !con.debugRepaintRainbowEnabled;
          },
          trailing: Switch(
            value: con.debugRepaintRainbowEnabled,
            onChanged: (bool value) {
              con.debugRepaintRainbowEnabled = value;
            },
          ),
        ),
      ]);
      return true;
    }());
    return widgets;
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
