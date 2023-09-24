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
    Key? key,
    Widget? home,
    AppController? controller,
    super.controllers,
    super.object,
    super.materialApp,
    super.cupertinoApp,
    RouteInformationProvider? routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.useRouterConfig,
    RouterConfig<Object>? routerConfig,
    BackButtonDispatcher? backButtonDispatcher,
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver>? navigatorObservers,
    TransitionBuilder? builder,
    String? title,
    GenerateAppTitle? onGenerateTitle,
    Color? color,
    bool? allowChangeTheme,
    ThemeData? theme,
    CupertinoThemeData? iOSTheme,
    ThemeData? darkTheme,
    ThemeData? highContrastTheme,
    ThemeData? highContrastDarkTheme,
    ThemeMode? themeMode,
    Duration? themeAnimationDuration,
    Curve? themeAnimationCurve,
    bool? allowChangeLocale,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    LocaleListResolutionCallback? localeListResolutionCallback,
    LocaleResolutionCallback? localeResolutionCallback,
    List<Locale>? supportedLocales,
    bool? useMaterial,
    bool? useCupertino,
    bool? switchUI,
    bool? allowChangeUI,
    bool? debugShowMaterialGrid,
    bool? showPerformanceOverlay,
    bool? checkerboardRasterCacheImages,
    bool? checkerboardOffscreenLayers,
    bool? showSemanticsDebugger,
    bool? debugShowCheckedModeBanner,
    bool? debugShowWidgetInspector,
    bool? debugPaintSizeEnabled,
    bool? debugPaintBaselinesEnabled,
    bool? debugPaintPointersEnabled,
    bool? debugPaintLayerBordersEnabled,
    bool? debugRepaintRainbowEnabled,
    bool? debugRepaintTextRainbowEnabled,
    Map<LogicalKeySet, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    String? restorationScopeId,
    ScrollBehavior? scrollBehavior,
    super.errorHandler,
    super.errorScreen,
    super.errorReport,
    super.inErrorHandler,
    super.inErrorScreen,
    super.inErrorReport,
    super.inError,
    super.inInitState,
    super.inInitAsync,
    super.inHome,
    super.inRouteInformationProvider,
    super.inRouteInformationParser,
    super.inRouterDelegate,
    super.inRouterConfig,
    super.inBackButtonDispatcher,
    super.inRoutes,
    super.inInitialRoute,
    super.inOnGenerateRoute,
    super.inOnUnknownRoute,
    super.inNavigatorObservers,
    super.inUpdateShouldNotify,
    super.inTransBuilder,
    super.inTitle,
    super.inGenerateTitle,
    super.inTheme,
    super.iniOSTheme,
    super.inDarkTheme,
    super.inHighContrastTheme,
    super.inHighContrastDarkTheme,
    super.inThemeMode,
    super.inThemeAnimationDuration,
    super.inThemeAnimationCurve,
    super.inColor,
    super.inLocale,
    super.inLocalizationsDelegates,
    super.inLocaleListResolutionCallback,
    super.inLocaleResolutionCallback,
    super.inSupportedLocales,
    super.inDebugShowMaterialGrid,
    super.inShowPerformanceOverlay,
    super.inCheckerboardRasterCacheImages,
    super.inCheckerboardOffscreenLayers,
    super.inShowSemanticsDebugger,
    super.inDebugShowCheckedModeBanner,
    super.inShortcuts,
    super.inActions,
    super.inRestorationScopeId,
    super.inScrollBehavior,
    super.inAsyncError,
  }) : super(controller: controller ?? AppController()) {
    //
    _key = key;
    _home = home;
    _title = title ?? '';

    // Determine what the app can change at runtime
    _allowChangeTheme = allowChangeTheme ?? false;
    _allowChangeLocale = allowChangeLocale ?? false;
    _allowChangeUI = allowChangeUI ?? false;

    // In case null was explicitly passed in.
    _useMaterial = useMaterial ?? false;
    _useCupertino = useCupertino ?? false;
    _switchUI = switchUI ?? false;

    /// Set _useMaterial or _useCupertino to true
    _useMaterialOrCupertino();

    _routeInformationProvider = routeInformationProvider;
    _routeInformationParser = routeInformationParser;
    _routerDelegate = routerDelegate;
    _routerConfig = routerConfig;
    _backButtonDispatcher = backButtonDispatcher;
    _scaffoldMessengerKey = scaffoldMessengerKey;
    _routes = routes;
    _initialRoute = initialRoute;
    _onGenerateRoute = onGenerateRoute;
    _onUnknownRoute = onUnknownRoute;
    _navigatorObservers = navigatorObservers;
    _builder = builder;
    _onGenerateTitle = onGenerateTitle;
    _color = color;
    _theme = theme;
    _iOSTheme = iOSTheme;
    _darkTheme = darkTheme;
    _highContrastTheme = highContrastTheme;
    _highContrastDarkTheme = highContrastDarkTheme;
    _themeMode = themeMode;
    _themeAnimationDuration = themeAnimationDuration;
    _themeAnimationCurve = themeAnimationCurve;
    _locale = locale;
    _localizationsDelegates = localizationsDelegates;
    _localeListResolutionCallback = localeListResolutionCallback;
    _localeResolutionCallback = localeResolutionCallback;
    _supportedLocales = supportedLocales ?? [];
    _debugShowMaterialGrid = debugShowMaterialGrid;
    _showPerformanceOverlay = showPerformanceOverlay;
    _checkerboardRasterCacheImages = checkerboardRasterCacheImages;
    _checkerboardOffscreenLayers = checkerboardOffscreenLayers;
    _showSemanticsDebugger = showSemanticsDebugger;
    _debugShowCheckedModeBanner = debugShowCheckedModeBanner;
    _debugShowWidgetInspector = debugShowWidgetInspector;

    this.debugPaintSizeEnabled = debugPaintSizeEnabled ?? false;
    this.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled ?? false;
    this.debugPaintPointersEnabled = debugPaintPointersEnabled ?? false;
    this.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled ?? false;
    this.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled ?? false;
    this.debugRepaintTextRainbowEnabled =
        debugRepaintTextRainbowEnabled ?? false;

    _shortcuts = shortcuts;
    _actions = actions;
    _restorationScopeId = restorationScopeId;
    _scrollBehavior = scrollBehavior;
  }

  /// The 'App State Objects' [Key]
  Key get key => _key ??= GlobalKey(); // it!
  Key? _key;

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
    // If some inline initState() is defined.
    if (inInitState != null) {
      inInitState!();
    }
  }

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
      debug.debugPaintSizeEnabled = debugPaintSizeEnabled;
      debug.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled;
      debug.debugPaintPointersEnabled = debugPaintPointersEnabled;
      debug.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled;
      debug.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled;
      debug.debugRepaintTextRainbowEnabled = debugRepaintTextRainbowEnabled;
      return true;
    }());

    // If the flag was set to true and there is a Router Configuration.
    final _useRouter = (useRouterConfig ?? false) && routerConfig != null;

    // Make the GoRouter readily available without requiring a context.
    if (_useRouter) {
      App.goRouter = routerConfig;
    }

    // If the routerConfig is to be used, the others must all be null.
    _routeInformationProvider = _useRouter
        ? null
        : _routeInformationProvider ?? onRouteInformationProvider();

    _routeInformationParser = _useRouter
        ? null
        : _routeInformationParser ?? onRouteInformationParser();

    _routerDelegate = _useRouter ? null : _routerDelegate ?? onRouterDelegate();

    _backButtonDispatcher =
        _useRouter ? null : _backButtonDispatcher ?? onBackButtonDispatcher();

    // There's possibly a preferred Locale.
    Locale? _preferredLocale;

    // The app can specify its own Locale
    if (_allowChangeLocale) {
      _preferredLocale = App.preferredLocale;
    }

    _locale = _preferredLocale ?? _locale ?? onLocale();

    // If the locale was saved in the preferences, save the new one if any
    if (_preferredLocale != null) {
      App.saveLocale(_locale);
    }

    // Assign to the L10n
    // IMPORTANT assign L10n.locale before L10n.supportedLocales
    L10n.locale = _locale;

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
    app = buildApp(context);

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
            key: key,
            navigatorKey: App.navigatorKey,
            theme: _setiOSThemeData(),
            routes: routes,
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
            onUnknownRoute: onUnknownRoute,
            navigatorObservers: _onNavigatorObservers(),
            builder: builder,
// not needed  title: ,  // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color,
            locale: _locale,
            localizationsDelegates: localizationsDelegates,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
            scrollBehavior: scrollBehavior,
            // Let the parameters run before the home parameter.
            home: home,
          );
        } else {
          //
          app = CupertinoApp.router(
            key: key,
            routeInformationProvider: _routeInformationProvider,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            backButtonDispatcher: _backButtonDispatcher,
            routerConfig: _routerConfig,
            theme: _setiOSThemeData(),
            builder: builder,
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color,
            locale: _locale,
            localizationsDelegates: localizationsDelegates,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
            scrollBehavior: scrollBehavior,
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
            key: key,
            navigatorKey: App.navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            routes: routes,
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
            onUnknownRoute: onUnknownRoute,
            navigatorObservers: _onNavigatorObservers(),
            builder: builder,
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color,
            theme: _setThemeData(),
            darkTheme: darkTheme,
            highContrastTheme: highContrastTheme,
            highContrastDarkTheme: highContrastDarkTheme,
            themeMode: themeMode,
            themeAnimationDuration: themeAnimationDuration,
            themeAnimationCurve: themeAnimationCurve,
            locale: _locale,
            localizationsDelegates: onLocalizationsDelegates(),
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid: debugShowMaterialGrid,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
            scrollBehavior: scrollBehavior,
            // Let the parameters run before the home parameter.
            home: home,
          );
        } else {
          //
          app = MaterialApp.router(
            key: key,
            scaffoldMessengerKey: scaffoldMessengerKey,
            routeInformationProvider: _routeInformationProvider,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            routerConfig: _routerConfig,
            backButtonDispatcher: _backButtonDispatcher,
            builder: builder,
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: color,
            theme: _setThemeData(),
            darkTheme: darkTheme,
            highContrastTheme: highContrastTheme,
            highContrastDarkTheme: highContrastDarkTheme,
            themeMode: themeMode,
            themeAnimationDuration: themeAnimationDuration,
            themeAnimationCurve: themeAnimationCurve,
            locale: _locale,
            localizationsDelegates: onLocalizationsDelegates(),
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid: debugShowMaterialGrid,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
            scrollBehavior: scrollBehavior,
          );
        }
      }
    }
    return app;
  }

  /// Supply the App widget if you wish.
  Widget? buildApp(BuildContext context) => null;

  /// Determine if the dependencies should be updated.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      onUpdateShouldNotify(oldWidget);

  /// Assigning the Cupertino theme
  CupertinoThemeData? _setiOSThemeData() {
    //
    CupertinoThemeData? cupertinoThemeData = _iOSTheme ?? oniOSTheme();

    if (_allowChangeTheme) {
      cupertinoThemeData = App.iOSThemeData ??
          const CupertinoThemeData(brightness: Brightness.light);
    } else if (cupertinoThemeData == null) {
      //
      final themeData = _theme ?? onTheme();

      if (themeData == null) {
        cupertinoThemeData = App.iOSThemeData ??
            const CupertinoThemeData(brightness: Brightness.light);
      } else {
        App.iOSThemeData = themeData;
        cupertinoThemeData = App.iOSThemeData;
      }
    } else {
      App.iOSThemeData = cupertinoThemeData;
    }
    return cupertinoThemeData;
  }

  /// Assigning the Material theme
  ThemeData? _setThemeData() {
    //
    ThemeData? themeData = _theme ?? onTheme();

    if (_allowChangeTheme) {
      themeData = App.themeData;
    } else if (themeData == null) {
      final cupertinoThemeData = _iOSTheme ?? oniOSTheme();
      if (cupertinoThemeData == null) {
        themeData = App.themeData;
      } else {}
    } else {
      App.themeData = themeData;
    }
    return themeData;
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

  /// Base of the device, which interface design to use?
  void _useMaterialOrCupertino() {
    //
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
}

/// The underlying State object representing the App's View in the MVC pattern.
/// Allows for setting debug settings and defining the App's error routine.
abstract class _AppState<T extends StatefulWidget> extends AppStateX<T> {
  //
  _AppState({
    AppController? controller,
    super.controllers,
    super.object,
    this.materialApp,
    this.cupertinoApp,
    Locale? locale,
    this.errorHandler,
    this.errorScreen,
    this.errorReport,
    this.inErrorHandler,
    this.inErrorScreen,
    this.inErrorReport,
    this.inError,
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
    this.inUpdateShouldNotify,
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
    this.inDebugShowWidgetInspector,
    this.inDebugShowCheckedModeBanner,
    this.inShortcuts,
    this.inActions,
    this.inRestorationScopeId,
    this.inScrollBehavior,
    this.inAsyncError,
  })  : currentErrorFunc = FlutterError.onError,
        _stateRouteObserver = StateRouteObserver(),
        super(controller: controller) {
    // If a tester is running. Don't switch out its error handler.
    if (WidgetsBinding.instance is WidgetsFlutterBinding) {
      // Place a breakpoint at onError() function below to debug error.
      FlutterError.onError = _handleError;
    }
    // Listen to the device's connectivity.
    App.addConnectivityListener(controller);

    // Take in the parameters
    _locale = locale;

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

  /// The App's 'home screen'
  Widget? get home => _home ?? onHome();
  Widget? _home;

  /// All the fields found in the widgets, MaterialApp and CupertinoApp
  RouteInformationProvider? get routeInformationProvider =>
      _routeInformationProvider;
  RouteInformationProvider? _routeInformationProvider;

  RouteInformationParser<Object>? get routeInformationParser =>
      _routeInformationParser;
  RouteInformationParser<Object>? _routeInformationParser;

  RouterDelegate<Object>? get routerDelegate => _routerDelegate;
  RouterDelegate<Object>? _routerDelegate;

  BackButtonDispatcher? get backButtonDispatcher => _backButtonDispatcher;
  BackButtonDispatcher? _backButtonDispatcher;

  RouterConfig<Object>? get routerConfig => _routerConfig ?? onRouterConfig();
  RouterConfig<Object>? _routerConfig;

  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      _scaffoldMessengerKey ?? onScaffoldMessengerKey();
  GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;

  Map<String, WidgetBuilder> get routes =>
      _routes ?? onRoutes() ?? const <String, WidgetBuilder>{};
  Map<String, WidgetBuilder>? _routes;

  String? get initialRoute => _initialRoute ?? onInitialRoute();
  String? _initialRoute;

  RouteFactory? get onGenerateRoute => _onGenerateRoute ?? onOnGenerateRoute();
  RouteFactory? _onGenerateRoute;

  RouteFactory? get onUnknownRoute => _onUnknownRoute ?? onOnUnknownRoute();
  RouteFactory? _onUnknownRoute;

  List<NavigatorObserver>? get navigatorObservers => _onNavigatorObservers();
  List<NavigatorObserver>? _navigatorObservers;

  TransitionBuilder? get builder => _builder ?? onBuilder();
  TransitionBuilder? _builder;

  String get title => _appTitle;
  String _appTitle = ''; // actual title
  late String _title;

  GenerateAppTitle? get onGenerateTitle => _onOnGenerateTitle;
  GenerateAppTitle? _onGenerateTitle;

  ThemeData? _theme;
  CupertinoThemeData? _iOSTheme;

  ThemeData? get darkTheme => _darkTheme ?? onDarkTheme();
  ThemeData? _darkTheme;

  ThemeData? get highContrastTheme =>
      _highContrastTheme ?? onHighContrastTheme();
  ThemeData? _highContrastTheme;

  ThemeData? get highContrastDarkTheme =>
      _highContrastDarkTheme ?? onHighContrastDarkTheme();
  ThemeData? _highContrastDarkTheme;

  ThemeMode get themeMode => _themeMode ?? onThemeMode() ?? ThemeMode.system;
  ThemeMode? _themeMode;

  Duration get themeAnimationDuration =>
      _themeAnimationDuration ??
      onThemeAnimationDuration() ??
      const Duration(milliseconds: 200);
  Duration? _themeAnimationDuration;

  Curve get themeAnimationCurve =>
      _themeAnimationCurve ?? onThemeAnimationCurve() ?? Curves.linear;
  Curve? _themeAnimationCurve;

  Color get color => _color ?? onColor() ?? Colors.blue;
  Color? _color;

  Locale? get locale => _locale;
  Locale? _locale;

  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      _localizationsDelegates ?? onLocalizationsDelegates();
  Iterable<LocalizationsDelegate<dynamic>>? _localizationsDelegates;

  LocaleListResolutionCallback? get localeListResolutionCallback =>
      _localeListResolutionCallback ?? onLocaleListResolutionCallback;
  LocaleListResolutionCallback? _localeListResolutionCallback;

  LocaleResolutionCallback? get localeResolutionCallback =>
      _localeResolutionCallback ?? onLocaleResolutionCallback;
  LocaleResolutionCallback? _localeResolutionCallback;

  List<Locale> get supportedLocales => _supportedLocales;
  late List<Locale> _supportedLocales;

  bool get debugShowMaterialGrid =>
      _debugShowMaterialGrid ?? onDebugShowMaterialGrid() ?? false;
  set debugShowMaterialGrid(bool? debug) {
    if (debug != null) {
      _debugShowMaterialGrid = debug;
    }
  }

  bool? _debugShowMaterialGrid;

  bool get showPerformanceOverlay =>
      _showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false;
  set showPerformanceOverlay(bool? debug) {
    if (debug != null) {
      _showPerformanceOverlay = debug;
    }
  }

  bool? _showPerformanceOverlay;

  bool get checkerboardRasterCacheImages =>
      _checkerboardRasterCacheImages ??
      onCheckerboardRasterCacheImages() ??
      false;
  set checkerboardRasterCacheImages(bool? debug) {
    if (debug != null) {
      _checkerboardRasterCacheImages = debug;
    }
  }

  bool? _checkerboardRasterCacheImages;

  bool get checkerboardOffscreenLayers =>
      _checkerboardOffscreenLayers ?? onCheckerboardOffscreenLayers() ?? false;
  set checkerboardOffscreenLayers(bool? debug) {
    if (debug != null) {
      _checkerboardOffscreenLayers = debug;
    }
  }

  bool? _checkerboardOffscreenLayers;

  bool get showSemanticsDebugger =>
      _showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false;
  set showSemanticsDebugger(bool? debug) {
    if (debug != null) {
      _showSemanticsDebugger = debug;
    }
  }

  bool? _showSemanticsDebugger;

  bool get debugShowWidgetInspector =>
      _debugShowWidgetInspector ?? onDebugShowWidgetInspector() ?? false;
  set debugShowWidgetInspector(bool? debug) {
    if (debug != null) {
      _debugShowWidgetInspector = debug;
    }
  }

  bool? _debugShowWidgetInspector;

  bool get debugShowCheckedModeBanner =>
      _debugShowCheckedModeBanner ?? onDebugShowCheckedModeBanner() ?? false;
  set debugShowCheckedModeBanner(bool? debug) {
    if (debug != null) {
      _debugShowCheckedModeBanner = debug;
    }
  }

  bool? _debugShowCheckedModeBanner;

  /// Highlights UI while debugging.
  late bool debugPaintSizeEnabled;
  late bool debugPaintBaselinesEnabled;
  late bool debugPaintPointersEnabled;
  late bool debugPaintLayerBordersEnabled;
  late bool debugRepaintRainbowEnabled;
  late bool debugRepaintTextRainbowEnabled;

  Map<LogicalKeySet, Intent>? get shortcuts => _shortcuts ?? onShortcuts();
  Map<LogicalKeySet, Intent>? _shortcuts;

  Map<Type, Action<Intent>>? get actions => _actions ?? onActions();
  Map<Type, Action<Intent>>? _actions;

  String? get restorationScopeId =>
      _restorationScopeId ?? onRestorationScopeId();
  String? _restorationScopeId;

  ScrollBehavior? get scrollBehavior => _scrollBehavior ?? onScrollBehavior();
  ScrollBehavior? _scrollBehavior;

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
  List<NavigatorObserver> onNavigatorObservers() => inNavigatorObservers != null
      ? inNavigatorObservers!()
      : const <NavigatorObserver>[];

  /// Supply the appropriate List of 'observers' that are called
  /// when a route is changed in the Navigator.
  List<NavigatorObserver> _onNavigatorObservers() {
    // Supply the StateX objects to observe the route changes
    final observers = <NavigatorObserver>[_stateRouteObserver.routeObserver];
    // Observers from parameter?
    if (_navigatorObservers != null) {
      observers.addAll(_navigatorObservers!);
    }
    // Any observers from this function?
    final moreObservers = onNavigatorObservers();
    if (moreObservers.isNotEmpty) {
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

  /// Should update the built-in InheritedWidget's dependencies
  bool onUpdateShouldNotify(covariant InheritedWidget oldWidget) {
    bool should;
    if (inUpdateShouldNotify != null) {
      should = inUpdateShouldNotify!(oldWidget);
    } else {
      should = true;
    }
    return should;
  }

  /// Returns the 'Transition Builder' if any.
  TransitionBuilder? onBuilder() =>
      inTransBuilder != null ? inTransBuilder!() : null;

  /// Returns the App's title if any.
  String onTitle() => inTitle != null ? inTitle!() : '';

  /// Returns the supplied title of the app.
  // Note OnGenerateTitle takes precedence over the title parameter in WidgetsAppState class
  String _onOnGenerateTitle(BuildContext context) {
    //
    final genTitle = _onGenerateTitle ??
        inGenerateTitle ??
        (context) {
          // If no title parameter was passed.
          String title;
          if (_title.isEmpty) {
            title = onTitle();
          } else {
            title = _title.trim();
          }
          return title;
        };
    // Assign the title to the getter, title
    return _appTitle = L10n.s(genTitle(context));
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
  bool? onDebugShowWidgetInspector() =>
      inDebugShowWidgetInspector != null ? inDebugShowWidgetInspector!() : true;

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

  /// Should update the built-in InheritedWidget's dependencies
  final bool Function(InheritedWidget oldWidget)? inUpdateShouldNotify;

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

  /// Returns 'Show Debug Widget Inspector' boolean indicator if any.
  final bool? Function()? inDebugShowWidgetInspector;

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

  /// Returns the App's 'Async Error Handler' if any.
  final bool? Function(FlutterErrorDetails details)? inAsyncError;

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

  /// Returns the App's 'Error Handler' if any.
  final void Function(FlutterErrorDetails details)? inError;

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

  /// A flag indicating we're running in the error routine.
  ///
  /// Set to avoid infinite loop if in errors in the error routine.
  bool inErrorRoutine = false;

  /// Supply an 'error handler' routine to fire when an error occurs.
  // details.exception, details.stack
  /// Override if you like to customize error handling.
  // Allow a complete override. gp
  //  @mustCallSuper
  @override
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (inErrorRoutine) {
      return;
    }
    // In case there's an error in this routine
    inErrorRoutine = true;

    // The base Error Handler
    super.onError(details);

    try {
      // Call the App's error handler.
      App.onError(details);
    } catch (e, stack) {
      recordException(e, stack);
    }

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
          // Error in the error handler? That's a pickle.
          recordException(e, stack);
        }
      }
    }
  }
}

/// A State object that uses the built-in InheritedWidget
///
/// dartdoc:
/// {@category StateX class}
class StateIn<T extends StatefulWidget> extends StateX<T> {
  ///
  StateIn({StateXController? controller})
      : super(controller: controller, useInherited: true);
}

/// The extension of the State class.
///
/// dartdoc:
/// {@category Get started}
/// {@category StateX class}
/// {@category Testing}
class StateX<T extends StatefulWidget> extends s.StateX<T>
    with NavigatorStateMethodsMixin {
  ///
  StateX({super.controller, super.useInherited});

  @override
  void initState() {
    super.initState();
    _appState = App.appState;
  }

  late AppState? _appState;

  /// Use this function is wrapped in a Builder widget.
  Widget builder(BuildContext context) =>
      App.useMaterial ? buildAndroid(context) : buildiOS(context);

  /// This is an optional function allowing you to make the distinction.
  /// Build the Android interface.
  /// By convention, this involves Material Interface
  Widget buildAndroid(BuildContext context) => const SizedBox();

  /// This is an optional function allowing you to make the distinction.
  /// Build the iOS interface.
  /// By convention, this involves Cupertino Interface
  Widget buildiOS(BuildContext context) => const SizedBox();

  @override
  Widget buildIn(BuildContext context) => Builder(builder: builder);

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
