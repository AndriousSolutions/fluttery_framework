/// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  27 Oct 2020
///

// Replace 'dart:io' for Web applications

import 'package:fluttery_framework/controller.dart'
    show AppController, StateXController;

import 'package:state_extended/state_extended.dart' as s show StateX;

import 'package:fluttery_framework/view.dart';

import 'package:fluttery_framework/view.dart' as v;

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debug;

///
/// The View for the app. The 'look and feel' for the whole app.
///
/// dartdoc:
/// {@category AppState class}
/// {@category Get started}
/// {@category StateX class}
/// {@category Error handling}
class AppState<T extends StatefulWidget> extends _AppState<T>
    with NavigatorStateMethodsMixin {
  /// Provide a huge array of options and features to the 'App State object.'
  AppState({
    this.key,
    this.home,
    AppController? controller,
    super.controllers,
    super.object,
    WidgetBuilder? inAppBuilder,
    super.materialApp,
    super.cupertinoApp,
    super.routeInformationProvider,
    super.routeInformationParser,
    super.routerDelegate,
    super.routerConfig,
    super.backButtonDispatcher,
    super.scaffoldMessengerKey,
    super.routes,
    super.initialRoute,
    super.onGenerateRoute,
    super.onUnknownRoute,
    super.navigatorObservers,
    super.builder,
    super.title,
    super.onGenerateTitle,
    bool? allowChangeTheme,
    super.theme,
    super.iOSTheme,
    super.darkTheme,
    super.highContrastTheme,
    super.highContrastDarkTheme,
    super.themeMode,
    super.themeAnimationDuration,
    super.themeAnimationCurve,
    super.color,
    super.locale,
    bool? allowChangeLocale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales,
    bool? useMaterial,
    bool? useCupertino,
    bool? switchUI,
    bool? allowChangeUI,
    super.debugShowMaterialGrid,
    super.showPerformanceOverlay,
    super.checkerboardRasterCacheImages,
    super.checkerboardOffscreenLayers,
    super.showSemanticsDebugger,
    super.debugShowCheckedModeBanner,
    super.shortcuts,
    super.actions,
    this.useRouterConfig,
    super.restorationScopeId,
    super.scrollBehavior,
    super.debugShowWidgetInspector,
    super.debugPaintSizeEnabled,
    super.debugPaintBaselinesEnabled,
    super.debugPaintPointersEnabled,
    super.debugPaintLayerBordersEnabled,
    super.debugRepaintRainbowEnabled,
    super.debugRepaintTextRainbowEnabled,
    super.errorHandler,
    super.errorScreen,
    super.errorReport,
    super.inErrorHandler,
    super.inErrorScreen,
    super.inErrorReport,
    this.inInitState,
    this.inInitAsync,
    this.inHome,
    this.inRouteInformationProvider,
    this.inRouteInformationParser,
    this.inRouterDelegate,
    this.inRouterConfig,
    this.inBackButtonDispatcher,
    this.inRoutes,
    this.inInitialRoute,
    this.inOnGenerateRoute,
    this.inOnUnknownRoute,
    this.inNavigatorObservers,
    this.inTransBuilder,
    this.inTitle,
    this.inGenerateTitle,
    this.inTheme,
    this.iniOSTheme,
    this.inDarkTheme,
    this.inHighContrastTheme,
    this.inHighContrastDarkTheme,
    this.inThemeMode,
    this.inThemeAnimationDuration,
    this.inThemeAnimationCurve,
    this.inColor,
    this.inLocale,
    this.inLocalizationsDelegates,
    this.inLocaleListResolutionCallback,
    this.inLocaleResolutionCallback,
    this.inSupportedLocales,
    this.inDebugShowMaterialGrid,
    this.inShowPerformanceOverlay,
    this.inCheckerboardRasterCacheImages,
    this.inCheckerboardOffscreenLayers,
    this.inShowSemanticsDebugger,
    this.inDebugShowCheckedModeBanner,
    this.inShortcuts,
    this.inActions,
    this.inRestorationScopeId,
    this.inScrollBehavior,
    this.inError,
    this.inAsyncError,
  })  : _stateRouteObserver = StateRouteObserver(),
        super(controller: controller ?? AppController()) {
    // A replacement for the MaterialApp or CupertinoApp
    _widgetsAppBuilder = inAppBuilder;

    // Determine what the app can change at runtime
    _allowChangeTheme = allowChangeTheme ?? false;
    _allowChangeLocale = allowChangeLocale ?? false;
    _allowChangeUI = allowChangeUI ?? false;

    // In case null was explicitly passed in.
    _useMaterial = useMaterial ?? false;
    _useCupertino = useCupertino ?? false;
    _switchUI = switchUI ?? false;

    if (UniversalPlatform.isAndroid) {
      if (_switchUI) {
        _useMaterial = false;
        _useCupertino = true;
      } else if (_useCupertino) {
        _useMaterial = false;
      } else {
        _useMaterial = true;
        _useCupertino = false;
      }
    } else if (UniversalPlatform.isIOS) {
      if (_switchUI) {
        _useMaterial = true;
        _useCupertino = false;
      } else if (_useMaterial) {
        _useCupertino = false;
      } else {
        _useMaterial = false;
        _useCupertino = true;
      }
    } else {
      _useMaterial = true;
      _useCupertino = false;
    }
  }

  /// The 'App State Objects' [Key]
  final Key? key;

  /// The App's 'home screen'
  final Widget? home;

  /// Allows you to provide the app's widget
  WidgetBuilder? _widgetsAppBuilder;

  /// Use RouterConfig or not
  final bool? useRouterConfig;

  /// Allow the app to change the theme
  late bool _allowChangeTheme;

  /// Allow the app directly change the Locale
  late bool _allowChangeLocale;

  /// Allow the app to directly change the UI design
  late bool _allowChangeUI;

  /// Use Cupertino UI in Android and vice versa.
  bool get switchUI => _switchUI;
  late bool _switchUI;

  /// Explicitly use the Material theme
  bool get useMaterial => _useMaterial;
  late bool _useMaterial;

  /// Explicitly use the Cupertino theme
  bool get useCupertino => _useCupertino;
  late bool _useCupertino;

  /// Perform asynchronous operations
  final Future<bool> Function()? inInitAsync;

  /// Perform synchronous initialization
  final void Function()? inInitState;

  /// Returns the home screen if any.
  final Widget Function()? inHome;

  /// Returns the Route Provider if any.
  final RouteInformationProvider Function()? inRouteInformationProvider;

  /// Returns the Route Parser if any.
  final RouteInformationParser<Object> Function()? inRouteInformationParser;

  /// Returns the Route Delegate if any.
  final RouterDelegate<Object> Function()? inRouterDelegate;

  /// Returns the Route Config if any.
  final RouterConfig<Object>? Function()? inRouterConfig;

  /// Returns the 'Back Button' routine if any.
  final BackButtonDispatcher Function()? inBackButtonDispatcher;

  /// Returns a Map of Routes if any.
  final Map<String, WidgetBuilder> Function()? inRoutes;

  /// Returns the initial Route if any.
  final String Function()? inInitialRoute;

  /// Returns the 'Generate Routes' routine if any.
  final RouteFactory Function()? inOnGenerateRoute;

  /// Returns the 'Unknown Route' if any.
  final RouteFactory Function()? inOnUnknownRoute;

  /// Returns a List of Navigation Observers if any.
  final List<NavigatorObserver> Function()? inNavigatorObservers;

  /// Returns the 'Transition Builder' if any.
  final TransitionBuilder Function()? inTransBuilder;

  /// Returns the App's title if any.
  final String Function()? inTitle;

  /// Returns the 'Generate Title' routine if any.
  final GenerateAppTitle? inGenerateTitle;

  /// Returns the App's [ThemeData] if any.
  final ThemeData? Function()? inTheme;

  /// Returns the App's [CupertinoThemeData] if any.
  final CupertinoThemeData? Function()? iniOSTheme;

  /// Returns the App's 'Dark Theme' [ThemeData] if any.
  final ThemeData? Function()? inDarkTheme;

  /// Returns the App's 'High Contrast Theme' [ThemeData] if any.
  final ThemeData? Function()? inHighContrastTheme;

  /// Returns the App's 'High Contrast Dark Theme' [ThemeData] if any.
  final ThemeData? Function()? inHighContrastDarkTheme;

  /// Returns the App's [ThemeMode] if any.
  final ThemeMode? Function()? inThemeMode;

  /// The duration of animated theme changes.
  final Duration? Function()? inThemeAnimationDuration;

  /// The curve to apply when animating theme changes.
  final Curve? Function()? inThemeAnimationCurve;

  /// Returns the App's [Color] if any.
  final Color? Function()? inColor;

  /// Returns current [Locale] if any.
  final Locale? Function()? inLocale;

  /// Returns the 'Localization Delegates' if any.
  final Iterable<LocalizationsDelegate<dynamic>> Function()?
      inLocalizationsDelegates;

  /// Returns 'Locale Resolutions' routine if any.
  final LocaleListResolutionCallback? inLocaleListResolutionCallback;

  /// Returns 'Local Resolution' routine if any.
  final LocaleResolutionCallback? inLocaleResolutionCallback;

  /// Returns the Locale Iteration if any.
  final List<Locale>? Function()? inSupportedLocales;

  /// Returns 'Show Material Grid' boolean indicator if any.
  final bool? Function()? inDebugShowMaterialGrid;

  /// Returns 'Show Performance Overlay' boolean indicator if any.
  final bool? Function()? inShowPerformanceOverlay;

  /// Returns 'Raster Cache Checkerboard' boolean indicator if any.
  final bool? Function()? inCheckerboardRasterCacheImages;

  /// Returns 'Off Screen Layers Checkerboard' boolean indicator if any.
  final bool? Function()? inCheckerboardOffscreenLayers;

  /// Returns 'Show Semantics' boolean indicator if any.
  final bool? Function()? inShowSemanticsDebugger;

  /// Returns 'Show Debug Banner' boolean indicator if any.
  final bool? Function()? inDebugShowCheckedModeBanner;

  /// Returns Map of 'LogicalKeySets' if any.
  final Map<LogicalKeySet, Intent>? Function()? inShortcuts;

  /// Returns Map of 'Intent Actions' if any.
  final Map<Type, Action<Intent>>? Function()? inActions;

  /// Returns the 'Restore Scope Id' routine if any.
  final String? Function()? inRestorationScopeId;

  /// Returns the App's [ScrollBehavior] if any.
  final ScrollBehavior? Function()? inScrollBehavior;

  /// Returns the App's 'Error Handler' if any.
  final void Function(FlutterErrorDetails details)? inError;

  /// Returns the App's 'Async Error Handler' if any.
  final bool? Function(FlutterErrorDetails details)? inAsyncError;

  /// A flag indicating we're running in the error routine.
  ///
  /// Set to avoid infinite loop if in errors in the error routine.
  bool inErrorRoutine = false;

  /// Retrieve and cast as this Framework's own particular 'controller' type.
  @override
  StateXController? get controller {
    StateXController? controller;
    final con = super.controller;
    if (con != null) {
      controller = con as StateXController;
    }
    return controller;
  }

  /// Retrieve and cast as this Framework's own particular 'controller' type.
  @override
  StateXController? controllerById(String? id) {
    StateXController? controller;
    final con = super.controllerById(id);
    if (con != null) {
      controller = con as StateXController;
    }
    return controller;
  }

  /// Reference the 'parent' State object
  State? get parentState => _parentState;
  State? _parentState;

  /// Set the 'parent' State object but only once!
  set parentState(State? state) => _parentState ??= state;

  /// Reference to the 'app' object.
  AppObject? get app => _app;

  /// Set the 'app' object but only once!
  set app(AppObject? app) => _app ??= app;

  /// The app's representation
  AppObject? _app;

  /// You need to be able access the widget.
  // if parentState is null then AppStatefulWidget was likely not used.
  @override
  T get widget => (parentState?.widget ?? super.widget) as T;

  /// Used to complete asynchronous operations
  @override
  Future<bool> initAsync() async {
    var init = await onInitAsync();
    if (init) {
      init = await super.initAsync();
    }
    return init;
  }

  /// Supply a GlobalKey to the CupertinoApp and the MaterialApp
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    cupertinoKey = GlobalKey();
    materialKey = GlobalKey();
    // If some inline initState() is defined.
    if (inInitState != null) {
      inInitState!();
    }
  }

  /// Key for the CupertinoApp
  late GlobalKey cupertinoKey;

  /// Key for the MaterialApp;
  late GlobalKey materialKey;

  /// The app's locale
  Locale? get locale => _appLocale;
  Locale? _appLocale;

  /// Clean up resources before the app is finally terminated.
  @override
  @mustCallSuper
  void dispose() {
    //
    _app = null;
    super.dispose();
  }

  /// Override build to avoid the built-in Future Builder. It's been run.
  @override
  Widget build(BuildContext context) =>
      Sizer(builder: (context, orientation, deviceType) => buildF(context));

  /// Override to impose your own WidgetsApp (like CupertinoApp or MaterialApp)
  @override
  Widget buildIn(BuildContext context) {
    //
    Widget? app;

    assert(() {
      /// Highlights UI while debugging.
      debug.debugPaintSizeEnabled = debugPaintSizeEnabled ?? false;
      debug.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled ?? false;
      debug.debugPaintPointersEnabled = debugPaintPointersEnabled ?? false;
      debug.debugPaintLayerBordersEnabled =
          debugPaintLayerBordersEnabled ?? false;
      debug.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled ?? false;
      debug.debugRepaintTextRainbowEnabled =
          debugRepaintTextRainbowEnabled ?? false;
      return true;
    }());

    // If the Router Configuration is provided.
    final _routerConfig = routerConfig ?? onRouterConfig();

    // If the flag was set to true and there is a Router Configuration.
    final _useRouter = (useRouterConfig ?? false) && _routerConfig != null;

    // Make the GoRouter readily available without requiring a context.
    if (_useRouter) {
      App.goRouter = _routerConfig;
    }

    // If the routerConfig is to be used, the others must all be null.
    final _routeInformationProvider = _useRouter
        ? null
        : routeInformationProvider ?? onRouteInformationProvider();

    final _routeInformationParser = _useRouter
        ? null
        : routeInformationParser ?? onRouteInformationParser();

    final _routerDelegate =
        _useRouter ? null : routerDelegate ?? onRouterDelegate();

    final _backButtonDispatcher =
        _useRouter ? null : backButtonDispatcher ?? onBackButtonDispatcher();

    // There's possibly a preferred Locale.
    Locale? _preferredLocale;

    // The app can specify its own Locale
    if (_allowChangeLocale) {
      _preferredLocale = App.preferredLocale;
    }

    _appLocale = _preferredLocale ?? _locale ?? onLocale();

    // If the locale was saved in the preferences.
    if (_preferredLocale != null) {
      App.saveLocale(_appLocale);
    }

    // Assign to the L10n
    // IMPORTANT assign L10n.locale before L10n.supportedLocales
    L10n.locale = _appLocale;

    // Can't be empty
    if (_supportedLocales.isEmpty) {
      _supportedLocales =
          onSupportedLocales() ?? const <Locale>[Locale('en', 'US')];
      // Still empty
      if (_supportedLocales.isEmpty) {
        _supportedLocales = const <Locale>[Locale('en', 'US')];
      }
    }

    // Note, if it's not empty, it's not set
    L10n.supportedLocales = _supportedLocales;

    // An app builder may instead by supplied.
    app = onAppBuilder(context);

    if (app == null) {
      //
      if (_useCupertino) {
        // A CupertinoApp object has been supplied.
        if (cupertinoApp != null) {
          app = cupertinoApp!;
          //
        } else if (_routerDelegate == null && !_useRouter) {
          //
          app = CupertinoApp(
            key: key ?? cupertinoKey,
            navigatorKey: App.navigatorKey,
            theme: _setiOSThemeData(),
            routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
            initialRoute: initialRoute ?? onInitialRoute(),
            onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
            onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
            navigatorObservers: _navigatorObservers(),
            builder: builder ?? onBuilder(),
// not needed  title: ,  // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color ?? onColor() ?? Colors.blue,
            locale: _appLocale,
            localizationsDelegates:
                localizationsDelegates ?? onLocalizationsDelegates(),
            localeListResolutionCallback:
                localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay:
                showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: shortcuts ?? onShortcuts(),
            actions: actions ?? onActions(),
            restorationScopeId: restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: scrollBehavior ?? onScrollBehavior(),
            // Let the parameters run before the home parameter.
            home: home ?? onHome(),
          );
        } else {
          //
          app = CupertinoApp.router(
            key: key ?? cupertinoKey,
            routeInformationProvider: _routeInformationProvider,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            backButtonDispatcher: _backButtonDispatcher,
            routerConfig: _routerConfig,
            theme: _setiOSThemeData(),
            builder: builder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color ?? onColor() ?? Colors.blue,
            locale: _appLocale,
            localizationsDelegates:
                localizationsDelegates ?? onLocalizationsDelegates(),
            localeListResolutionCallback:
                localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay:
                showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: shortcuts ?? onShortcuts(),
            actions: actions ?? onActions(),
            restorationScopeId: restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: scrollBehavior ?? onScrollBehavior(),
          );
        }
      } else {
        // A MaterialApp object has been supplied.
        if (materialApp != null) {
          //
          app = materialApp!;
          //
        } else if (_routerDelegate == null && !_useRouter) {
          //
          app = MaterialApp(
            key: key ?? materialKey,
            navigatorKey: App.navigatorKey,
            scaffoldMessengerKey:
                scaffoldMessengerKey ?? onScaffoldMessengerKey(),
            routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
            initialRoute: initialRoute ?? onInitialRoute(),
            onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
            onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
            navigatorObservers: _navigatorObservers(),
            builder: builder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color ?? onColor() ?? Colors.white,
            theme: _setThemeData(),
            darkTheme: darkTheme ?? onDarkTheme(),
            highContrastTheme: highContrastTheme ?? onHighContrastTheme(),
            highContrastDarkTheme:
                highContrastDarkTheme ?? onHighContrastDarkTheme(),
            themeMode: themeMode ?? onThemeMode() ?? ThemeMode.system,
            themeAnimationDuration: themeAnimationDuration ??
                onThemeAnimationDuration() ??
                const Duration(milliseconds: 200),
            themeAnimationCurve:
                themeAnimationCurve ?? onThemeAnimationCurve() ?? Curves.linear,
            locale: _appLocale,
            localizationsDelegates: onLocalizationsDelegates(),
            localeListResolutionCallback:
                localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid:
                debugShowMaterialGrid ?? onDebugShowMaterialGrid() ?? false,
            showPerformanceOverlay:
                showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: shortcuts ?? onShortcuts(),
            actions: actions ?? onActions(),
            restorationScopeId: restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: scrollBehavior ?? onScrollBehavior(),
            // Let the parameters run before the home parameter.
            home: home ?? onHome(),
          );
        } else {
          //
          app = MaterialApp.router(
            key: key ?? materialKey,
            scaffoldMessengerKey:
                scaffoldMessengerKey ?? onScaffoldMessengerKey(),
            routeInformationProvider: _routeInformationProvider,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            routerConfig: _routerConfig,
            backButtonDispatcher: _backButtonDispatcher,
            builder: builder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color ?? onColor() ?? Colors.white,
            theme: _setThemeData(),
            darkTheme: darkTheme ?? onDarkTheme(),
            highContrastTheme: highContrastTheme ?? onHighContrastTheme(),
            highContrastDarkTheme:
                highContrastDarkTheme ?? onHighContrastDarkTheme(),
            themeMode: themeMode ?? onThemeMode() ?? ThemeMode.system,
            themeAnimationDuration: themeAnimationDuration ??
                onThemeAnimationDuration() ??
                const Duration(milliseconds: 200),
            themeAnimationCurve:
                themeAnimationCurve ?? onThemeAnimationCurve() ?? Curves.linear,
            locale: _appLocale,
            localizationsDelegates: onLocalizationsDelegates(),
            localeListResolutionCallback:
                localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid:
                debugShowMaterialGrid ?? onDebugShowMaterialGrid() ?? false,
            showPerformanceOverlay:
                showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: shortcuts ?? onShortcuts(),
            actions: actions ?? onActions(),
            restorationScopeId: restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: scrollBehavior ?? onScrollBehavior(),
          );
        }
      }
    }
    return app!;
  }

  /// Supply the appropriate List of 'observers' that are called
  /// when a route is changed in the Navigator.
  List<NavigatorObserver> _navigatorObservers() {
    // Supply the StateX objects to observe the route changes
    final observers = <NavigatorObserver>[_stateRouteObserver.routeObserver];
    // Observers from parameter?
    if (navigatorObservers != null) {
      observers.addAll(navigatorObservers!);
    }
    // Any observers from this function?
    final moreObservers = onNavigatorObservers();
    if (moreObservers != null && moreObservers.isNotEmpty) {
      observers.addAll(moreObservers);
    }
    return observers;
  }

  /// State object becomes a route observer.
  bool subscribe(State state) => _stateRouteObserver.subscribe(state);

  /// No longer a route observer
  bool unsubscribe(State state) => _stateRouteObserver.unsubscribe(state);

  /// Any and all StateX objects are all 'route' observers.
  final StateRouteObserver _stateRouteObserver;

  /// Assigning the Cupertino theme
  CupertinoThemeData? _setiOSThemeData() {
    //
    CupertinoThemeData? themeData = iOSTheme ?? oniOSTheme();

    if (themeData == null || _allowChangeTheme) {
      themeData = App.iOSThemeData ??
          const CupertinoThemeData(brightness: Brightness.light);
    }
    return themeData;
  }

  /// Assigning the Material theme
  ThemeData? _setThemeData() {
    //
    ThemeData? themeData = theme ?? onTheme();

    if (themeData == null || _allowChangeTheme) {
      themeData = App.themeData;
    }
    return themeData;
  }

  /// Override if you like to customize error handling.
  @override
// Allow a complete override. gp
//  @mustCallSuper
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (inErrorRoutine) {
      return;
    }
    inErrorRoutine = true;

    // If it involves the widgets library,
    // call the latest SateX object's error routine
    // Possibly the error occurred there.
//    final library = details.library;
//    if (library != null && 'gesture widgets library'.contains(library)) {
    final state = endState;
    if (state != null) {
      try {
        final stack = details.stack?.toString();
        if (stack != null) {
          //
          var name = state.toString();
          name = name.substring(0, name.indexOf('#'));
          // That State object's build() function was called.
          if (state is StateX && stack.contains('$name.build')) {
            //
            state.onError(details);
          }
        }
      } catch (e, stack) {
        recordException(e, stack);
      }
      // Always test if there was an error in the error handler
      // Include it in the error reporting as well.
      if (hasError) {
        _onErrorInHandler();
      }
    }
    //   }

    // The base Error Handler
    super.onError(details);

    // Always test if there was an error in the error handler
    // Include it in the error reporting as well.
    if (hasError) {
      _onErrorInHandler();
    }

    // If there's any 'inline function' error handler.
    // It takes last precedence.
    if (inError != null) {
      try {
        inError!(details);
      } catch (e, stack) {
        recordException(e, stack);
      }
      // Always test if there was an error in the error handler
      // Include it in the error reporting as well.
      if (hasError) {
        _onErrorInHandler();
      }
    }
    inErrorRoutine = false;
  }

  /// Rebuild the 'latest/current' State object and the 'root/first' State object
  /// This is to address the possibility an App has called another App.
  void refresh() {
    _AppState? _state;
    if (_AppState._appInApp) {
      _state = lastContext?.findAncestorStateOfType<_AppState>();
    }
    if (_state == null) {
      endState?.setState(() {});
      // Refresh the 'root' State object.
      super.setState(() {});
    } else {
      _state.setState(() {});
    }
  }

  /// During development, if a hot reload occurs, the reassemble method is called.
  @override
  void reassemble() {
    App.hotReload = true;
    super.reassemble();
  }

  /// Explicitly change to a particular interface.
  bool changeUI(String? ui) {
    // Allow to chang the interface in the first place.
    bool change = _allowChangeUI;

    if (change) {
      // The parameter may be null
      change = ui != null && ui.isNotEmpty;
    }

    if (change) {
      ui = ui!.trim();
      // Must be a recognized interface design
      change = ui == 'Material' || ui == 'Cupertino';
    }

    if (change) {
      //
      if (ui == 'Material') {
        _useMaterial = true;
        _useCupertino = false;
        _switchUI = !UniversalPlatform.isAndroid;
      } else {
        _useMaterial = false;
        _useCupertino = true;
        _switchUI = UniversalPlatform.isAndroid;
      }
      // Reload the whole App so it works in testing
      reload();
    }
    return change;
  }

  /// Reload the whole App
  void reload() => _parentState?.setState(() {});

  /// Used to complete asynchronous operations
  Future<bool> onInitAsync() async {
    var init = true;
    if (inInitAsync != null) {
      init = await inInitAsync!();
    }
    return init;
  }

  /// Returns the App's Navigator Key.
  @Deprecated("App's Navigator's Key is GlobalKey<NavigatorState>()")
  GlobalKey<NavigatorState> onNavigatorKey() => App.navigatorKey;

  /// Returns the App's ScaffoldMessenger Key.
  GlobalKey<ScaffoldMessengerState> onScaffoldMessengerKey() =>
      _scaffoldMessengerKey ??= GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;

  /// The WidgetsApp builder replaces the MaterialApp & CupertinoApp
  Widget? onAppBuilder(BuildContext context) =>
      _widgetsAppBuilder != null ? _widgetsAppBuilder!(context) : null;

  /// Returns the home screen if any.
  Widget? onHome() => inHome != null ? inHome!() : null;

  /// Returns the Route Provider if any.
  RouteInformationProvider? onRouteInformationProvider() =>
      inRouteInformationProvider != null ? inRouteInformationProvider!() : null;

  /// Returns the Route Parser if any.
  RouteInformationParser<Object>? onRouteInformationParser() =>
      inRouteInformationParser != null ? inRouteInformationParser!() : null;

  /// Returns the Route Delegate if any.
  RouterDelegate<Object>? onRouterDelegate() =>
      inRouterDelegate != null ? inRouterDelegate!() : null;

  /// Returns the Route Config if any.
  RouterConfig<Object>? onRouterConfig() =>
      inRouterConfig != null ? inRouterConfig!() : null;

  /// Returns the 'Back Button' routine if any.
  BackButtonDispatcher? onBackButtonDispatcher() =>
      inBackButtonDispatcher != null ? inBackButtonDispatcher!() : null;

  /// Returns a Map of Routes if any.
  Map<String, WidgetBuilder>? onRoutes() =>
      inRoutes != null ? inRoutes!() : const <String, WidgetBuilder>{};

  /// Returns the initial Route if any.
  String? onInitialRoute() => inInitialRoute != null ? inInitialRoute!() : null;

  /// Returns the 'Generate Routes' routine if any.
  RouteFactory? onOnGenerateRoute() =>
      inOnGenerateRoute != null ? inOnGenerateRoute!() : null;

  /// Returns the 'Unknown Route' if any.
  RouteFactory? onOnUnknownRoute() =>
      inOnUnknownRoute != null ? inOnUnknownRoute!() : null;

  /// Returns a List of Navigation Observers if any.
  List<NavigatorObserver>? onNavigatorObservers() =>
      inNavigatorObservers != null
          ? inNavigatorObservers!()
          : const <NavigatorObserver>[];

  /// Returns the 'Transition Builder' if any.
  TransitionBuilder? onBuilder() =>
      inTransBuilder != null ? inTransBuilder!() : null;

  /// Returns the App's title if any.
  String onTitle() => inTitle != null ? inTitle!() : '';

  /// Returns the supplied title of the app.
  // Note OnGenerateTitle takes precedence over the title parameter in WidgetsAppState class
  String _onOnGenerateTitle(BuildContext context) {
    final genTitle = onGenerateTitle ??
        inGenerateTitle ??
        (context) {
          // If no title parameter was passed.
          if (_title.isEmpty) {
            _title = onTitle();
          }
          return _title;
        };
    // Get a copy of the title first.
    return _title = L10n.s(genTitle(context));
  }

  /// Returns the App's [ThemeData] if any.
  ThemeData? onTheme() => inTheme != null ? inTheme!() : null;

  /// Returns the App's [CupertinoThemeData] if any.
  CupertinoThemeData? oniOSTheme() => iniOSTheme != null ? iniOSTheme!() : null;

  /// Returns the App's 'Dark Theme' [ThemeData] if any.
  ThemeData? onDarkTheme() => inDarkTheme != null ? inDarkTheme!() : null;

  /// Returns the App's 'High Contrast Theme' [ThemeData] if any.
  ThemeData? onHighContrastTheme() =>
      inHighContrastTheme != null ? inHighContrastTheme!() : null;

  /// Returns the App's 'High Contrast Dark Theme' [ThemeData] if any.
  ThemeData? onHighContrastDarkTheme() =>
      inHighContrastDarkTheme != null ? inHighContrastDarkTheme!() : null;

  /// Returns the App's [ThemeMode] if any.
  ThemeMode? onThemeMode() =>
      inThemeMode != null ? inThemeMode!() : ThemeMode.system;

  /// Returns the App's [ThemeMode] if any.
  Duration? onThemeAnimationDuration() => inThemeAnimationDuration != null
      ? inThemeAnimationDuration!()
      : const Duration(milliseconds: 200);

  /// Returns the App's [ThemeMode] if any.
  Curve? onThemeAnimationCurve() =>
      inThemeAnimationCurve != null ? inThemeAnimationCurve!() : Curves.linear;

  /// Returns the App's [Color] if any.
  Color? onColor() => inColor != null ? inColor!() : null;

  /// Returns current [Locale] if any.
  Locale? onLocale() => inLocale != null ? inLocale!() : null;

  /// Returns the 'Localization Delegates' if any.
  @mustCallSuper
  Iterable<LocalizationsDelegate<dynamic>>? onLocalizationsDelegates() sync* {
    if (localizationsDelegates != null) {
      yield* localizationsDelegates!;
    }
    if (inLocalizationsDelegates != null) {
      yield* inLocalizationsDelegates!();
    }
  }

  /// Returns 'Locale Resolutions' routine if any.
  Locale? onLocaleListResolutionCallback(
          List<Locale>? locales, Iterable<Locale> supportedLocales) =>
      inLocaleListResolutionCallback == null
          ? null
          : inLocaleListResolutionCallback!(locales, supportedLocales);

  /// Returns 'Local Resolution' routine if any.
  /// Turn to the I10n class to provide the locale.
  Locale? onLocaleResolutionCallback(
          Locale? locale, Iterable<Locale> supportedLocales) =>
      inLocaleResolutionCallback == null
          ? null
          : inLocaleResolutionCallback!(
              locale, supportedLocales); // ?? L10n.localeResolutionCallback;

  /// Returns the Locale Iteration if any.
  List<Locale>? onSupportedLocales() =>
      inSupportedLocales != null ? inSupportedLocales!() : null;

  /// Returns 'Show Material Grid' boolean indicator if any.
  bool? onDebugShowMaterialGrid() =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      inDebugShowMaterialGrid != null ? inDebugShowMaterialGrid!() : false;

  /// Returns 'Show Performance Overlay' boolean indicator if any.
  bool? onShowPerformanceOverlay() =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      inShowPerformanceOverlay != null ? inShowPerformanceOverlay!() : false;

  /// Returns 'Raster Cache Checkerboard' boolean indicator if any.
  bool? onCheckerboardRasterCacheImages() =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      inCheckerboardRasterCacheImages != null
          ? inCheckerboardRasterCacheImages!()
          : false;

  /// Returns 'Off Screen Layers Checkerboard' boolean indicator if any.
  // ignore: avoid_bool_literals_in_conditional_expressions
  bool? onCheckerboardOffscreenLayers() => inCheckerboardOffscreenLayers != null
      ? inCheckerboardOffscreenLayers!()
      : false;

  /// Returns 'Show Semantics' boolean indicator if any.
  bool? onShowSemanticsDebugger() =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      inShowSemanticsDebugger != null ? inShowSemanticsDebugger!() : false;

  /// Returns 'Show Debug Banner' boolean indicator if any.
  // ignore: avoid_bool_literals_in_conditional_expressions
  bool? onDebugShowCheckedModeBanner() => inDebugShowCheckedModeBanner != null
      ? inDebugShowCheckedModeBanner!()
      : true;

  /// Returns Map of 'LogicalKeySets' if any.
  Map<LogicalKeySet, Intent>? onShortcuts() =>
      inShortcuts != null ? inShortcuts!() : null;

  /// Returns Map of 'Intent Actions' if any.
  Map<Type, Action<Intent>>? onActions() =>
      inActions != null ? inActions!() : null;

  /// Returns the 'Restore Scope Id' routine if any.
  String? onRestorationScopeId() =>
      inRestorationScopeId != null ? inRestorationScopeId!() : null;

  /// Returns the App's [ScrollBehavior] if any.
  ScrollBehavior? onScrollBehavior() =>
      inScrollBehavior != null ? inScrollBehavior!() : null;
}

/// The underlying State object representing the App's View in the MVC pattern.
/// Allows for setting debug settings and defining the App's error routine.
abstract class _AppState<T extends StatefulWidget> extends v.AppStateX<T> {
  //
  _AppState({
    AppController? controller,
    super.controllers,
    super.object,
    this.materialApp,
    this.cupertinoApp,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.scaffoldMessengerKey,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.builder,
    String? title,
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.iOSTheme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode,
    this.themeAnimationDuration,
    this.themeAnimationCurve,
    Locale? locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    List<Locale>? supportedLocales,
    this.debugShowMaterialGrid,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowWidgetInspector,
    this.debugShowCheckedModeBanner,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.debugPaintSizeEnabled,
    this.debugPaintBaselinesEnabled,
    this.debugPaintPointersEnabled,
    this.debugPaintLayerBordersEnabled,
    this.debugRepaintRainbowEnabled,
    this.debugRepaintTextRainbowEnabled,
    this.errorHandler,
    this.errorScreen,
    this.errorReport,
    this.inErrorHandler,
    this.inErrorScreen,
    this.inErrorReport,
  })  : currentErrorFunc = FlutterError.onError,
        super(controller: controller) {
    // If a tester is running. Don't switch out its error handler.
    if (WidgetsBinding.instance is WidgetsFlutterBinding) {
      // Place a breakpoint at onError() function below to debug error.
      FlutterError.onError = _handleError;
    }
    // Listen to the device's connectivity.
    App.addConnectivityListener(controller);

    // Take in the parameters
    _title = title ?? '';
    _locale = locale;

    // Take in the parameter
    _supportedLocales = supportedLocales ?? [];

    debugShowMaterialGrid ??= false;
    showPerformanceOverlay ??= false;
    checkerboardRasterCacheImages ??= false;
    checkerboardOffscreenLayers ??= false;
    showSemanticsDebugger ??= false;
    debugShowWidgetInspector ??= false;
    debugShowCheckedModeBanner ??= true;
    debugPaintSizeEnabled ??= false;
    debugPaintBaselinesEnabled ??= false;
    debugPaintPointersEnabled ??= false;
    debugPaintLayerBordersEnabled ??= false;
    debugRepaintRainbowEnabled ??= false;
    debugRepaintTextRainbowEnabled ??= false;

    // Supply a customized error handling.
    _errorHandler = AppErrorHandler(
        handler: errorHandler ?? onErrorHandler,
        screen: errorScreen ?? onErrorScreen,
        report: errorReport ?? onErrorReport);
  }

  /// Save the current Error Handler.
  final FlutterExceptionHandler? currentErrorFunc;

  // The App's error handler.
  AppErrorHandler? _errorHandler;

  /// The MaterialApp and CupertinoApp if provided.
  MaterialApp? materialApp;
  CupertinoApp? cupertinoApp;

  /// All the fields found in the widgets, MaterialApp and CupertinoApp
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  final BackButtonDispatcher? backButtonDispatcher;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  String get title => _title;
  late String _title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final CupertinoThemeData? iOSTheme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration? themeAnimationDuration;
  final Curve? themeAnimationCurve;
  final Color? color;
  Locale? _locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  List<Locale> get supportedLocales => _supportedLocales;
  late List<Locale> _supportedLocales;
  bool? debugShowMaterialGrid;
  bool? showPerformanceOverlay;
  bool? checkerboardRasterCacheImages;
  bool? checkerboardOffscreenLayers;
  bool? showSemanticsDebugger;
  bool? debugShowWidgetInspector;
  bool? debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;

  String? restorationScopeId;
  ScrollBehavior? scrollBehavior;

  /// Highlights UI while debugging.
  bool? debugPaintSizeEnabled;
  bool? debugPaintBaselinesEnabled;
  bool? debugPaintPointersEnabled;
  bool? debugPaintLayerBordersEnabled;
  bool? debugRepaintRainbowEnabled;
  bool? debugRepaintTextRainbowEnabled;

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Determine if this app has been called by another app.
    final state = context.findRootAncestorStateOfType<_AppState>();

    if (state != null && !_appInApp) {
      // A flag indicating if this app is called by another app
      _appInApp = state != this;
    }
  }

  // This App is within another App
  static bool _appInApp = false;

  @override
  void dispose() {
    //
    _errorHandler?.dispose();
    _errorHandler = null;
    // Return the original error routine.
    FlutterError.onError = currentErrorFunc;
    super.dispose();
  }

  FlutterExceptionHandler? errorHandler;
  ErrorWidgetBuilder? errorScreen;
  ReportErrorHandler? errorReport;

  final FlutterExceptionHandler? inErrorHandler;
  final ErrorWidgetBuilder? inErrorScreen;
  final Future<void> Function(Object exception, StackTrace stack)?
      inErrorReport;

  /// Run the provided Error Handler if any.
  void onErrorHandler(FlutterErrorDetails details) {
    if (inErrorHandler != null) {
      inErrorHandler!(details);
    }
  }

  /// The Widget to display when an app's widget fails to display.
  Widget onErrorScreen(FlutterErrorDetails details) => inErrorScreen != null
      ? inErrorScreen!(details)
      : AppWidgetErrorDisplayed(stackTrace: App.inDebugMode).builder(details);

  /// If there's a error reporting routine available.
  Future<void> onErrorReport(Object exception, StackTrace stack) async {
    if (inErrorReport != null) {
      await inErrorReport!(exception, stack);
    }
  }

  // Handle any errors in this State object.
  void _handleError(FlutterErrorDetails details) {
    // Set the original error routine. Allows the handler to throw errors.
    FlutterError.onError = currentErrorFunc;
    try {
      onError(details);
    } catch (e) {
      // If the handler also errors, it's throw to be handled
      // by the original routine.
      rethrow;
    }
    // If handled, return to this State object's error handler.
    FlutterError.onError = _handleError;
  }

  /// Supply an 'error handler' routine to fire when an error occurs.
  // details.exception, details.stack
  @protected
  @mustCallSuper
  void onError(FlutterErrorDetails details) {
    try {
      // Call the App's 'current' error handler.
      App.onError(details);
    } catch (e, stack) {
      recordException(e, stack);
    }
  }

  // Notify the developer there's an error in the error handler.
  void _onErrorInHandler() {
    // Always test first that indeed an exception had occurred.
    if (hasError) {
      // Important to get the Stack Trace before it's cleared by recordException()
      final stack = stackTrace;
      final exception = recordException();
      if (exception != null) {
        final details = FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'app_state.dart',
          context: ErrorDescription('inside the Error Handler itself!'),
        );
        try {
          // Call the App's 'current' error handler.
          App.onError(details);
        } catch (e, stack) {
          // Error in the final error handler? That's a pickle.
          recordException(e, stack);
        }
      }
    }
  }
}

/// Supply an 'error handler' routine if something goes wrong.
/// It need not be implemented, but it's their for your consideration.
///
///
///
/// dartdoc:
/// {@category StateX class}
/// {@category Error handling}
mixin StateXonErrorMixin<T extends StatefulWidget> on s.StateX<T> {
  /// This is called within the framework.
  void onError(FlutterErrorDetails details) {}
}

/// A State object that implements a built-in InheritedWidget
///
/// dartdoc:
/// {@category StateX class}
abstract class StateIn<T extends StatefulWidget> extends StateX<T> {
  ///
  StateIn({StateXController? controller})
      : super(controller: controller, useInheritedWidget: true);

  /// Build the Android interface
  @override
  Widget buildAndroid(BuildContext context);

  /// Build the iOS interface
  @override
  Widget buildiOS(BuildContext context);
}

/// The extension of the State class.
///
/// dartdoc:
/// {@category Get started}
/// {@category StateX class}
/// {@category Testing}
abstract class StateX<T extends StatefulWidget> extends s.StateX<T>
    with NavigatorStateMethodsMixin, StateXonErrorMixin {
  ///
  StateX({StateXController? controller, this.useInheritedWidget})
      : super(controller) {
    // Ensure a default value
    _useInherited = this.useInheritedWidget ?? false;
  }

  /// A flag determining whether the built-in InheritedWidget is used or not.
  final bool? useInheritedWidget;
  // Same flag but non-nullable
  late bool _useInherited;

  // Collect any 'widgets' depending on this State's InheritedWidget.
  final Set<BuildContext> _dependencies = {};

  @override
  void initState() {
    super.initState();
    _appState = App.appState;
  }

  late v.AppState? _appState;

  /// Returns the 'first' StateX object in the App
  // Important to prefix with the class name to 'share' this as a mixin.
  @override
  AppState? get rootState {
    AppState? appState;
    final root = super.rootState;
    if (root != null) {
      appState = root as AppState;
    }
    return appState;
  }

  /// Provide the 'main' controller to this State object.
  ///
  /// It can have more than one controller.
  @override
  StateXController? get controller {
    final controller = super.controller;
    return controller == null ? null : controller as StateXController;
  }

  /// Retrieve and cast as this Framework's own particular 'controller' type.
  @override
  StateXController? controllerById(String? id) {
    StateXController? controller;
    final con = super.controllerById(id);
    if (con != null) {
      controller = con as StateXController;
    }
    return controller;
  }

  /// Retrieve and cast as this Framework's own particular 'controller' type.
  @override
  StateXController? get rootCon {
    StateXController? controller;
    final con = super.rootCon;
    if (con != null) {
      controller = con as StateXController;
    }
    return controller;
  }

  /// Build the Android interface.
  ///
  /// By convention, this involves Material Interface
  ///
  /// If only an iOS app, implement this with '=> buildiOS(context);'.
  Widget buildAndroid(BuildContext context);

  /// Build the iOS interface.
  ///
  /// By convention, this involves Cupertino Interface
  ///
  /// If only an Android/Windows/Linux/Web app, implement this with '=> buildAndroid(context);'.
  Widget buildiOS(BuildContext context);

  /// Implement the build() function if you don't use initAsync().
  ///
  /// Implemented in mixin FutureBuilderStateMixin.
  ///
  /// Explicitly implemented here to highlight the override.
  @override
  //ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  Widget buildF(BuildContext context) => _useInherited
      ? _StateXInheritedWidget(
          key: ValueKey<StateX>(this),
          state: this,
          child: _child ??= buildIn(context),
        )
      : buildIn(context);

  /// Compiled once and passed to an InheritedWidget.
  ///
  /// Supply the appropriate interface depending on the platform.
  Widget buildIn(BuildContext context) =>
      App.useMaterial ? buildAndroid(context) : buildiOS(context);

  InheritedElement? _inheritedElement;

  // Widget passed to the InheritedWidget.
  Widget? _child;

  /// Determine if the dependencies should be updated.
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  ///
  ///  Set the specified widget (through its context) as a dependent of the InheritedWidget
  ///
  ///  Return false if not configured to use the InheritedWidget
  @override
  bool dependOnInheritedWidget(BuildContext? context) {
    var depend = _useInherited && context != null;
    if (depend) {
      if (_inheritedElement == null) {
        _dependencies.add(context);
      } else {
        context.dependOnInheritedElement(_inheritedElement!);
      }
    } else {
      depend = super.dependOnInheritedWidget(context);
    }
    return depend;
  }

  /// In harmony with Flutter's own API
  /// Rebuild the InheritedWidget of the 'closes' InheritedStateX object if any.
  @override
  void notifyClients() {
    if (_useInherited) {
      setState(() {});
    } else {
      super.notifyClients();
    }
  }

  @override
  void dispose() {
    _appState = null;
    _child = null;
    _inheritedElement = null;
    _dependencies.clear();
    super.dispose();
  }

  /// Called when the State's InheritedWidget is called again
  /// This 'widget function' will be called again.
  Widget state(WidgetBuilder? widgetFunc) {
    widgetFunc ??= (_) => const SizedBox();
    return _useInherited
        ? _SetStateWidget(stateX: this, widgetFunc: widgetFunc)
        : widgetFunc(context);
  }

  /// Use this to navigate throughout the your app
  static NavigatorState get router => App.router;

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe this to be informed about changes to route.
    _appState?.subscribe(this);
  }

  @override
  @mustCallSuper
  void activate() {
    super.activate();
    // Subscribe this to be informed about changes to route.
    _appState?.subscribe(this);
  }

  @override
  @mustCallSuper
  void deactivate() {
    super.deactivate();
    // No longer informed about changes to its route.
    _appState?.unsubscribe(this);
  }
}

/// The InheritedWidget used by StateX
class _StateXInheritedWidget extends InheritedWidget {
  const _StateXInheritedWidget({
    super.key,
    required this.state,
    required super.child,
  });

  final StateX state;

  @override
  InheritedElement createElement() {
    //
    final element = InheritedElement(this);
    state._inheritedElement = element;
    // Associate any dependencies widgets to this InheritedWidget
    // toList(growable: false) prevent concurrent error
    for (final context in state._dependencies.toList(growable: false)) {
      context.dependOnInheritedElement(element);
      state._dependencies.remove(context);
    }
    return element;
  }

  /// Use the StateX's updateShouldNotify() function
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      state.updateShouldNotify(oldWidget);
}

/// Supply a widget to depend upon a StateX's InheritedWidget
class _SetStateWidget extends StatelessWidget {
  const _SetStateWidget({
    Key? key,
    required this.stateX,
    required this.widgetFunc,
  }) : super(key: key);
  final StateX stateX;
  final WidgetBuilder widgetFunc;
  @override
  Widget build(BuildContext context) {
    context.dependOnInheritedElement(stateX._inheritedElement!);
    return widgetFunc(context);
  }
}

/// Supply the Global Navigator and all its methods.
mixin NavigatorStateMethodsMixin {
  /// Whether the navigator can be popped.
  bool canPop() => App.router.canPop();

  /// Complete the lifecycle for a route that has been popped off the navigator.
  void finalizeRoute(Route<dynamic> route) => App.router.finalizeRoute(route);

  /// Consults the current route's [Route.willPop] method, and acts accordingly,
  /// potentially popping the route as a result; returns whether the pop request
  /// should be considered handled.
  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) =>
      App.router.maybePop<T>(result);

  /// Pop the top-most route off the navigator.
  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) => App.router.pop<T>(result);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.router.popAndPushNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Calls [pop] repeatedly until the predicate returns true.
  void popUntil(RoutePredicate predicate) => App.router.popUntil(predicate);

  /// Push the given route onto the navigator.
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) =>
      App.router.push<T>(route);

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
          Route<T> newRoute, RoutePredicate predicate) =>
      App.router.pushAndRemoveUntil<T>(newRoute, predicate);

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      App.router.pushNamed(routeName, arguments: arguments);

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate, {Object? arguments}) =>
      App.router.pushNamedAndRemoveUntil<T>(newRouteName, predicate,
          arguments: arguments);

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
          Route<T> newRoute,
          {TO? result}) =>
      App.router.pushReplacement<T, TO>(newRoute, result: result);

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.router.pushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Immediately remove `route` from the navigator, and [Route.dispose] it.
  void removeRoute(Route<dynamic> route) => App.router.removeRoute(route);

  /// Immediately remove a route from the navigator, and [Route.dispose] it. The
  /// route to be removed is the one below the given `anchorRoute`.
  void removeRouteBelow(Route<dynamic> anchorRoute) =>
      App.router.removeRouteBelow(anchorRoute);

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  void replace<T extends Object?>(
          {required Route<dynamic> oldRoute, required Route<T> newRoute}) =>
      App.router.replace<T>(oldRoute: oldRoute, newRoute: newRoute);

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>(
          {required Route<dynamic> anchorRoute, required Route<T> newRoute}) =>
      App.router
          .replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.router.restorablePopAndPushNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Push a new route onto the navigator.
  @optionalTypeArgs
  String restorablePush<T extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {Object? arguments}) =>
      App.router.restorablePush<T>(routeBuilder, arguments: arguments);

  /// Push a new route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
          RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate,
          {Object? arguments}) =>
      App.router.restorablePushAndRemoveUntil<T>(newRouteBuilder, predicate,
          arguments: arguments);

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      App.router.restorablePushNamed(routeName, arguments: arguments);

  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context, and then remove all the previous routes until
  /// the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate, {Object? arguments}) =>
      App.router.restorablePushNamedAndRemoveUntil<T>(newRouteName, predicate,
          arguments: arguments);

  /// Replace the current route of the navigator by pushing a new route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {TO? result,
          Object? arguments}) =>
      App.router.restorablePushReplacement<T, TO>(routeBuilder,
          result: result, arguments: arguments);

  /// Replace the current route of the navigator that most tightly encloses the
  /// given context by pushing the route named [routeName] and then disposing
  /// the previous route once the new route has finished animating in.
  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.router.restorablePushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  String restorableReplace<T extends Object?>(
          {required Route<dynamic> oldRoute,
          required RestorableRouteBuilder<T> newRouteBuilder,
          Object? arguments}) =>
      App.router.restorableReplace<T>(
          oldRoute: oldRoute,
          newRouteBuilder: newRouteBuilder,
          arguments: arguments);

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>(
          {required Route<dynamic> anchorRoute,
          required RestorableRouteBuilder<T> newRouteBuilder,
          Object? arguments}) =>
      App.router.restorableReplaceRouteBelow<T>(
          anchorRoute: anchorRoute,
          newRouteBuilder: newRouteBuilder,
          arguments: arguments);
}
