/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  01 Apr 2023
///

import 'package:fluttery_framework/view.dart';

///
extension AppStateExtension on AppObject {
  // /// Assign the class with the AppState object.
  // bool setAppState(AppState? state) {
  //   // Don't continue if an app called an app.
  //   final set = state != null && (appState == null || hotReload);
  //   if (set) {
  //     //
  //     appState = state;
  //     // Assign the 'app' object to the app's view
  //     state.app = this;
  //   }
  //   return set;
  // }

  // Use Material UI when explicitly specified or even when running in iOS
  /// Indicates if the App is running the Material interface theme.
  bool get useMaterial {
    final _appState = appState;
    return (_appState != null && _appState.useMaterial!) ||
        (UniversalPlatform.isAndroid &&
            (_appState == null || !_appState.switchUI!)) ||
        (UniversalPlatform.isIOS && (_appState == null || _appState.switchUI!));
  }

  // Use Cupertino UI when explicitly specified or even when running in Android
  /// Indicates if the App is running the Cupertino interface theme.
  bool get useCupertino {
    final _appState = appState;
    return (_appState != null && _appState.useCupertino!) ||
        (UniversalPlatform.isIOS &&
            (_appState == null || !_appState.switchUI!)) ||
        (UniversalPlatform.isAndroid &&
            (_appState == null || _appState.switchUI!));
  }

  /// Explicitly change to a particular interface.
  void changeUI(String ui) => appState?.changeUI(ui);

  /// Return the navigator key used by the App's View.
  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      appState?.scaffoldMessengerKey;
  set scaffoldMessengerKey(GlobalKey<ScaffoldMessengerState>? v) {
    if (v != null) {
      appState?.scaffoldMessengerKey = v;
    }
  }

  /// Returns the routes used by the App's View.
  Map<String, WidgetBuilder>? get routes => appState?.routes;
  set routes(Map<String, WidgetBuilder>? v) {
    if (v != null) {
      appState?.routes = v;
    }
  }

  /// Returns to the initial route used by the App's View.
  String? get initialRoute => appState?.initialRoute;
  set initialRoute(String? v) {
    if (v != null) {
      appState?.initialRoute = v;
    }
  }

  /// The route generator used when the app is navigated to a named route.
  RouteFactory? get onGenerateRoute => appState?.onGenerateRoute;
  set onGenerateRoute(RouteFactory? v) {
    if (v != null) {
      appState?.onGenerateRoute = v;
    }
  }

  /// Called when [onGenerateRoute] fails except for the [initialRoute].
  RouteFactory? get onUnknownRoute => appState?.onUnknownRoute;
  set onUnknownRoute(RouteFactory? v) {
    if (v != null) {
      appState?.onUnknownRoute = v;
    }
  }

  /// The list of observers for the [Navigator] for this app.
  List<NavigatorObserver>? get navigatorObservers =>
      appState?.navigatorObservers;
  set navigatorObservers(List<NavigatorObserver>? v) {
    if (v != null) {
      appState?.navigatorObservers = v;
    }
  }

  /// if neither [routes], or [onGenerateRoute] was passed.
  TransitionBuilder? get builder => appState?.builder;
  set builder(TransitionBuilder? v) {
    if (v != null) {
      appState?.builder = v;
    }
  }

  /// Returns the title for the App's View.
  String? get title => appState?.title;
  set title(String? v) {
    if (v != null) {
      appState?.title = v;
    }
  }

  /// Routine used to generate the App's title.
  GenerateAppTitle? get onGenerateTitle => appState?.onGenerateTitle;
  set onGenerateTitle(GenerateAppTitle? v) {
    if (v != null) {
      appState?.onGenerateTitle = v;
    }
  }

  /// Returns the Color passed to the App's View.
  Color? get color => appState?.color;
  set color(Color? v) {
    if (v != null) {
      appState?.color = v;
    }
  }

  /// Returns the device's every changing Locale.
  Locale? get locale =>
      appState?.locale = Localizations.maybeLocaleOf(context!) ??
          _resolveLocales(
            WidgetsBinding.instance.platformDispatcher.locales,
            appState?.supportedLocales,
          );

  /// Set the App's Locale
  /// If 'supportedLocales' are specified, this Locale must be among them.
  set locale(Locale? locale) {
    if (locale != null) {
      L10n.locale = locale;
      // if (locale != L10n.prevLocale) {
      //   appState?.locale = locale;
      // }
    }
  }

  /// Determine the locale used by the Mobile phone.
  Locale? _resolveLocales(
    List<Locale>? preferredLocales,
    Iterable<Locale>? supportedLocales,
  ) {
    // Attempt to use localeListResolutionCallback.
    if (appState?.localeListResolutionCallback != null) {
      final locales = appState?.supportedLocales;
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
      final locales = appState?.supportedLocales;
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

  /// Returns the App's current localizations delegates.
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      appState?.localizationsDelegates;
  set localizationsDelegates(Iterable<LocalizationsDelegate<dynamic>>? v) {
    if (v != null) {
      appState?.localizationsDelegates = v;
    }
  }

  /// Resolves the App's locale.
  LocaleResolutionCallback? get localeResolutionCallback =>
      appState?.localeResolutionCallback;
  set localeResolutionCallback(LocaleResolutionCallback? v) {
    if (v != null) {
      appState?.localeResolutionCallback = v;
    }
  }

  /// getter, supportedLocales, returns a List of the App's locales.
  /// More flexible than an iteration.
  List<Locale>? get supportedLocales =>
      appState?.supportedLocales ??= L10n.supportedLocales;
  set supportedLocales(List<Locale>? locales) {
    if (locales != null) {
      if (L10n.supportedLocales.isEmpty) {
        L10n.supportedLocales = appState?.supportedLocales ??= locales;
      } else {
        final appLocales = appState?.supportedLocales ?? [];
        if (appLocales.isEmpty) {
          appState?.supportedLocales?.addAll(L10n.supportedLocales);
        }
      }
    }
  }

  /// If true, it paints a grid overlay on Material apps.
  bool? get debugShowMaterialGrid => appState?.debugShowMaterialGrid;
  set debugShowMaterialGrid(bool? v) {
    if (v != null) {
      appState?.debugShowMaterialGrid = v;
    }
  }

  /// If true, it turns on a performance overlay.
  bool? get showPerformanceOverlay => appState?.showPerformanceOverlay;
  set showPerformanceOverlay(bool? v) {
    if (v != null) {
      appState?.showPerformanceOverlay = v;
    }
  }

  /// Checkerboard raster cache to speed up overall rendering.
  bool? get checkerboardRasterCacheImages =>
      appState?.checkerboardRasterCacheImages;
  set checkerboardRasterCacheImages(bool? v) {
    if (v != null) {
      appState?.checkerboardRasterCacheImages = v;
    }
  }

  /// Checkerboard layers rendered offscreen bitmaps.
  bool? get checkerboardOffscreenLayers =>
      appState?.checkerboardOffscreenLayers;
  set checkerboardOffscreenLayers(bool? v) {
    if (v != null) {
      appState?.checkerboardOffscreenLayers = v;
    }
  }

  /// Shows an overlay of accessibility information
  bool? get showSemanticsDebugger => appState?.showSemanticsDebugger;
  set showSemanticsDebugger(bool? v) {
    if (v != null) {
      appState?.showSemanticsDebugger = v;
    }
  }

  /// Shows a little "DEBUG" banner in checked mode.
  bool? get debugShowCheckedModeBanner => appState?.debugShowCheckedModeBanner;
  set debugShowCheckedModeBanner(bool? v) {
    if (v != null) {
      appState?.debugShowCheckedModeBanner = v;
    }
  }

  /// Each RenderBox to paint a box around its bounds.
  bool? get debugPaintSizeEnabled => appState?.debugPaintSizeEnabled;
  set debugPaintSizeEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintSizeEnabled = v;
    }
  }

  /// RenderBox paints a line at its baselines.
  bool? get debugPaintBaselinesEnabled => appState?.debugPaintBaselinesEnabled;
  set debugPaintBaselinesEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintBaselinesEnabled = v;
    }
  }

  /// Objects flash while they are being tapped.
  bool? get debugPaintPointersEnabled => appState?.debugPaintPointersEnabled;
  set debugPaintPointersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintPointersEnabled = v;
    }
  }

  /// Layer paints a box around its bound.
  bool? get debugPaintLayerBordersEnabled =>
      appState?.debugPaintLayerBordersEnabled;
  set debugPaintLayerBordersEnabled(bool? v) {
    if (v != null) {
      appState?.debugPaintLayerBordersEnabled = v;
    }
  }

  /// Overlay a rotating set of colors when repainting layers in checked mode.
  bool? get debugRepaintRainbowEnabled => appState?.debugRepaintRainbowEnabled;
  set debugRepaintRainbowEnabled(bool? v) {
    if (v != null) {
      appState?.debugRepaintRainbowEnabled = v;
    }
  }

  /// Determines if running in an IDE or in production.
  bool get inDebugMode => appState?.inDebugMode ?? false;

  ///
  @Deprecated('Use inDebugMode instead.')
  bool get inDebugger => inDebugMode;

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
  void catchError(Object ex) {
    if (ex is! Exception) {
      ex = Exception(ex.toString());
    }
    appState?.catchError(ex);
  }

  /// Retrieve the 'lastest' context
  BuildContext? get context => appState?.lastContext;
}
