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
  bool get useMaterial {
    final _appState = appState;
    return (_appState != null && _appState.useMaterial) ||
        (UniversalPlatform.isAndroid &&
            (_appState == null || !_appState.switchUI)) ||
        (UniversalPlatform.isIOS && (_appState == null || _appState.switchUI));
  }

  // Use Cupertino UI when explicitly specified or even when running in Android
  /// Indicates if the App is running the Cupertino interface theme.
  bool get useCupertino {
    final _appState = appState;
    return (_appState != null && _appState.useCupertino) ||
        (UniversalPlatform.isIOS &&
            (_appState == null || !_appState.switchUI)) ||
        (UniversalPlatform.isAndroid &&
            (_appState == null || _appState.switchUI));
  }

  /// Return the navigator key used by the App's View.
  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      appState?.scaffoldMessengerKey;

  /// Returns the routes used by the App's View.
  Map<String, WidgetBuilder>? get routes => appState?.routes;

  /// Returns to the initial route used by the app.
  String? get initialRoute => appState?.initialRoute;

  /// The route generator used when the app is navigated to a named route.
  RouteFactory? get onGenerateRoute => appState?.onGenerateRoute;

  /// Called when [onGenerateRoute] fails except for the [initialRoute].
  RouteFactory? get onUnknownRoute => appState?.onUnknownRoute;

  /// The list of observers for the [Navigator] for this app.
  List<NavigatorObserver>? get navigatorObservers =>
      appState?.navigatorObservers;

  /// if neither [routes], or [onGenerateRoute] was passed.
  TransitionBuilder? get builder => appState?.transitBuilder;

  /// Returns the title for the App's View.
  String get title => appState?.title ?? '';

  /// Routine used to generate the App's title.
  GenerateAppTitle? get onGenerateTitle => appState?.onGenerateTitle;

  /// Returns the Color passed to the app.
  Color? get color => appState?.color;

  /// Returns the device's possibly ever-changing Locale.
  /// Notice how the AppState's locale is always the determined locale.
  Locale? get locale =>
      appState?.locale ??
      Localizations.maybeLocaleOf(context!) ??
      _resolveLocales(
        // The full system-reported supported locales of the device.
        WidgetsBinding.instance.platformDispatcher.locales,
        appState?.supportedLocales,
      );

  /// Set the App's Locale
  set locale(Locale? locale) {
    if (locale != null) {
      /// If 'supportedLocales' are specified, this Locale must be among them.
      appState?.locale = locale;
    }
  }

  /// Returns the App's current localizations delegates.
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      appState?.localizationsDelegates;

  /// Resolves the app's locale.
  LocaleResolutionCallback? get localeResolutionCallback =>
      appState?.localeResolutionCallback;

  /// getter, supportedLocales, returns a List of the App's locales.
  // More flexible than an iteration.
  List<Locale>? get supportedLocales =>
      appState?.supportedLocales ?? L10n.supportedLocales;

  /// Determine the locale used by the Mobile phone.
  Locale? _resolveLocales(
    List<Locale>? preferredLocales,
    Iterable<Locale>? supportedLocales,
  ) {
    //
    final locales = appState?.supportedLocales;

    // Attempt to use localeListResolutionCallback.
    if (appState?.localeListResolutionCallback != null) {
      Locale? locale;
      if (locales != null) {
        locale =
            appState?.localeListResolutionCallback!(preferredLocales, locales);
      }
      if (locale != null) {
        return locale;
      }
    }

    final preferred = preferredLocales != null && preferredLocales.isNotEmpty
        ? preferredLocales.first
        : null;

    // localeListResolutionCallback failed, falling back to localeResolutionCallback.
    if (appState?.localeResolutionCallback != null) {
      Locale? locale;
      if (locales != null) {
        locale = appState?.localeResolutionCallback!(preferred, locales);
      }
      if (locale != null) {
        return locale;
      }
    }
    return preferred;
  }

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
  bool? get debugShowMaterialGrid => appState?.debugShowMaterialGrid;
  // Note, won't function in release mode.
  set debugShowMaterialGrid(bool? v) {
    if (v != null) {
      appState?.debugShowMaterialGrid = v;
    }
  }

  /// If true, it turns on a performance overlay.
  bool? get showPerformanceOverlay => appState?.showPerformanceOverlay;
  // Note, won't function in release mode.
  set showPerformanceOverlay(bool? v) {
    if (v != null) {
      appState?.showPerformanceOverlay = v;
    }
  }

  /// Checkerboard raster cache to speed up overall rendering.
  bool? get checkerboardRasterCacheImages =>
      appState?.checkerboardRasterCacheImages;
  // Note, won't function in release mode.
  set checkerboardRasterCacheImages(bool? v) {
    if (v != null) {
      appState?.checkerboardRasterCacheImages = v;
    }
  }

  /// Checkerboard layers rendered offscreen bitmaps.
  bool? get checkerboardOffscreenLayers =>
      appState?.checkerboardOffscreenLayers;
  // Note, won't function in release mode.
  set checkerboardOffscreenLayers(bool? v) {
    if (v != null) {
      appState?.checkerboardOffscreenLayers = v;
    }
  }

  /// Shows an overlay of accessibility information
  bool? get showSemanticsDebugger => appState?.showSemanticsDebugger;
  // Note, won't function in release mode.
  set showSemanticsDebugger(bool? v) {
    if (v != null) {
      appState?.showSemanticsDebugger = v;
    }
  }

  /// Shows a little "DEBUG" banner in checked mode.
  bool? get debugShowCheckedModeBanner => appState?.debugShowCheckedModeBanner;
  // Note, won't function in release mode.
  set debugShowCheckedModeBanner(bool? v) {
    if (v != null) {
      appState?.debugShowCheckedModeBanner = v;
    }
  }

  /// Each RenderBox to paint a box around its bounds.
  bool? get debugPaintSizeEnabled => appState?.debugPaintSizeEnabled;
  // Note, won't function in release mode.
  set debugPaintSizeEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintSizeEnabled = v;
    }
  }

  /// RenderBox paints a line at its baselines.
  bool? get debugPaintBaselinesEnabled => appState?.debugPaintBaselinesEnabled;
  // Note, won't function in release mode.
  set debugPaintBaselinesEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintBaselinesEnabled = v;
    }
  }

  /// Objects flash while they are being tapped.
  bool? get debugPaintPointersEnabled => appState?.debugPaintPointersEnabled;
  // Note, won't function in release mode.
  set debugPaintPointersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintPointersEnabled = v;
    }
  }

  /// Layer paints a box around its bound.
  bool? get debugPaintLayerBordersEnabled =>
      appState?.debugPaintLayerBordersEnabled;
  // Note, won't function in release mode.
  set debugPaintLayerBordersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintLayerBordersEnabled = v;
    }
  }

  /// Overlay a rotating set of colors when repainting layers in checked mode.
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
  bool get allowChangeTheme => appState?.allowChangeTheme ?? false;

  /// Allow the app directly change the Locale
  bool get allowChangeLocale => appState?.allowChangeLocale ?? false;

  /// Allow the app to directly change the UI design
  bool get allowChangeUI => appState?.allowChangeUI ?? false;

  /// Use Cupertino UI in Android and vice versa.
  bool get switchUI => appState?.switchUI ?? false;

  /// Refresh the root State object with the passed function.
  void setState(VoidCallback fn) => appState?.setState(fn);

  /// Refresh the 'current/latest' State object and 'root/first' State object.
  void refresh() => appState?.refresh();

  /// Link a widget to a InheritedWidget in the root State object.
  void dependOnInheritedWidget(BuildContext? context) =>
      appState?.dependOnInheritedWidget(context);

  /// Rebuild dependencies to the root State object's InheritedWidget
  @Deprecated('Replace by the recognized notifyClients()')
  void buildInherited() => appState?.notifyClients();

  /// same as above. Rebuild dependencies to the root State object's InheritedWidget
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
