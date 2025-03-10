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

import '/controller.dart' show DeviceInfo;

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
        _AppPackageInfoMixin,
        _AppThemeDataMixin,
        ConnectivityListener,
        v.StateXonErrorMixin {
  // v.RouteNavigatorMethodsMixin {
  /// One single instance of the App object
  factory AppObject({
    @Deprecated("The 'error' parameter is deprecated.")
    bool? allowNewHandlers = true,
  }) =>
      _this ??= AppObject._();

  AppObject._() {
    //
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

  /// Dispose the App properties.
  @override
  void dispose() {
    _connectivitySubscriptionList?.cancel();
    _connectivitySubscriptionList = null;
    _appState = null; // Remove local reference
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

  // Reference the App's State object
  static v.AppStateX? _appState;

  /// Log an Error
  @override
  void logErrorDetails(details) {
    if (logError) {
      super.logErrorDetails(details);
    } else {
      logError = true; // Log error next time
    }
  }

  /// Flag whether to log the next error
  static bool logError = true;

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
  bool get isInit => _isInit ?? false;

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
    Widget? content,
    String? message,
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
    int? durationMillis,
    int? animationDurationMillis,
  }) {
    //
    final context = this.context;

    if (useMaterial) {
      //
      if (content == null) {
        if (message != null) {
          message = message.trim();
          if (message.isNotEmpty) {
            content = Text(message);
          }
        }
        if (content == null) {
          return; // Nothing to display
        }
      }

      ScaffoldMessengerState? state;

      if (context != null) {
        state = ScaffoldMessenger.maybeOf(context);
      }

      state ??= appState?.scaffoldMessengerKey?.currentState;

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
    } else {
      //
      if (context == null) {
        return;
      }

      if (message == null) {
        return; // Nothing to display
      }

      message = message.trim();

      if (message.isEmpty) {
        return; // Nothing to display
      }

      animationDurationMillis ??= 200;
      durationMillis ??= 3000;

      final overlayEntry = OverlayEntry(
        builder: (context) => _CupertinoSnackBar(
          key: key,
          message: message!,
          animationDurationMillis: animationDurationMillis!,
          waitDurationMillis: durationMillis!,
        ),
      );

      Future.delayed(
        Duration(milliseconds: durationMillis + 2 * animationDurationMillis),
        overlayEntry.remove,
      );
      Overlay.of(context).insert(overlayEntry);
    }
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

//
class _CupertinoSnackBar extends StatefulWidget {
  //
  const _CupertinoSnackBar({
    super.key,
    required this.message,
    required this.animationDurationMillis,
    required this.waitDurationMillis,
  });

  final String message;
  final int animationDurationMillis;
  final int waitDurationMillis;

  @override
  State<_CupertinoSnackBar> createState() => _CupertinoSnackBarState();
}

class _CupertinoSnackBarState extends State<_CupertinoSnackBar> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => setState(() => _show = true));
    Future.delayed(
      Duration(
        milliseconds: widget.waitDurationMillis,
      ),
      () {
        if (mounted) {
          setState(() => _show = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: _show ? 8.0 : -50.0,
      left: 8,
      right: 8,
      curve: _show ? Curves.linearToEaseOut : Curves.easeInToLinear,
      duration: Duration(milliseconds: widget.animationDurationMillis),
      child: CupertinoPopupSurface(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 14,
              // color: CupertinoColors.secondaryLabel,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
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
      _themeData =
          CupertinoBasedMaterialThemeData(themeData: value).materialTheme;
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
    final value = swatch?.toARGB32();

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

      color ??= Color(materialColor.toARGB32());

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

    final int red = color.intRed;
    final int green = color.intGreen;
    final int blue = color.intBlue;

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
    return MaterialColor(color.toARGB32(), shades);
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
