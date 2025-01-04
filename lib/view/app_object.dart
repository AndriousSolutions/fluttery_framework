// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  09 Feb 2019
//
//

import 'dart:async' show Future, StreamSubscription;

import 'dart:ui' as ui show FlutterView;

import 'package:universal_io/io.dart' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;

import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import '/model.dart';

import '/view.dart' as v;

import '/controller.dart' show AppErrorHandler, DeviceInfo;

/// Supply a 'high level' reference to the 'App object.'
// ignore: non_constant_identifier_names
final App = AppObject();

/// This class is available throughout the app
/// readily supplies static properties about the App.
///
/// dartdoc:
/// {@category Get started}
/// {@category App object}
class AppObject
    with
        ConnectivityListener,
        _AppPackageInfoMixin,
        _AppThemeDataMixin,
        v.RouteNavigatorMethodsMixin {
  /// One single instance of the App object
  factory AppObject({
    @Deprecated("The 'error' parameter is deprecated.")
    bool? allowNewHandlers = true,
  }) =>
      _this ??= AppObject._();

  AppObject._() {
    // Supply the Error Handler
    _errorHandler = AppErrorHandler();

    _connectivity = Connectivity();

    // Monitor the device's connectivity to the Internet.
    addConnectivityListener(this);
  }
  static AppObject? _this;

  /// Determine the connectivity.
  late Connectivity _connectivity;

  /// Indicating app is running in the Flutter engine and not in
  /// the `flutter_test` framework with TestWidgetsFlutterBinding for example
  bool get inWidgetsFlutterBinding => _inWidgetsFlutterBinding ??=
      WidgetsBinding.instance is WidgetsFlutterBinding;
  bool? _inWidgetsFlutterBinding;

  /// Indicate if running under a 'Flutter Test' environment
  bool get inFlutterTest =>
      _inFlutterTest ??= Platform.environment.containsKey('FLUTTER_TEST') ||
          WidgetsBinding.instance is! WidgetsFlutterBinding;
  bool? _inFlutterTest;

  // Current Error Handler.
  AppErrorHandler? _errorHandler;

  /// Dispose the App properties.
  @override
  void dispose() {
    _connectivitySubscriptionList?.cancel();
    _connectivitySubscriptionList = null;
    _appState = null; // Remove local reference
    _errorHandler = null;
  }

  /// The App State object.
// Not yet gp  @Deprecated('Should not be an exposed property')
  v.AppStateX? get appState => _appState;
  set appState(v.AppStateX? state) {
    if (state != null && (_appState == null || hotReload)) {
      _appState = state;
      state.app = this;
    }
  }

  static v.AppStateX? _appState;

  /// App-level error handling.
  void onError(FlutterErrorDetails details) =>
      _errorHandler?.flutteryExceptionHandler?.call(details);

  /// App-level error handling if async operation at start up fails
  void onAsyncError(AsyncSnapshot<bool> snapshot) {
    final dynamic exception = snapshot.error;
    final details = FlutterErrorDetails(
      exception: exception,
      stack: exception is Error ? exception.stackTrace : null,
      library: 'app_statefulwidget',
      context: ErrorDescription('while getting ready with FutureBuilder Async'),
    );
    onError(details);
  }

  /// Collect the device's information.
  @override
  Future<void> getDeviceInfo() async {
    // There's 'no device' while testing and so don't collect device info.
    // if (!inFlutterTest) {
    if (inWidgetsFlutterBinding) {
      // Assign _packageInfo
      await super.getDeviceInfo();
      // Collect Device Information
      await DeviceInfo.initAsync();
    }
  }

  /// Determine if the App initialized successfully.
  // ignore: unnecessary_getters_setters
  bool? get isInit => _isInit;

  /// Set the init only once.
  // ignore: unnecessary_getters_setters
  set isInit(bool? init) => _isInit ??= init;
  bool? _isInit;

  /// Determine if this app is running alone
  bool? get standAloneApp => _standAlone;
  set standAloneApp(bool? alone) {
    if (!_standAlone) {
      if (alone != null && alone) {
        _standAlone = true;
      }
    }
  }

  bool _standAlone = false;

  /// Flag to set hot reload from now on.
  // ignore: unnecessary_getters_setters
  bool get hotReload => _hotReload;

  /// Once set, it will always hot reload.
  // ignore: unnecessary_getters_setters
  set hotReload(bool hotReload) {
    // It doesn't accept false. i.e. Once true, it stays true.
    if (hotReload) {
      _hotReload = hotReload;
    }
  }

  /// Flag indicating there was a 'hot reload'
  bool _hotReload = false;

  /// Flutter application's main window.
  ui.FlutterView get mainWindow {
    if (_window == null) {
      if (context == null) {
        _window = WidgetsBinding.instance.platformDispatcher.views.first;
      } else {
        _window = View.of(context!);
      }
    }
    return _window!;
  }

  ui.FlutterView? _window;

  /// Reference a possible GoRouter
  v.GoRouter? get goRouter => _goRouter;
  set goRouter(v.RouterConfig<Object>? router) {
    if (_goRouter == null && router != null && router is v.GoRouter) {
      _goRouter = router;
    }
  }

  /// Gain a reference of the GoRouter and not use the bad GoRouter.of()
  v.GoRouter? _goRouter;

  /// The running platform
  TargetPlatform? get platform {
    if (_platform == null && context != null) {
      _platform = Theme.of(context!).platform;
    }
    return _platform;
  }

  TargetPlatform? _platform;

  /// App is allowed to change the app's theme
  /// Is this app allowed to manually change locale?
  bool get allowChangeTheme => appState?.allowChangeTheme ?? false;

  /// Return the saved Locale if any.
  Locale? get preferredLocale {
    final codes = Prefs.getString('locale').split('-');
    Locale? locale;
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
    }
    return locale;
  }

  /// Is this app allowed to manually change locale?
  bool get allowChangeLocale => appState?.allowChangeLocale ?? false;

  /// Save a locale to the app's locale
  Future<bool> saveLocale([Locale? locale]) async {
    final saved = allowChangeLocale && locale != null;
    //Saved only if first called to look up.
    if (saved) {
      appState?.locale = locale; // Ensure AppState gets updated
      await Prefs.setString('locale', locale.toLanguageTag());
    }
    return saved;
  }

  /// Is this app allowed to change the very UI (Material, Cupertino, etc.)
  bool get allowChangeUI => appState?.allowChangeUI ?? false;

  /// Display the SnackBar
  void snackBar({
    Key? key,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    Duration? duration,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection? dismissDirection,
    Clip? clipBehavior,
  }) {
    ScaffoldMessengerState? state;
    final context = this.context;
    if (context != null) {
      state = ScaffoldMessenger.maybeOf(context);
    }
    state?.showSnackBar(
      SnackBar(
        key: key,
        content: content,
        backgroundColor: backgroundColor,
        elevation: elevation,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        behavior: behavior,
        action: action,
        duration: duration ?? const Duration(milliseconds: 4000),
        animation: animation,
        onVisible: onVisible,
        dismissDirection: dismissDirection ?? DismissDirection.down,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
      ),
    );
  }

  // /// Catch and explicitly handle the error.
  // static void catchError(Object ex) {
  //   if (ex is! Exception) {
  //     ex = Exception(ex.toString());
  //   }
  //   _appState?.catchError(ex);
  // }
  //
  // /// Retrieve the 'lastest' context
  // static BuildContext? get context => _appState?.lastContext;

  /// The Scaffold object for this App's View.
  ScaffoldState? get scaffold =>
      context == null ? null : Scaffold.maybeOf(context!);

  /// The Physical width of the screen
  double get screenPhysicalWidth {
    double physicalWidth;
    final context = this.context;
    if (context == null) {
      physicalWidth = mainWindow.physicalSize.width;
    } else {
      final media = MediaQuery.of(context);
      physicalWidth = media.size.width * media.devicePixelRatio;
    }
    return physicalWidth;
  }

  /// The 'logical' width of the screen
  double get screenWidth {
    double logicalWidth;
    final context = this.context;
    if (context == null) {
      final size = mainWindow.physicalSize / mainWindow.devicePixelRatio;
      logicalWidth = size.width;
    } else {
      logicalWidth = MediaQuery.of(context).size.width;
    }
    return logicalWidth;
  }

  /// The Physical height of the screen
  double get screenPhysicalHeight {
    double physicalHeight;
    final context = this.context;
    if (context == null) {
      physicalHeight = mainWindow.physicalSize.height;
    } else {
      final media = MediaQuery.of(context);
      physicalHeight = media.size.height * media.devicePixelRatio;
    }
    return physicalHeight;
  }

  /// The 'Logical' height of the screen
  double get screenHeight {
    double logicalHeight;
    final context = this.context;
    if (context == null) {
      final size = mainWindow.physicalSize / mainWindow.devicePixelRatio;
      logicalHeight = size.height;
    } else {
      final media = MediaQuery.of(context);
      logicalHeight = media.size.height -
          media.padding.top -
          kToolbarHeight -
          kBottomNavigationBarHeight;
    }
    return logicalHeight;
  }

  /// Current Screen Size
  Size get screenSize => MediaQueryData.fromView(mainWindow).size;

  /// Set whether the app is to use a 'small screen' or not.
  bool get asSmallScreen => App.inDebugMode && false;

  /// Return the bool value indicating if running in a small screen or not.
  bool get inSmallScreen {
    bool smallScreen;

    // May be manually assigned.
    smallScreen = asSmallScreen;

    if (!smallScreen) {
      smallScreen = screenSize.width < 800;
    }
    return smallScreen;
  }

  /// The local directory for this App.
  String? get filesDir => _appDirPath;
  String? _appDirPath;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscriptionList;

  /// Returns the connection status of the device.
  String? get connectivity => _connectivityStatus;
  String? _connectivityStatus;

  /// Indicates if the app has access to the Internet.
  /// Assume we're online if null
  bool get isOnline =>
      _connectivityStatus == null || !_connectivityStatus!.contains('none');

  /// Was off but now turned on connectivity
  bool get turnedOnInternet => _turnedOnInternet;
  bool _turnedOnInternet = true;
  bool _wasOffline = false;

  /// Was on but now turned off connectivity
  bool get turnedOffInternet => _turnedOffInternet;
  bool _turnedOffInternet = false;

  ///
  @override
  @mustCallSuper
  void onConnectivityChanged(ConnectivityResult result) {
    _connectivityStatus = result.name;
    final nowOnline = App.isOnline;
    // Connectivity was turned on
    if (_wasOffline && nowOnline) {
      _wasOffline = false;
      _turnedOnInternet = true;
      _turnedOffInternet = false;
    } else
    // Connectivity was turned off
    if (!_wasOffline && !nowOnline) {
      _wasOffline = true;
      _turnedOnInternet = false;
      _turnedOffInternet = true;
    } else {
      _turnedOnInternet = false;
      _turnedOffInternet = false;
    }
  }

  /// Connectivity listeners.
  final Set<ConnectivityListener> _listeners = {};

  /// Add a Connectivity listener.
  bool addConnectivityListener(ConnectivityListener? listener) {
    var add = false;
    if (listener != null) {
      add = _listeners.add(listener);
    }
    return add;
  }

  /// Remove a Connectivity listener.
  bool removeConnectivityListener(ConnectivityListener? listener) {
    var remove = false;
    if (listener != null) {
      remove = _listeners.remove(listener);
    }
    return remove;
  }

  // /// Clear Connectivity listeners.
  // static void clearConnectivityListener() => _listeners.clear();

  /// The id for this App's particular installation.
  Future<String?> getInstallNum() => InstallFile.id();

  /// The unique id for this app's particular installation.
  String? get installNum => _installNum;
  String? _installNum;

  /// Internal Initialization routines.
  Future<void> initInternal() async {
    //
    if (!inWidgetsFlutterBinding) {
      // Such functionality is not available during testing
      return;
    }

    _connectivitySubscriptionList ??=
        _connectivity.onConnectivityChanged.listen((connects) {
      connects.map((result) {
        for (final listener in _listeners) {
          listener.onConnectivityChanged(result);
        }
      });
    });

    await _initConnectivity().then((String status) {
      _connectivityStatus = status;
      _wasOffline = status.contains('none');
    }).catchError((e) {
      _connectivityStatus = 'none';
    });

    // If running on the web the rest of the code is incompatible.
    if (kIsWeb) {
      return;
    }

    // Get the installation number
    _installNum ??= await InstallFile.id();

    // Determine the location to the files directory.
    _appDirPath ??= await Files.localPath;
  }

  Future<String> _initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (ex) {
      connectionStatus = 'Failed to determine connectivity';
    }
    return connectionStatus;
  }
}

///
mixin _AppThemeDataMixin {
  // Allow it to be assigned null.
  /// The App's current Material theme.
  ThemeData? get themeData => _themeData;

  /// Assign the ThemeData
  set themeData(dynamic value) {
    if (value == null) {
      return;
    }
    if (value is ThemeData) {
      _themeData = value;
    } else if (value is CupertinoThemeData) {
      // Ignore the value
    } else if (value is! ColorSwatch) {
      // Ignore the value
    } else if (_themeData == null) {
      _themeData = ThemeData(
        primaryColor: value,
      );
    } else {
      _themeData = _themeData?.copyWith(
        primaryColor: value,
      );
    }
  }

  ThemeData? _themeData;

  /// The app's current Cupertino theme.
  CupertinoThemeData? get iOSThemeData => _iOSThemeData;
  set iOSThemeData(dynamic value) {
    if (value == null) {
      return;
    }
    if (value is CupertinoThemeData) {
      _iOSThemeData = value;
    } else if (value is ThemeData) {
      _iOSThemeData = MaterialBasedCupertinoThemeData(materialTheme: value);
      final context = App.context;
      if (context != null) {
        _iOSThemeData = _iOSThemeData?.resolveFrom(context);
      }
    } else if (value is! Color) {
      // Ignore the value
    } else if (_iOSThemeData == null) {
      _iOSThemeData = CupertinoThemeData(
        primaryColor: value,
      );
    } else {
      _iOSThemeData = _iOSThemeData?.copyWith(
        primaryColor: value,
      );
    }
  }

  CupertinoThemeData? _iOSThemeData;

  /// Set the app's general color theme supplying a [Color] value.
  Color? setThemeData({
    ColorSwatch<int?>? swatch,
  }) {
    //
    final value = swatch?.value;

    if (!Prefs.ready()) {
      return value == null ? null : Color(value);
    }

    MaterialColor? materialColor;
    Color? color;
    int index = -1;

    if (value != null) {
      color = Color(value);
      materialColor = swatch as MaterialColor;
      index =
          Colors.primaries.indexOf(materialColor); // Returns -1 if not found.
      Prefs.setInt('primaryIndex', index);
    } else {
      index = Prefs.getInt('primaryIndex', -1);
    }

    if (index > -1) {
      //
      materialColor = Colors.primaries[index];

      color ??= Color(materialColor.value);

      /// Assign the colour to the floating button as well.
      themeData = ThemeData(
        useMaterial3: false,
        primarySwatch: materialColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: color,
        ),
      );
    }
    return color;
  }

  ///
  MaterialColor? getMaterialColor(Color? color) {
    //
    if (color == null) {
      return null;
    }

    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };
    return MaterialColor(color.value, shades);
  }

  ///
  void dispose() {
    _themeData = null;
  }
}

///
mixin _AppPackageInfoMixin {
  /// Application information
  PackageInfo? _packageInfo;

  /// Collect the device's information.
  Future<void> getDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// The package info.
  PackageInfo? get packageInfo => _packageInfo;

  /// The Name of the App.
  String? get appName => _packageInfo?.appName;

  /// The 'Package Name' of the App.
  String? get packageName => _packageInfo?.packageName;

  /// The current version of the App.
  String? get version => _packageInfo?.version;

  /// The build number of the App.
  String? get buildNumber => _packageInfo?.buildNumber;

  /// Dispose the App properties.
  void dispose() {
    _packageInfo = null;
  }
}

/// A Listener for the device's own connectivity status at any point in time.
mixin ConnectivityListener {
  /// A listener method to respond if the device's connectivity changes.
  void onConnectivityChanged(ConnectivityResult result);
}

/// A standard Drawer object for your Flutter app.
class AppDrawer extends StatelessWidget {
  /// Supply the properties to a Material Design [Drawer] Widget.
  AppDrawer({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.width,
    this.header,
    this.children,
    this.semanticLabel,
    this.scrollDirection,
    this.reverse,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
  }) {
    // Take any defined items.
    if (children != null) {
      _children.addAll(children!);
    }
  }

  /// The drawer's color.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this drawer relative to its parent.
  final double? elevation;

  /// The color used to paint a drop shadow under the drawer's [Material],
  /// which reflects the drawer's [elevation].
  final Color? shadowColor;

  /// The color used as a surface tint overlay on the drawer's background color,
  /// which reflects the drawer's [elevation].
  final Color? surfaceTintColor;

  /// The shape of the drawer.
  final ShapeBorder? shape;

  /// The width of the drawer.
  final double? width;

  /// The top-most region of a material design drawer.
  final DrawerHeader? header;

  /// The semantic label of the dialog used by accessibility frameworks.
  final String? semanticLabel;

  /// The axis along which the scroll view scrolls.
  final Axis? scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  final bool? reverse;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent
  final bool? primary;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed
  final bool? shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  final double? itemExtent;

  /// If non-null, forces the children to have the same extent as the given
  /// widget in the scroll direction.
  final Widget? prototypeItem;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  final bool? addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  final bool? addRepaintBoundaries;

  /// Whether to wrap each child in an [IndexedSemantics].
  final bool? addSemanticIndexes;

  /// The List of Widget items that make up the Drawer's contents.
  final List<Widget>? children;

  //
  final List<Widget> _children = <Widget>[];

  /// one item
  void add(Widget? item) {
    if (item != null) {
      _children.add(item);
    }
  }

  /// Add a List
  void addAll(List<Widget>? items) {
    if (items != null) {
      _children.addAll(items);
    }
  }

  /// Remove an item
  bool remove(Widget? item) {
    bool remove = item != null;
    if (remove) {
      remove = _children.remove(item);
    }
    return remove;
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    if (header != null) {
      widgets.add(header!);
    }
    if (_children.isNotEmpty) {
      widgets.addAll(_children);
    }
    return Drawer(
      backgroundColor: backgroundColor,
      elevation: elevation ?? 16,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      shape: shape,
      width: width,
      semanticLabel: semanticLabel,
      child: ListView(
        scrollDirection: scrollDirection ?? Axis.vertical,
        reverse: reverse ?? false,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap ?? false,
        padding: padding,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
        addAutomaticKeepAlives: addAutomaticKeepAlives ?? true,
        addRepaintBoundaries: addRepaintBoundaries ?? true,
        addSemanticIndexes: addSemanticIndexes ?? true,
        children: widgets,
      ),
    );
  }
}
