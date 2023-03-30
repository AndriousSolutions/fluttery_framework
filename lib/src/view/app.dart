/// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  09 Feb 2019
///
///

import 'dart:async' show Future, StreamSubscription;

import 'dart:ui' as ui show SingletonFlutterWindow;

import 'package:universal_io/io.dart' show Platform;

// Replace 'dart:io' for Web applications
import 'package:universal_platform/universal_platform.dart'
    show UniversalPlatform;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler, kIsWeb;

import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;

import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import 'package:fluttery_framework/model.dart';

import 'package:fluttery_framework/view.dart' as v;

import 'package:fluttery_framework/controller.dart' show DeviceInfo;

/// This class is available throughout the app
/// Readily supplies static properties about the App.
class App with ConnectivityListener {
  /// Supply an error handler to the App.
  // The parameters are deprecated.
  factory App({
    // ignore: avoid_unused_constructor_parameters
    FlutterExceptionHandler? errorHandler,
    // ignore: avoid_unused_constructor_parameters
    ErrorWidgetBuilder? errorScreen,
    // ignore: avoid_unused_constructor_parameters
    v.ReportErrorHandler? errorReport,
    bool? allowNewHandlers = true,
  }) =>
      _this ??= App._(allowNewHandlers ?? true);

  App._(
    bool allowNewHandlers,
  ) {
    // Initialize the Error Handler
    _errorHandler = v.AppErrorHandler(newErrorHandlers: allowNewHandlers);
    // Monitor the device's connectivity to the Internet.
    addConnectivityListener(this);
  }
  static App? _this;

  /// Indicating app is running in the Flutter engine and not in
  /// the `flutter_test` framework with TestWidgetsFlutterBinding for example
  static bool get inWidgetsFlutterBinding => _inWidgetsFlutterBinding ??=
      WidgetsBinding.instance is WidgetsFlutterBinding;
  static bool? _inWidgetsFlutterBinding;

  /// Indicate if running under a 'Flutter Test' environment
  static bool get inFlutterTest =>
      _inFlutterTest ??= Platform.environment.containsKey('FLUTTER_TEST');
  static bool? _inFlutterTest;

  /// Returns the current Error Handler.
  static v.AppErrorHandler? get errorHandler => _errorHandler;
  static v.AppErrorHandler? _errorHandler;

  /// Dispose the App properties.
  void dispose() {
    _menu = null;
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _packageInfo = null;
    _themeData = null;
//    _appWidget = null;
    _appState = null;
    // Restore the original error handling.
    _errorHandler!.dispose();
    _errorHandler = null;
  }

  /// Assign the class with the AppState object.
  bool setAppState(v.AppState? state) {
    // Don't continue if an app called an app.
    final set = state != null && (_appState == null || hotReload);
    if (set) {
      //
      _appState = state;
      // Assign the 'app' object to the app's view
      state.app = this;
    }
    return set;
  }

  /// The App State object.
  static v.AppState? get state => _appState;
  // todo: Change to 'late' instead and redo every reference.
  static v.AppState? _appState;

  /// App-level error handling.
  static void onError(FlutterErrorDetails details) {
    // Call the App's 'current' error handler.
    final handler = errorHandler?.flutterExceptionHandler;
    if (handler != null) {
      handler(details);
    } else {
      // Call Flutter's default error handler.
      FlutterError.presentError(details);
    }
  }

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
  static Future<void> getDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    // There's 'no device' while testing and so don't collect device info.
    if (!inFlutterTest) {
      // Collect Device Information
      await DeviceInfo.initAsync();
    }
  }

  /// Passed to the CupertinoApp or MaterialApp
  @Deprecated('Prone to misuse. Can not be used more than once.')
  static final widgetsAppKey = GlobalKey(debugLabel: 'mvc_app');

  /// Determine if the App initialized successfully.
  // ignore: unnecessary_getters_setters
  static bool? get isInit => _isInit;

  /// Set the init only once.
  // ignore: unnecessary_getters_setters
  static set isInit(bool? init) => _isInit ??= init;
  static bool? _isInit;

  /// Flag to set hot reload from now on.
  // ignore: unnecessary_getters_setters
  static bool get hotReload => _hotReload;

  /// Once set, it will always hot reload.
  // ignore: unnecessary_getters_setters
  static set hotReload(bool hotReload) {
    // It doesn't accept false.
    // i.e. Once true, it stays true.
    if (!hotReload) {
      return;
    }
    _hotReload = hotReload;
  }

  static bool _hotReload = false;

  // Use Material UI when explicitly specified or even when running in iOS
  /// Indicates if the App is running the Material interface theme.
  static bool get useMaterial =>
      (_appState != null && _appState!.useMaterial!) ||
      (UniversalPlatform.isAndroid &&
          (_appState == null || !_appState!.switchUI!)) ||
      (UniversalPlatform.isIOS && (_appState == null || _appState!.switchUI!));

  // Use Cupertino UI when explicitly specified or even when running in Android
  /// Indicates if the App is running the Cupertino interface theme.
  static bool get useCupertino =>
      (_appState != null && _appState!.useCupertino!) ||
      (UniversalPlatform.isIOS &&
          (_appState == null || !_appState!.switchUI!)) ||
      (UniversalPlatform.isAndroid &&
          (_appState == null || _appState!.switchUI!));

  /// Explicitly change to a particular interface.
  static void changeUI(String ui) => _appState?.changeUI(ui);

  /// Flutter application's main window.
  static ui.SingletonFlutterWindow get mainWindow =>
      _window ??= WidgetsBinding.instance.window;
  static ui.SingletonFlutterWindow? _window;

  /// Return the navigator key used by the App's View.
  static GlobalKey<NavigatorState>? get navigatorKey => _appState?.navigatorKey;
  static set navigatorKey(GlobalKey<NavigatorState>? v) {
    if (v != null) {
      _appState?.navigatorKey = v;
    }
  }

  /// Return the navigator key used by the App's View.
  static GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      _appState?.scaffoldMessengerKey;
  static set scaffoldMessengerKey(GlobalKey<ScaffoldMessengerState>? v) {
    if (v != null) {
      _appState?.scaffoldMessengerKey = v;
    }
  }

  /// Returns the routes used by the App's View.
  static Map<String, WidgetBuilder>? get routes => _appState?.routes;
  static set routes(Map<String, WidgetBuilder>? v) {
    if (v != null) {
      _appState?.routes = v;
    }
  }

  /// Returns to the initial route used by the App's View.
  static String? get initialRoute => _appState?.initialRoute;
  static set initialRoute(String? v) {
    if (v != null) {
      _appState?.initialRoute = v;
    }
  }

  /// The route generator used when the app is navigated to a named route.
  static RouteFactory? get onGenerateRoute => _appState?.onGenerateRoute;
  static set onGenerateRoute(RouteFactory? v) {
    if (v != null) {
      _appState?.onGenerateRoute = v;
    }
  }

  /// Called when [onGenerateRoute] fails except for the [initialRoute].
  static RouteFactory? get onUnknownRoute => _appState?.onUnknownRoute;
  static set onUnknownRoute(RouteFactory? v) {
    if (v != null) {
      _appState?.onUnknownRoute = v;
    }
  }

  /// The list of observers for the [Navigator] for this app.
  static List<NavigatorObserver>? get navigatorObservers =>
      _appState?.navigatorObservers;
  static set navigatorObservers(List<NavigatorObserver>? v) {
    if (v != null) {
      _appState?.navigatorObservers = v;
    }
  }

  /// if neither [routes], or [onGenerateRoute] was passed.
  static TransitionBuilder? get builder => _appState?.builder;
  static set builder(TransitionBuilder? v) {
    if (v != null) {
      _appState?.builder = v;
    }
  }

  /// Returns the title for the App's View.
  static String? get title => _appState?.title;
  static set title(String? v) {
    if (v != null) {
      _appState?.title = v;
    }
  }

  /// Routine used to generate the App's title.
  static GenerateAppTitle? get onGenerateTitle => _appState?.onGenerateTitle;
  static set onGenerateTitle(GenerateAppTitle? v) {
    if (v != null) {
      _appState?.onGenerateTitle = v;
    }
  }

  /// A mutable menu
  static v.AppMenu<String> get menu => _menu ??= v.AppMenu(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        position: PopupMenuPosition.under,
      );
  static v.AppMenu<String>? _menu;

  // Allow it to be assigned null.
  /// The App's current Material theme.
  static ThemeData? get themeData => _themeData;

  static set themeData(dynamic value) {
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

  static ThemeData? _themeData;

  /// The Apps's current Cupertino theme.
  static CupertinoThemeData? get iOSTheme => _iOSTheme;
  static CupertinoThemeData? _iOSTheme;
  static set iOSTheme(dynamic value) {
    if (value == null) {
      return;
    }
    if (value is CupertinoThemeData) {
      _iOSTheme = value;
    } else if (value is ThemeData) {
      _iOSTheme = MaterialBasedCupertinoThemeData(materialTheme: value);
    } else if (value is! Color) {
      // Ignore the value
    } else if (_iOSTheme == null) {
      _iOSTheme = CupertinoThemeData(
        primaryColor: value,
      );
    } else {
      _iOSTheme = _iOSTheme?.copyWith(
        primaryColor: value,
      );
    }
  }

  // /// Set the App's general color theme supplying a [ColorSwatch] value.
  // static ColorSwatch<int?>? setThemeData([ColorSwatch<int?>? swatch]) {
  //   //
  //   if (!Prefs.ready()) {
  //     return swatch;
  //   }
  //
  //   if (swatch != null) {
  //     Prefs.setInt(
  //       'colorTheme',
  //       Colors.primaries.indexOf(swatch as MaterialColor),
  //     );
  //   } else {
  //     final index = Prefs.getInt('colorTheme', -1);
  //     // If never set in the first place, ignore
  //     if (index > -1) {
  //       swatch = Colors.primaries[index];
  //     }
  //   }
  //
  //   if (swatch != null) {
  //     /// Assign the colour to the floating button as well.
  //     themeData = ThemeData(
  //       primarySwatch: swatch as MaterialColor,
  //       floatingActionButtonTheme: FloatingActionButtonThemeData(
  //         backgroundColor: swatch,
  //       ),
  //     );
  //     iOSTheme = swatch;
  //   }
  //   return swatch;
  // }

  /// Set the App's general color theme supplying a [Color] value.
  static Color? setThemeData({
    ColorSwatch<int?>? swatch,
    Color? color,
  }) {
    //
    int? value = color?.value ?? swatch?.value;

    if (!Prefs.ready()) {
      return value == null ? null : Color(value);
    }

    if (value != null) {
      Prefs.setInt('primaryColor', value);
      color = Color(value);
    } else {
      value = Prefs.getInt('primaryColor', -1);
      // If never set in the first place, ignore
      if (value > -1) {
        color = Color(value);
      } else {
        color = Colors.blue;
        Prefs.setInt('primaryColor', color.value);
      }
    }

    MaterialColor? materialColor;

    if (swatch == null) {
      materialColor = _materialColor(color);
    } else {
      materialColor = swatch as MaterialColor;
    }

    final index = Colors.primaries.indexOf(materialColor!);

    if (index > -1) {
      materialColor = Colors.primaries[index];
    }

    /// Assign the colour to the floating button as well.
    themeData = ThemeData(
      primarySwatch: materialColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color,
      ),
    );
    iOSTheme = color;
    return color;
  }

  // /// Return the Color Swatch stored with Preferences.
  // static Color? preferredTheme({
  //   ColorSwatch<int>? swatch,
  //   Color? color,
  //   bool? overWrite,
  // }) {
  //   //
  //   final int? value = color?.value ?? swatch?.value;
  //
  //   if (color != null) {
  //     final m1 = _materialColor(color);
  //
  //     final m2 = getMaterialColor(color);
  //   }
  //
  //   if (Prefs.ready()) {
  //     final primaryColor = Prefs.getInt('primaryColor', -1);
  //     // A value was pasted
  //     if (value != null) {
  //       // Default is to overwrite
  //       overWrite ??= true;
  //       // If not set yet or overwrite anyway.
  //       if (primaryColor == -1 || overWrite) {
  //         Prefs.setInt(
  //           'primaryColor',
  //           value,
  //         );
  //       }
  //     } else {
  //       // If never set in the first place, ignore
  //       if (primaryColor > -1) {
  //         color = Color(primaryColor);
  //       } else {
  //         color = null;
  //       }
  //     }
  //   }
  //   return color;
  // }

  ///
  static MaterialColor? _materialColor(Color? color) {
    //
    if (color == null) {
      return null;
    }
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(double.parse((0.1 * i).toStringAsFixed(2)));
    }
    int cnt = 0;
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      cnt = cnt + 1;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        0.1 * cnt,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  ///
  static MaterialColor getMaterialColor(Color color) {
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

  /// Returns the Color passed to the App's View.
  static Color? get color => _appState?.color;
  static set color(Color? v) {
    if (v != null) {
      _appState?.color = v;
    }
  }

  /// Returns the device's every changing Locale.
  static Locale? get locale =>
      _appState?.locale = Localizations.maybeLocaleOf(context!) ??
          _resolveLocales(
            mainWindow.locales,
            _appState?.supportedLocales,
          );

  /// Set the App's Locale
  /// If 'supportedLocales' are specified, this Locale must be among them.
  static set locale(Locale? locale) {
    if (locale != null) {
      v.L10n.locale = locale;
      if (v.L10n.locale != v.L10n.prevLocale) {
        _appState?.locale = locale;
      }
    }
  }

  /// Determine the locale used by the Mobile phone.
  static Locale? _resolveLocales(
    List<Locale>? preferredLocales,
    Iterable<Locale>? supportedLocales,
  ) {
    // Attempt to use localeListResolutionCallback.
    if (_appState?.localeListResolutionCallback != null) {
      final locales = _appState?.supportedLocales;
      Locale? locale;
      if (locales != null) {
        locale =
            _appState?.localeListResolutionCallback!(preferredLocales, locales);
      }
      if (locale != null) {
        return locale;
      }
    }

    final preferred = preferredLocales != null && preferredLocales.isNotEmpty
        ? preferredLocales.first
        : null;

    // localeListResolutionCallback failed, falling back to localeResolutionCallback.
    if (_appState?.localeResolutionCallback != null) {
      final locales = _appState?.supportedLocales;
      Locale? locale;
      if (locales != null) {
        locale = _appState?.localeResolutionCallback!(preferred, locales);
      }
      if (locale != null) {
        return locale;
      }
    }
    // Both callbacks failed, falling back to default algorithm.
//    return basicLocaleListResolution(preferredLocales, supportedLocales);
    return preferred;
  }

  /// Returns the App's current localizations delegates.
  static Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      _appState?.localizationsDelegates;
  static set localizationsDelegates(
      Iterable<LocalizationsDelegate<dynamic>>? v) {
    if (v != null) {
      _appState?.localizationsDelegates = v;
    }
  }

  /// Resolves the App's locale.
  static LocaleResolutionCallback? get localeResolutionCallback =>
      _appState?.localeResolutionCallback;
  static set localeResolutionCallback(LocaleResolutionCallback? v) {
    if (v != null) {
      _appState?.localeResolutionCallback = v;
    }
  }

  /// getter, supportedLocales, returns a List of the App's locales.
  /// More flexible than an iteration.
  static List<Locale>? get supportedLocales =>
      _appState?.supportedLocales ??= v.L10n.supportedLocales;
  static set supportedLocales(List<Locale>? locales) {
    if (locales != null) {
      if (v.L10n.supportedLocales.isEmpty) {
        v.L10n.supportedLocales = _appState?.supportedLocales ??= locales;
      } else {
        final appLocales = _appState?.supportedLocales ?? [];
        if (appLocales.isEmpty) {
          // Note v.L10n.supportedLocales precedes locales
          _appState?.supportedLocales?.addAll(v.L10n.supportedLocales);
        }
      }
    }
  }

  /// If true, it paints a grid overlay on Material apps.
  static bool? get debugShowMaterialGrid => _appState?.debugShowMaterialGrid;
  static set debugShowMaterialGrid(bool? v) {
    if (v != null) {
      _appState?.debugShowMaterialGrid = v;
    }
  }

  /// If true, it turns on a performance overlay.
  static bool? get showPerformanceOverlay => _appState?.showPerformanceOverlay;
  static set showPerformanceOverlay(bool? v) {
    if (v != null) {
      _appState?.showPerformanceOverlay = v;
    }
  }

  /// Checkerboard raster cache to speed up overall rendering.
  static bool? get checkerboardRasterCacheImages =>
      _appState?.checkerboardRasterCacheImages;
  static set checkerboardRasterCacheImages(bool? v) {
    if (v != null) {
      _appState?.checkerboardRasterCacheImages = v;
    }
  }

  /// Checkerboard layers rendered offscreen bitmaps.
  static bool? get checkerboardOffscreenLayers =>
      _appState?.checkerboardOffscreenLayers;
  static set checkerboardOffscreenLayers(bool? v) {
    if (v != null) {
      _appState?.checkerboardOffscreenLayers = v;
    }
  }

  /// Shows an overlay of accessibility information
  static bool? get showSemanticsDebugger => _appState?.showSemanticsDebugger;
  static set showSemanticsDebugger(bool? v) {
    if (v != null) {
      _appState?.showSemanticsDebugger = v;
    }
  }

  /// Shows a little "DEBUG" banner in checked mode.
  static bool? get debugShowCheckedModeBanner =>
      _appState?.debugShowCheckedModeBanner;
  static set debugShowCheckedModeBanner(bool? v) {
    if (v != null) {
      _appState?.debugShowCheckedModeBanner = v;
    }
  }

  /// Each RenderBox to paint a box around its bounds.
  static bool? get debugPaintSizeEnabled => _appState?.debugPaintSizeEnabled;
  static set debugPaintSizeEnabled(bool? v) {
    if (v != null) {
      _appState?.debugPaintSizeEnabled = v;
    }
  }

  /// RenderBox paints a line at its baselines.
  static bool? get debugPaintBaselinesEnabled =>
      _appState?.debugPaintBaselinesEnabled;
  static set debugPaintBaselinesEnabled(bool? v) {
    if (v != null) {
      _appState?.debugPaintBaselinesEnabled = v;
    }
  }

  /// Objects flash while they are being tapped.
  static bool? get debugPaintPointersEnabled =>
      _appState?.debugPaintPointersEnabled;
  static set debugPaintPointersEnabled(bool? v) {
    if (v != null) {
      _appState?.debugPaintPointersEnabled = v;
    }
  }

  /// Layer paints a box around its bound.
  static bool? get debugPaintLayerBordersEnabled =>
      _appState?.debugPaintLayerBordersEnabled;
  static set debugPaintLayerBordersEnabled(bool? v) {
    if (v != null) {
      _appState?.debugPaintLayerBordersEnabled = v;
    }
  }

  /// Overlay a rotating set of colors when repainting layers in checked mode.
  static bool? get debugRepaintRainbowEnabled =>
      _appState?.debugRepaintRainbowEnabled;
  static set debugRepaintRainbowEnabled(bool? v) {
    if (v != null) {
      _appState?.debugRepaintRainbowEnabled = v;
    }
  }

  /// The running platform
  static TargetPlatform? get platform {
    if (_platform == null && context != null) {
      _platform = Theme.of(context!).platform;
    }
    return _platform;
  }

  static TargetPlatform? _platform;

  // Application information
  static PackageInfo? _packageInfo;

  /// The package info.
  static PackageInfo? get packageInfo => _packageInfo;

  /// The Name of the App.
  static String? get appName => _packageInfo?.appName;

  /// The 'Package Name' of the App.
  static String? get packageName => _packageInfo?.packageName;

  /// The current version of the App.
  static String? get version => _packageInfo?.version;

  /// The build number of the App.
  static String? get buildNumber => _packageInfo?.buildNumber;

  /// Determines if running in an IDE or in production.
  static bool get inDebugMode => _appState?.inDebugMode ?? false;

  ///
  @Deprecated('Use inDebugMode instead.')
  static bool get inDebugger => inDebugMode;

  /// Refresh the root State object with the passed function.
  static void setState(VoidCallback fn) => _appState?.setState(fn);

  /// Refresh the 'current/latest' State object and 'root/first' State object.
  static void refresh() => _appState?.refresh();

  /// Link a widget to a InheritedWidget in the root State object.
  static void dependOnInheritedWidget(BuildContext? context) =>
      _appState?.dependOnInheritedWidget(context);

  /// Rebuild dependencies to the root State object's InheritedWidget
  @Deprecated('Replace by the recognized notifyClients()')
  static void buildInherited() => _appState?.notifyClients();

  /// same as above. Rebuild dependencies to the root State object's InheritedWidget
  static void notifyClients() => _appState?.notifyClients();

  /// Display the SnackBar
  static void snackBar({
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
    final state = ScaffoldMessenger.maybeOf(context!);
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

  /// Catch and explicitly handle the error.
  static void catchError(Object ex) {
    if (ex is! Exception) {
      ex = Exception(ex.toString());
    }
    _appState?.catchError(ex);
  }

  /// Retrieve the 'lastest' context
  static BuildContext? get context => _appState?.lastContext;

  /// The Scaffold object for this App's View.
  static ScaffoldState? get scaffold => Scaffold.maybeOf(context!);

  /// The Physical width of the screen
  static double get screenPhysicalWidth {
    final media = MediaQuery.of(context!);
    return media.size.width * media.devicePixelRatio;
  }

  /// The logical width of the screen
  static double get screenWidth => MediaQuery.of(context!).size.width;

  /// The Physical height of the screen
  static double get screenPhysicalHeight => MediaQuery.of(context!).size.height;

  /// The Logical height of the screen
  static double get screenHeight {
    final media = MediaQuery.of(context!);
    return media.size.height -
        media.padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;
  }

  // /// Current Screen Size
  // static Size get screenSize {
  //   Size? size;
  //   final _context = context;
  //   if (_context == null) {
  //     size = MediaQueryData.fromWindow(mainWindow).size;
  //   } else {
  //     size = MediaQuery.of(_context).size;
  //   }
  //   return size;
  // }

  /// Current Screen Size
  static Size get screenSize => MediaQueryData.fromWindow(mainWindow).size;

  /// Set whether the app is to use a 'small screen' or not.
  static bool get asSmallScreen => App.inDebugMode && false;

  /// Return the bool value indicating if running in a small screen or not.
  static bool get inSmallScreen {
    bool smallScreen;

    // May be manually assigned.
    smallScreen = asSmallScreen;

    if (!smallScreen) {
      smallScreen = screenSize.width < 800;
    }
    return smallScreen;
  }

  /// The local directory for this App.
  static String? get filesDir => _path;
  static String? _path;

  /// Determine the connectivity.
  static final _connectivity = Connectivity();

  static StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  /// Returns the connection status of the device.
  static String? get connectivity => _connectivityStatus;
  static String? _connectivityStatus;

  /// Indicates if the app has access to the Internet.
  /// Assume we're online if null
  static bool get isOnline =>
      _connectivityStatus == null || !_connectivityStatus!.contains('none');

  /// Was off but now turned on connectivity
  static bool get turnedOnInternet => _turnedOnInternet;
  static bool _turnedOnInternet = true;
  bool _wasOffline = false;

  /// Was on but now turned off connectivity
  static bool get turnedOffInternet => _turnedOffInternet;
  static bool _turnedOffInternet = false;

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
  static final Set<ConnectivityListener> _listeners = {};

  /// Add a Connectivity listener.
  static bool addConnectivityListener(ConnectivityListener? listener) {
    var add = false;
    if (listener != null) {
      add = _listeners.add(listener);
    }
    return add;
  }

  /// Remove a Connectivity listener.
  static bool removeConnectivityListener(ConnectivityListener? listener) {
    var remove = false;
    if (listener != null) {
      remove = _listeners.remove(listener);
    }
    return remove;
  }

  // /// Clear Connectivity listeners.
  // static void clearConnectivityListener() => _listeners.clear();

  /// The id for this App's particular installation.
  static Future<String?> getInstallNum() => InstallFile.id();

  /// The id for this App's particular installation.
  static String? get installNum => _installNum;
  static String? _installNum;

  /// Internal Initialization routines.
  Future<void> initInternal() async {
    //
    _connectivitySubscription ??=
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      for (final listener in _listeners) {
        listener.onConnectivityChanged(result);
      }
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
    _path ??= await Files.localPath;
  }

  static Future<String> _initConnectivity() async {
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

/// A Listener for the device's own connectivity status at any point in time.
mixin ConnectivityListener {
  /// A listener method to respond if the device's connectivity changes.
  void onConnectivityChanged(ConnectivityResult result);
}

// /// Supply an MVC State object that hooks into the App class.
// abstract class StateC<T extends StatefulWidget> extends s.StateC<T>
//     with HandleError {
//   /// Optionally supply a State Controller to be linked to this 'State' object.
//   StateC([StateController? controller]) : super(controller);
//
//   @override
//   void refresh() {
//     // Critical to have the App 'refresh' first.
//     // It uses a built-in InheritedWidget.
//     App.refresh();
//     if (mounted) {
//       // Next refresh the current State object itself.
//       super.refresh();
//     }
//   }
// }

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
