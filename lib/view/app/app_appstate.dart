// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  01 Apr 2023
//

import '/view.dart';

///
extension AppStateExtension on AppObject {
  // Use Material UI when explicitly specified or even when running in iOS
  /// Indicates if the App is running the Material interface theme.
  bool get useMaterial => appState?.useMaterial ?? UniversalPlatform.isAndroid;
  // {
  //   final _appState = appState;
  //   return (_appState != null && _appState.useMaterial) ||
  //       (UniversalPlatform.isAndroid &&
  //           (_appState == null || !_appState.switchUI)) ||
  //       (UniversalPlatform.isIOS && (_appState == null || _appState.switchUI));
  // }

  // Use Cupertino UI when explicitly specified or even when running in Android
  /// Indicates if the App is running the Cupertino interface theme.
  bool get useCupertino => appState?.useCupertino ?? UniversalPlatform.isIOS;
  // {
  //   final _appState = appState;
  //   return (_appState != null && _appState.useCupertino) ||
  //       (UniversalPlatform.isIOS &&
  //           (_appState == null || !_appState.switchUI)) ||
  //       (UniversalPlatform.isAndroid &&
  //           (_appState == null || _appState.switchUI));
  // }

  /// Return the navigator key used by the App's View.
  @Deprecated("Use 'App.appState?.scaffoldMessengerKey' instead.")
  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      appState?.scaffoldMessengerKey;

  /// Returns the routes used by the App's View.
  @Deprecated('Should not be an exposed property')
  Map<String, WidgetBuilder>? get routes => appState?.routes;

  /// Returns to the initial route used by the app.
  @Deprecated('Should not be an exposed property')
  String? get initialRoute => appState?.initialRoute;

  /// The route generator used when the app is navigated to a named route.
  @Deprecated('Should not be an exposed property')
  RouteFactory? get onGenerateRoute => appState?.onGenerateRoute;

  /// Called when [onGenerateRoute] fails except for the [initialRoute].
  @Deprecated('Should not be an exposed property')
  RouteFactory? get onUnknownRoute => appState?.onUnknownRoute;

  /// The list of observers for the [Navigator] for this app.
  @Deprecated('Should not be an exposed property')
  List<NavigatorObserver>? get navigatorObservers =>
      appState?.navigatorObservers;

  /// if neither [routes], or [onGenerateRoute] was passed.
  @Deprecated('Should not be an exposed property')
  TransitionBuilder? get builder => appState?.transitBuilder;

  /// Returns the title for the App's View.
  @Deprecated("Use 'App.appState?.title' instead")
  String get title => appState?.title ?? '';

  /// Routine used to generate the App's title.
  @Deprecated('Should not be an exposed property')
  GenerateAppTitle? get onGenerateTitle => appState?.onGenerateTitle;

  /// Returns the Color passed to the app.
  @Deprecated('Should not be an exposed property')
  Color? get color => appState?.color;

  /// Returns the device's possibly ever-changing Locale.
  /// Notice how the AppState's locale is always the determined locale.
  @Deprecated('Should not be an exposed property')
  Locale? get locale => appState?.locale;

  /// Set the App's Locale
  @Deprecated('Should not be a readily available capability')
  set locale(Locale? locale) {
    if (locale != null) {
      /// If 'supportedLocales' are specified, this Locale must be among them.
      appState?.locale = locale;
    }
  }

  /// Resolves the app's locale.
  @Deprecated('Should not be an exposed property')
  LocaleResolutionCallback? get localeResolutionCallback =>
      appState?.localeResolutionCallback;

  /// getter, supportedLocales, returns a List of the App's locales.
  // More flexible than an iteration.
  @Deprecated("Use 'App.appState?.supportedLocales' instead.")
  List<Locale>? get supportedLocales =>
      appState?.supportedLocales ?? L10n.supportedLocales;

  /// Explicitly change the app's locale.
  Future<bool> changeLocale(Locale? locale) async {
    bool change = locale != null;
    if (change) {
      change = await App.saveLocale(locale);
      if (change) {
        // Reflect the change by rebuilding the app.
        App.setState(() {});
      }
    }
    return change;
  }

  /// If true, it paints a grid overlay on Material apps.
  @Deprecated('Should not be an exposed property')
  bool? get debugShowMaterialGrid => appState?.debugShowMaterialGrid;
  @Deprecated('Should not be a readily available capability')
  set debugShowMaterialGrid(bool? v) {
    if (v != null) {
      appState?.debugShowMaterialGrid = v;
    }
  }

  /// If true, it turns on a performance overlay.
  @Deprecated('Should not be an exposed property')
  bool? get showPerformanceOverlay => appState?.showPerformanceOverlay;
  @Deprecated('Should not be a readily available capability')
  set showPerformanceOverlay(bool? v) {
    if (v != null) {
      appState?.showPerformanceOverlay = v;
    }
  }

  /// Checkerboard raster cache to speed up overall rendering.
  @Deprecated('Should not be an exposed property')
  bool? get checkerboardRasterCacheImages =>
      appState?.checkerboardRasterCacheImages;
  @Deprecated('Should not be a readily available capability')
  set checkerboardRasterCacheImages(bool? v) {
    if (v != null) {
      appState?.checkerboardRasterCacheImages = v;
    }
  }

  /// Checkerboard layers rendered offscreen bitmaps.
  @Deprecated('Should not be an exposed property')
  bool? get checkerboardOffscreenLayers =>
      appState?.checkerboardOffscreenLayers;
  @Deprecated('Should not be a readily available capability')
  set checkerboardOffscreenLayers(bool? v) {
    if (v != null) {
      appState?.checkerboardOffscreenLayers = v;
    }
  }

  /// Shows an overlay of accessibility information
  @Deprecated('Should not be an exposed property')
  bool? get showSemanticsDebugger => appState?.showSemanticsDebugger;
  @Deprecated('Should not be a readily available capability')
  set showSemanticsDebugger(bool? v) {
    if (v != null) {
      appState?.showSemanticsDebugger = v;
    }
  }

  /// Shows a little "DEBUG" banner in checked mode.
  @Deprecated('Should not be an exposed property')
  bool? get debugShowCheckedModeBanner => appState?.debugShowCheckedModeBanner;
  @Deprecated('Should not be a readily available capability')
  set debugShowCheckedModeBanner(bool? v) {
    if (v != null) {
      appState?.debugShowCheckedModeBanner = v;
    }
  }

  /// Each RenderBox to paint a box around its bounds.
  @Deprecated('Should not be an exposed property')
  bool? get debugPaintSizeEnabled => appState?.debugPaintSizeEnabled;
  // Note, won't function in release mode.
  set debugPaintSizeEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintSizeEnabled = v;
    }
  }

  /// RenderBox paints a line at its baselines.
  @Deprecated('Should not be an exposed property')
  bool? get debugPaintBaselinesEnabled => appState?.debugPaintBaselinesEnabled;
  // Note, won't function in release mode.
  set debugPaintBaselinesEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintBaselinesEnabled = v;
    }
  }

  /// Objects flash while they are being tapped.
  @Deprecated('Should not be an exposed property')
  bool? get debugPaintPointersEnabled => appState?.debugPaintPointersEnabled;
  // Note, won't function in release mode.
  set debugPaintPointersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintPointersEnabled = v;
    }
  }

  /// Layer paints a box around its bound.
  @Deprecated('Should not be an exposed property')
  bool? get debugPaintLayerBordersEnabled =>
      appState?.debugPaintLayerBordersEnabled;
  // Note, won't function in release mode.
  set debugPaintLayerBordersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintLayerBordersEnabled = v;
    }
  }

  /// Overlay a rotating set of colors when repainting layers in checked mode.
  @Deprecated('Should not be an exposed property')
  bool? get debugRepaintRainbowEnabled => appState?.debugRepaintRainbowEnabled;
  // Note, won't function in release mode.
  set debugRepaintRainbowEnabled(bool? v) {
    if (v != null) {
      appState?.debugRepaintRainbowEnabled = v;
    }
  }

  /// Determines if running in an IDE or in production.
  bool get inDebugMode => appState?.inDebugMode ?? false;

  /// Explicitly change to a particular interface.
  void changeUI(String ui) {
    appState?.changeUI(ui);
  }

  /// Allow the app to change the theme
  @Deprecated("Use 'App.appState?.allowChangeTheme' instead.")
  bool get allowChangeTheme => appState?.allowChangeTheme ?? false;

  /// Allow the app directly change the Locale
  @Deprecated("Use 'App.appState?.allowChangeLocale' instead.")
  bool get allowChangeLocale => appState?.allowChangeLocale ?? false;

  /// Allow the app to directly change the UI design
  @Deprecated("Use 'App.appState?.allowChangeUI' instead.")
  bool get allowChangeUI => appState?.allowChangeUI ?? false;

  /// Use Cupertino UI in Android and vice versa.
  @Deprecated("Use 'App.appState?.switchUI' instead.")
  bool get switchUI => appState?.switchUI ?? false;

  /// Refresh the root State object with the passed function.
  void setState(VoidCallback fn) => appState?.setState(fn);

  /// Refresh the 'current/latest' State object and 'root/first' State object.
  void refresh() => appState?.refresh();

  /// Link a widget to a InheritedWidget in the root State object.
  void dependOnInheritedWidget(BuildContext? context) =>
      appState?.dependOnInheritedWidget(context);

  /// Rebuild dependencies to the root State object's InheritedWidget
  void notifyClients() => appState?.notifyClients();

  /// Catch and explicitly handle the error.
  void catchError(
    Object? ex, {
    StackTrace? stack,
    String? library,
    DiagnosticsNode? context,
    IterableFilter<String>? stackFilter,
    InformationCollector? informationCollector,
    bool? silent,
  }) {
    if (ex is! Exception) {
      ex = Exception(ex.toString());
    }

    appState?.catchError(
      ex,
      stack: stack,
      // Supply the app's name instead.
      library: library ?? App.packageInfo?.appName,
      context: context,
      stackFilter: stackFilter,
      informationCollector: informationCollector,
      silent: silent ?? false,
    );
  }

  /// Retrieve the 'latest' context
  BuildContext? get context => appState?.lastContext;
}
