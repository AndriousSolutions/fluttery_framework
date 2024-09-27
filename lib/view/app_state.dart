// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  27 Oct 2020
//

// Replace 'dart:io' for Web applications

import '/controller.dart'
    show
        AppController,
        AppErrorHandler,
        AppWidgetErrorDisplayed,
        ReportErrorHandler;

import 'package:state_extended/state_extended.dart' as s
    show RouteObserverStates, StateX;

import '/view.dart';

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debug
    show
        debugPaintSizeEnabled,
        debugPaintBaselinesEnabled,
        debugPaintPointersEnabled,
        debugPaintLayerBordersEnabled,
        debugRepaintRainbowEnabled,
        debugRepaintTextRainbowEnabled;

import 'package:flutter/widgets.dart' as debug
    show
        debugPrintRebuildDirtyWidgets,
        debugOnRebuildDirtyWidget,
        debugPrintBuildScope,
        debugPrintScheduleBuildForStacks,
        debugPrintGlobalKeyedWidgetLifecycle,
        debugProfileBuildsEnabled,
        debugProfileBuildsEnabledUserWidgets,
        debugEnhanceBuildTimelineArguments,
        debugHighlightDeprecatedWidgets;

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
    bool? useRouterConfig,
    RouterConfig<Object>? routerConfig,
    BackButtonDispatcher? backButtonDispatcher,
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    Route<dynamic>? Function(RouteSettings settings)? onGenerateRoute,
    Route<dynamic>? Function(RouteSettings settings)? onUnknownRoute,
    bool Function(NavigationNotification notification)?
        onNavigationNotification,
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver>? navigatorObservers,
    TransitionBuilder? builder,
    String? title,
    String Function(BuildContext context)? onGenerateTitle,
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
    bool? debugPrintRebuildDirtyWidgets,
    // ignore: avoid_positional_boolean_parameters
    void Function(Element e, bool builtOnce)? debugOnRebuildDirtyWidget,
    bool? debugPrintBuildScope,
    bool? debugPrintScheduleBuildForStacks,
    bool? debugPrintGlobalKeyedWidgetLifecycle,
    bool? debugProfileBuildsEnabled,
    bool? debugProfileBuildsEnabledUserWidgets,
    bool? debugEnhanceBuildTimelineArguments,
    bool? debugHighlightDeprecatedWidgets,
    Map<LogicalKeySet, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    String? restorationScopeId,
    ScrollBehavior? scrollBehavior,
    this.maxMobileWidth,
    this.maxTabletWidth,
    super.errorHandler,
    super.errorScreen,
    super.errorReport,
    super.inErrorHandler,
    super.inErrorScreen,
    super.inErrorReport,
    super.presentError,
    super.inInitState,
    super.inInitAsync,
    super.inCatchAsyncError,
    super.inAsyncError,
    super.inHome,
    super.inRouteInformationProvider,
    super.inRouteInformationParser,
    super.inRouterDelegate,
    super.inRouterConfig,
    super.inBackButtonDispatcher,
    super.inRoutes,
    super.inInitialRoute,
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
    _useRouterConfig = useRouterConfig;
    _routerConfig = routerConfig;
    _backButtonDispatcher = backButtonDispatcher;
    _scaffoldMessengerKey = scaffoldMessengerKey;
    _routes = routes;
    _initialRoute = initialRoute;
    _onGenerateRoute = onGenerateRoute;
    _onUnknownRoute = onUnknownRoute;
    _onNavigationNotification = onNavigationNotification;
    _navigatorKey = navigatorKey;
    _navigatorObservers = navigatorObservers;
    _transitBuilder = builder;
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

    this.debugPrintRebuildDirtyWidgets = debugPrintRebuildDirtyWidgets ?? false;
    this.debugOnRebuildDirtyWidget = debugOnRebuildDirtyWidget;
    this.debugPrintBuildScope = debugPrintBuildScope ?? false;
    this.debugPrintScheduleBuildForStacks =
        debugPrintScheduleBuildForStacks ?? false;
    this.debugPrintGlobalKeyedWidgetLifecycle =
        debugPrintGlobalKeyedWidgetLifecycle ?? false;
    this.debugProfileBuildsEnabled = debugProfileBuildsEnabled ?? false;
    this.debugProfileBuildsEnabledUserWidgets =
        debugProfileBuildsEnabledUserWidgets ?? false;
    this.debugEnhanceBuildTimelineArguments =
        debugEnhanceBuildTimelineArguments ?? false;
    this.debugHighlightDeprecatedWidgets =
        debugHighlightDeprecatedWidgets ?? false;

    _shortcuts = shortcuts;
    _actions = actions;
    _restorationScopeId = restorationScopeId;
    _scrollBehavior = scrollBehavior;
  }

  /// The 'App State Objects' [Key]
  Key get key => _key ??= GlobalObjectKey(this);
  Key? _key;

  /// Allow the app to change the theme
  bool get allowChangeTheme => _allowChangeTheme;
  late bool _allowChangeTheme;

  /// Allow the app directly change the Locale
  bool get allowChangeLocale => _allowChangeLocale;
  late bool _allowChangeLocale;

  /// Allow the app to directly change the UI design
  bool get allowChangeUI => _allowChangeUI;
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

  /// This App is within another App
  bool get appInApp => _appInApp ?? false;
  // Assigned only once
  set appInApp(bool inApp) => _appInApp ??= inApp;
  bool? _appInApp;

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

  /// The traditional initState for the App's first State object
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
    _app = null;
    super.dispose();
  }

  /// The breakpoint used to determine whether the device is a mobile device or a tablet.
  final double? maxMobileWidth;

  /// The breakpoint used to determine whether the device is a tablet or a desktop.
  final double? maxTabletWidth;

  /// Override build to avoid the built-in Future Builder.
  @override
  Widget build(BuildContext context) => Sizer(
        builder: (context, orientation, deviceType) => buildF(context),
        maxMobileWidth: maxMobileWidth ?? 599,
        maxTabletWidth: maxTabletWidth,
      );

  // Called by buildF()
  @override
  Widget builder(BuildContext context) {
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

      /// Log how widgets are built
      debug.debugPrintRebuildDirtyWidgets = this.debugPrintRebuildDirtyWidgets;
      debug.debugOnRebuildDirtyWidget = this.debugOnRebuildDirtyWidget;
      debug.debugPrintBuildScope = this.debugPrintBuildScope;
      debug.debugPrintScheduleBuildForStacks =
          this.debugPrintScheduleBuildForStacks;
      debug.debugPrintGlobalKeyedWidgetLifecycle =
          this.debugPrintGlobalKeyedWidgetLifecycle;
      debug.debugProfileBuildsEnabled = this.debugProfileBuildsEnabled;
      debug.debugProfileBuildsEnabledUserWidgets =
          this.debugProfileBuildsEnabledUserWidgets;
      debug.debugEnhanceBuildTimelineArguments =
          this.debugEnhanceBuildTimelineArguments;
      debug.debugHighlightDeprecatedWidgets =
          this.debugHighlightDeprecatedWidgets;

      // If running in a tester. Don't open the Widget tree inspector.
      if (WidgetsBinding.instance is WidgetsFlutterBinding) {
        WidgetsBinding.instance.debugShowWidgetInspectorOverrideNotifier.value =
            _debugShowWidgetInspector ?? false;
      }
      return true;
    }());

    // If supplied by a function
    _routerConfig ??= onRouterConfig();

    // Set the flag only if the configuration was provided
    _useRouterConfig = _routerConfig != null && (_useRouterConfig ?? false);

    if (_useRouterConfig!) {
      // Make the GoRouter readily available without requiring a context.
      App.goRouter = _routerConfig;
    }

    // If the routerConfig is to be used, the others must all be null.
    _routeInformationProvider = _useRouterConfig!
        ? null
        : _routeInformationProvider ?? onRouteInformationProvider();

    _routeInformationParser = _useRouterConfig!
        ? null
        : _routeInformationParser ?? onRouteInformationParser();

    _routerDelegate =
        _useRouterConfig! ? null : _routerDelegate ?? onRouterDelegate();

    _backButtonDispatcher = _useRouterConfig!
        ? null
        : _backButtonDispatcher ?? onBackButtonDispatcher();

    // There's possibly a preferred Locale.
    // The app can specify its own Locale
    if (_allowChangeLocale && App.preferredLocale != null) {
      _locale = App.preferredLocale;
    } else {
      _locale = _locale ?? onLocale();
    }

    // If the locale was saved in the preferences, save the new one if any
    if (_allowChangeLocale) {
      App.saveLocale(_locale);
    }

    // Assign to the L10n
    // IMPORTANT assign L10n.locale before L10n.supportedLocales
    L10n.locale = _locale;

    // Can't be empty
    // Thus, only set once!
    if (_supportedLocales.isEmpty) {
      _supportedLocales =
          onSupportedLocales() ?? const <Locale>[Locale('en', 'US')];
      // Still empty
      if (_supportedLocales.isEmpty) {
        _supportedLocales = const <Locale>[Locale('en', 'US')];
      }
    }

    // Note, if it's not empty, it's not set
    // Can only set once!
    L10n.supportedLocales = _supportedLocales;

    // An app builder may instead by supplied.
    app = buildApp(this);

    if (app == null) {
      //
      if (_useCupertino) {
        // A CupertinoApp object has been supplied.
        if (cupertinoApp != null) {
          app = cupertinoApp!;
          //
        } else if (_routerDelegate == null && !_useRouterConfig!) {
          //
          app = CupertinoApp(
            key: key,
            navigatorKey: navigatorKey,
            theme: setiOSThemeData(context),
            routes: _routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
            initialRoute: _initialRoute ?? onInitialRoute(),
            onGenerateRoute: _onOnGenerateRoute,
            onUnknownRoute: _onOnUnknownRoute,
            onNavigationNotification: _onOnNavigationNotification,
            navigatorObservers: _onNavigatorObservers(),
            builder: _transitBuilder ?? onBuilder(),
// not needed  title: ,  // Using instead onOnGenerateTitle parameter
            onGenerateTitle: _onOnGenerateTitle,
            color: _color ?? onColor() ?? Colors.blue,
            locale: _locale,
            localizationsDelegates: _onLocalizationsDelegates(),
            localeListResolutionCallback:
                _localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                _localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay:
                _showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: _checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: _checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                _showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: _shortcuts ?? onShortcuts(),
            actions: _actions ?? onActions(),
            restorationScopeId: _restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: _scrollBehavior ?? onScrollBehavior(),
            // Let the parameters run before the home parameter.
            home: _home ?? onHome(),
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
            theme: setiOSThemeData(context),
            builder: _transitBuilder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            onNavigationNotification: _onOnNavigationNotification,
            color: _color ?? onColor() ?? Colors.blue,
            locale: _locale,
            localizationsDelegates: _onLocalizationsDelegates(),
            localeListResolutionCallback:
                _localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                _localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            showPerformanceOverlay:
                _showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: _checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: _checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                _showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: _shortcuts ?? onShortcuts(),
            actions: _actions ?? onActions(),
            restorationScopeId: _restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: _scrollBehavior ?? onScrollBehavior(),
          );
        }
      } else {
        // A MaterialApp object has been supplied.
        if (materialApp != null) {
          //
          app = materialApp!;
          //
        } else if (_routerDelegate == null && !_useRouterConfig!) {
          //
          app = MaterialApp(
            key: key,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: _scaffoldMessengerKey ??=
                onScaffoldMessengerKey(), // update getter
            routes: _routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
            initialRoute: _initialRoute ?? onInitialRoute(),
            onGenerateRoute: _onOnGenerateRoute,
            onUnknownRoute: _onOnUnknownRoute,
            onNavigationNotification: _onOnNavigationNotification,
            navigatorObservers: _onNavigatorObservers(),
            builder: _transitBuilder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            color: _color ?? onColor() ?? Colors.blue,
            theme: setThemeData(context),
            darkTheme: _darkTheme ?? onDarkTheme(),
            highContrastTheme: _highContrastTheme ?? onHighContrastTheme(),
            highContrastDarkTheme:
                _highContrastDarkTheme ?? onHighContrastDarkTheme(),
            themeMode: _themeMode ?? onThemeMode() ?? ThemeMode.system,
            themeAnimationDuration: _themeAnimationDuration ??
                onThemeAnimationDuration() ??
                const Duration(milliseconds: 200),
            themeAnimationCurve: _themeAnimationCurve ??
                onThemeAnimationCurve() ??
                Curves.linear,
            locale: _locale,
            localizationsDelegates: _onLocalizationsDelegates(),
            localeListResolutionCallback:
                _localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                _localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid:
                _debugShowMaterialGrid ?? onDebugShowMaterialGrid() ?? false,
            showPerformanceOverlay:
                _showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: _checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: _checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                _showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: _shortcuts ?? onShortcuts(),
            actions: _actions ?? onActions(),
            restorationScopeId: _restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: _scrollBehavior ?? onScrollBehavior(),
            // Let the parameters run before the home parameter.
            home: _home ?? onHome(),
          );
        } else {
          //
          app = MaterialApp.router(
            key: key,
            scaffoldMessengerKey: _scaffoldMessengerKey ??=
                onScaffoldMessengerKey(), // update getter
            routeInformationProvider: _routeInformationProvider,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            routerConfig: _routerConfig,
            backButtonDispatcher: _backButtonDispatcher,
            builder: _transitBuilder ?? onBuilder(),
// not needed          title: , // Used instead in _onOnGenerateTitle()
            onGenerateTitle: _onOnGenerateTitle,
            onNavigationNotification: _onOnNavigationNotification,
            color: _color ?? onColor() ?? Colors.blue,
            theme: setThemeData(context),
            darkTheme: _darkTheme ?? onDarkTheme(),
            highContrastTheme: _highContrastTheme ?? onHighContrastTheme(),
            highContrastDarkTheme:
                _highContrastDarkTheme ?? onHighContrastDarkTheme(),
            themeMode: _themeMode ?? onThemeMode() ?? ThemeMode.system,
            themeAnimationDuration: _themeAnimationDuration ??
                onThemeAnimationDuration() ??
                const Duration(milliseconds: 200),
            themeAnimationCurve: _themeAnimationCurve ??
                onThemeAnimationCurve() ??
                Curves.linear,
            locale: _locale,
            localizationsDelegates: _onLocalizationsDelegates(),
            localeListResolutionCallback:
                _localeListResolutionCallback ?? onLocaleListResolutionCallback,
            localeResolutionCallback:
                _localeResolutionCallback ?? onLocaleResolutionCallback,
            supportedLocales: _supportedLocales,
            debugShowMaterialGrid:
                _debugShowMaterialGrid ?? onDebugShowMaterialGrid() ?? false,
            showPerformanceOverlay:
                _showPerformanceOverlay ?? onShowPerformanceOverlay() ?? false,
            checkerboardRasterCacheImages: _checkerboardRasterCacheImages ??
                onCheckerboardRasterCacheImages() ??
                false,
            checkerboardOffscreenLayers: _checkerboardOffscreenLayers ??
                onCheckerboardOffscreenLayers() ??
                false,
            showSemanticsDebugger:
                _showSemanticsDebugger ?? onShowSemanticsDebugger() ?? false,
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner ??
                onDebugShowCheckedModeBanner() ??
                false,
            shortcuts: _shortcuts ?? onShortcuts(),
            actions: _actions ?? onActions(),
            restorationScopeId: _restorationScopeId ?? onRestorationScopeId(),
            scrollBehavior: _scrollBehavior ?? onScrollBehavior(),
          );
        }
      }
    }
    return app;
  }

  /// Supply the App widget if you wish.
  Widget? buildApp(AppState? appState) => null;

  /// Determine if the dependencies should be updated.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      onUpdateShouldNotify(oldWidget);

  /// Assigning the Cupertino theme
  CupertinoThemeData? setiOSThemeData(BuildContext context) {
    //
    CupertinoThemeData? cupertinoThemeData = _iOSTheme ?? oniOSTheme();

    if (_allowChangeTheme) {
      // If a saved preference
      final theme = App.iOSThemeData;
      if (theme != null) {
        cupertinoThemeData = theme;
      }
    }

    if (cupertinoThemeData == null) {
      // Possibly Material can provide
      final themeData = _theme ?? onTheme() ?? App.themeData;

      if (themeData == null) {
        // The original theme
        App.iOSThemeData ??= CupertinoTheme.of(context).resolveFrom(context);
      } else {
        // Assign the provided theme
        App.iOSThemeData = themeData;
      }
      cupertinoThemeData = App.iOSThemeData;
    } else {
      App.iOSThemeData = cupertinoThemeData;
    }
    return cupertinoThemeData;
  }

  /// Assigning the Material theme
  ThemeData? setThemeData(BuildContext context) {
    //
    ThemeData? themeData = _theme ?? onTheme();

    if (_allowChangeTheme) {
      // If a saved preference
      final theme = App.themeData;
      if (theme != null) {
        themeData = theme;
      }
    }

    // If not explicitly provided by the user
    if (themeData == null) {
      // possibly Cupertino can provide
      final cupertinoThemeData = _iOSTheme ?? oniOSTheme() ?? App.iOSThemeData;

      if (cupertinoThemeData == null) {
        // The original theme
        App.themeData ??= ThemeData.fallback(useMaterial3: false);
      } else {
        // Cupertino values
        App.themeData = cupertinoThemeData;
      }
      themeData = App.themeData;
    } else {
      App.themeData = themeData;
    }
    return themeData;
  }

  /// Rebuild the 'latest/current' State object and the 'root/first' State object
  /// This is to address the possibility an App has called another App.
  void refresh() {
    _AppState? state;
    if (_AppState._appInApp) {
      state = lastContext?.findAncestorStateOfType<_AppState>();
    }
    if (state == null) {
      lastState?.setState(() {});
      // Refresh the 'root' State object.
      super.setState(() {});
    } else {
      state.setState(() {});
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
    super.printEvents,
    this.materialApp,
    this.cupertinoApp,
    Locale? locale,
    this.errorHandler,
    this.errorScreen,
    this.errorReport,
    this.inErrorHandler,
    this.inErrorScreen,
    this.inErrorReport,
    this.presentError,
    this.inInitState,
    this.inInitAsync,
    this.inCatchAsyncError,
    this.inAsyncError,
    this.inHome,
    this.inRouteInformationProvider,
    this.inRouteInformationParser,
    this.inRouterDelegate,
    this.inRouterConfig,
    this.inBackButtonDispatcher,
    this.inRoutes,
    this.inInitialRoute,
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
//  })  : _statesRouteObserver = StatesRouteObserver(),
  }) : super(controller: controller) {
    // Listen to the device's connectivity.
    App.addConnectivityListener(controller);

    // Take in the parameters
    _locale = locale;

    // Supply a customized error handling.
    _errorHandler = AppErrorHandler(
        handler: errorHandler ?? onErrorHandler,
        presentError: presentError,
        screen: errorScreen ?? onErrorScreen, // has to be assigned
        report: errorReport ?? onErrorReport); // has to be assigned
  }

  // The App's error handler.
  AppErrorHandler? _errorHandler;

  /// The MaterialApp and CupertinoApp if provided.
  MaterialApp? materialApp;
  CupertinoApp? cupertinoApp;

  /// The App's 'home screen'
  Widget? _home;

  /// All the fields found in the widgets, MaterialApp and CupertinoApp
  RouteInformationProvider? _routeInformationProvider;

  RouteInformationParser<Object>? _routeInformationParser;

  RouterDelegate<Object>? _routerDelegate;

  BackButtonDispatcher? _backButtonDispatcher;

  /// Use RouterConfig or not
  bool? _useRouterConfig;

  RouterConfig<Object>? _routerConfig;
  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      _scaffoldMessengerKey;
  GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;
  Map<String, WidgetBuilder>? _routes;
  String? _initialRoute;
  RouteFactory? _onGenerateRoute;
  RouteFactory? _onUnknownRoute;

  /// Use this to navigate throughout the your app
  NavigatorState? get navigator => navigatorKey!.currentState;

  /// The Navigator State Key
  GlobalKey<NavigatorState>? get navigatorKey =>
      _navigatorKey ??= GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState>? _navigatorKey;

  List<NavigatorObserver>? _navigatorObservers;
  TransitionBuilder? _transitBuilder;

  String get title => _appTitle;
  String _appTitle = ''; // actual title
  late String _title;

  GenerateAppTitle? _onGenerateTitle;
  NotificationListenerCallback<NavigationNotification>?
      _onNavigationNotification;
  ThemeData? _theme;
  CupertinoThemeData? _iOSTheme;
  ThemeData? _darkTheme;
  ThemeData? _highContrastTheme;
  ThemeData? _highContrastDarkTheme;
  ThemeMode? _themeMode;
  Duration? _themeAnimationDuration;
  Curve? _themeAnimationCurve;

  Color? _color;

  Locale? get locale =>
      _locale ??
      (mounted ? Localizations.maybeLocaleOf(context) : null) ??
      _resolveLocales(
        // The full system-reported supported locales of the device.
        WidgetsBinding.instance.platformDispatcher.locales,
        supportedLocales,
      );

  set locale(Locale? locale) {
    if (locale != null &&
        (_supportedLocales.isEmpty || _supportedLocales.contains(locale))) {
      _locale = locale;
      L10n.locale = locale; // Ensure L10n is updated
    }
  }

  Locale? _locale;

  /// Determine the locale used by the Mobile phone.
  Locale? _resolveLocales(
    List<Locale>? preferredLocales,
    Iterable<Locale>? supportedLocales,
  ) {
    //
    final locales = supportedLocales;

    final LocaleListResolutionCallback localeResolver =
        _localeListResolutionCallback ?? onLocaleListResolutionCallback;

    // Attempt to use localeListResolutionCallback.
    Locale? locale;

    if (locales != null) {
      locale = localeResolver(preferredLocales, locales);
      if (locale != null) {
        return locale;
      }
    }

    final preferred = preferredLocales != null && preferredLocales.isNotEmpty
        ? preferredLocales.first
        : null;

    final LocaleResolutionCallback resolutionCallback =
        _localeResolutionCallback ?? onLocaleResolutionCallback;

    // localeListResolutionCallback failed, falling back to localeResolutionCallback.
    if (locales != null) {
      locale = resolutionCallback(preferred, locales);
      if (locale != null) {
        return locale;
      }
    }
    return preferred;
  }

  Iterable<LocalizationsDelegate<dynamic>>? _onLocalizationsDelegates() sync* {
    Iterable<LocalizationsDelegate<dynamic>>? delegates;
    if (_localizationsDelegates != null) {
      delegates = _localizationsDelegates;
    } else {
      delegates = onLocalizationsDelegates();
    }
    if (delegates != null) {
      yield* delegates;
    }
  }

  Iterable<LocalizationsDelegate<dynamic>>? _localizationsDelegates;

  LocaleListResolutionCallback? _localeListResolutionCallback;

  LocaleResolutionCallback? _localeResolutionCallback;

  List<Locale> get supportedLocales => _supportedLocales;
  late List<Locale> _supportedLocales;

  bool? _debugShowMaterialGrid;

  bool? _showPerformanceOverlay;

  bool? _checkerboardRasterCacheImages;

  bool? _checkerboardOffscreenLayers;

  bool? _showSemanticsDebugger;

  bool? _debugShowWidgetInspector;

  bool? _debugShowCheckedModeBanner;

  /// Highlights UI while debugging.
  late bool debugPaintSizeEnabled;
  late bool debugPaintBaselinesEnabled;
  late bool debugPaintPointersEnabled;
  late bool debugPaintLayerBordersEnabled;
  late bool debugRepaintRainbowEnabled;
  late bool debugRepaintTextRainbowEnabled;

  /// Log the dirty widgets that are built each frame.
  late bool debugPrintRebuildDirtyWidgets;

  /// Callback invoked for every dirty widget built each frame.
  // ignore: avoid_positional_boolean_parameters
  void Function(Element e, bool builtOnce)? debugOnRebuildDirtyWidget;

  /// Log all calls to [BuildOwner.buildScope].
  late bool debugPrintBuildScope;

  /// Log the call stacks that mark widgets as needing to be rebuilt.
  late bool debugPrintScheduleBuildForStacks;

  /// Log when widgets with global keys are deactivated and log when they are reactivated (retaken).
  late bool debugPrintGlobalKeyedWidgetLifecycle;

  /// Adds 'Timeline' events for every Widget built.
  late bool debugProfileBuildsEnabled;

  /// Adds 'Timeline' events for every user-created [Widget] built.
  late bool debugProfileBuildsEnabledUserWidgets;

  /// Adds debugging information to 'Timeline' events related to [Widget] builds.
  late bool debugEnhanceBuildTimelineArguments;

  /// Show banners for deprecated widgets.
  late bool debugHighlightDeprecatedWidgets;

  Map<LogicalKeySet, Intent>? _shortcuts;
  Map<Type, Action<Intent>>? _actions;
  String? _restorationScopeId;
  ScrollBehavior? _scrollBehavior;

  /// Used to complete asynchronous operations
  Future<bool> onInitAsync() async => await inInitAsync?.call() ?? false;

  /// Catch it if the initAsync() throws an error
  /// The FutureBuilder will fail, but you can examine the error
  void onCatchAsyncError(Object error) {}

  /// Catch it if the initAsync() throws an error
  /// The FutureBuilder will fail, but you can examine the error
  @override
  void catchAsyncError(Object error) {
    try {
      onCatchAsyncError(error);
    } catch (e) {
      final details = FlutterErrorDetails(
        exception: e,
        stack: e is Error ? e.stackTrace : null,
        library: 'app_state.dart',
        context: ErrorDescription('Exception in onCatchAsyncError()'),
      );
      logErrorDetails(details);
    }
    try {
      inCatchAsyncError?.call(error);
    } catch (e) {
      final details = FlutterErrorDetails(
        exception: e,
        stack: e is Error ? e.stackTrace : null,
        library: 'app_state.dart',
        context: ErrorDescription('Exception in inCatchAsyncError()'),
      );
      logErrorDetails(details);
    }
  }

  /// initAsync() has failed and a 'error' widget instead will be displayed.
  /// This takes in the snapshot.error details.
  @override
  void onAsyncError(FlutterErrorDetails details) => inAsyncError?.call(details);

  /// Returns the App's ScaffoldMessenger Key.
  GlobalKey<ScaffoldMessengerState> onScaffoldMessengerKey() =>
      _scaffoldMessengerKey ??= GlobalKey<ScaffoldMessengerState>();

  /// Returns the home screen if any.
  Widget? onHome() => inHome?.call();

  /// Returns the Route Provider if any.
  RouteInformationProvider? onRouteInformationProvider() =>
      inRouteInformationProvider?.call();

  /// Returns the Route Parser if any.
  RouteInformationParser<Object>? onRouteInformationParser() =>
      inRouteInformationParser?.call();

  /// Returns the Route Delegate if any.
  RouterDelegate<Object>? onRouterDelegate() => inRouterDelegate?.call();

  /// Returns the Route Config if any.
  RouterConfig<Object>? onRouterConfig() => inRouterConfig?.call();

  /// Returns the 'Back Button' routine if any.
  BackButtonDispatcher? onBackButtonDispatcher() =>
      inBackButtonDispatcher?.call();

  /// Returns a Map of Routes if any.
  Map<String, WidgetBuilder>? onRoutes() =>
      inRoutes?.call() ?? const <String, WidgetBuilder>{};

  /// Returns the initial Route if any.
  String? onInitialRoute() => inInitialRoute?.call();

  /// Returns the 'Generate Routes' routine if any.
  Route<dynamic>? onOnGenerateRoute(RouteSettings settings) => null;

  /// Returns the 'Unknown Route' if any.
  Route<dynamic>? onOnUnknownRoute(RouteSettings settings) => null;

  /// Called when a navigation event occurs
  /// Return true if you deem this change is handled.
  bool onOnNavigationNotification(NavigationNotification notification) => false;

  /// Returns a List of Navigation Observers if any.
  List<NavigatorObserver> onNavigatorObservers() => inNavigatorObservers != null
      ? inNavigatorObservers!()
      : const <NavigatorObserver>[];

  /// Supply the appropriate List of 'observers' that are called
  /// when a route is changed in the Navigator.
  List<NavigatorObserver> _onNavigatorObservers() {
    // Supply the StateX objects if any to observe the route changes
    final observers = <NavigatorObserver>[s.RouteObserverStates()];
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
  TransitionBuilder? onBuilder() => inTransBuilder?.call();

  /// Returns the App's title if any.
  String onTitle() => inTitle?.call() ?? '';

  Route<dynamic>? _onOnGenerateRoute(RouteSettings settings) {
    Route<dynamic>? route;
    route = _onGenerateRoute?.call(settings);
    // Passed parameter takes precedence over the function below.
    route ??= onOnGenerateRoute(settings);
    return route;
  }

  Route<dynamic>? _onOnUnknownRoute(RouteSettings settings) {
    Route<dynamic>? route;
    route = _onUnknownRoute?.call(settings);
    // Passed parameter takes precedence over the function below.
    route ??= onOnUnknownRoute(settings);
    return route;
  }

  bool _onOnNavigationNotification(NavigationNotification notification) {
    final canHandlePop = _onNavigationNotification?.call(notification);
    final handled = onOnNavigationNotification(notification);
    return (canHandlePop ?? false) || handled;
  }

  /// Returns the supplied title of the app.
  // Note OnGenerateTitle takes precedence over the title parameter in WidgetsAppState class
  String _onOnGenerateTitle(BuildContext context) {
    //
    final genTitle = _onGenerateTitle ??
        (context) {
          // If no title parameter was passed.
          String title;
          if (_title.isEmpty) {
            title = onTitle();
            if (title.isEmpty && inGenerateTitle != null) {
              title = inGenerateTitle!(context);
            }
          } else {
            title = _title.trim();
          }
          return title;
        };
    // Assign the title to the getter, title
    return _appTitle = L10n.s(genTitle(context));
  }

  /// Returns the App's [ThemeData] if any.
  ThemeData? onTheme() => inTheme?.call();

  /// Returns the App's [CupertinoThemeData] if any.
  CupertinoThemeData? oniOSTheme() => iniOSTheme?.call();

  /// Returns the App's 'Dark Theme' [ThemeData] if any.
  ThemeData? onDarkTheme() => inDarkTheme?.call();

  /// Returns the App's 'High Contrast Theme' [ThemeData] if any.
  ThemeData? onHighContrastTheme() => inHighContrastTheme?.call();

  /// Returns the App's 'High Contrast Dark Theme' [ThemeData] if any.
  ThemeData? onHighContrastDarkTheme() => inHighContrastDarkTheme?.call();

  /// Returns the App's [ThemeMode] if any.
  ThemeMode? onThemeMode() => inThemeMode?.call() ?? ThemeMode.system;

  /// Returns the App's [ThemeMode] if any.
  Duration? onThemeAnimationDuration() =>
      inThemeAnimationDuration?.call() ?? const Duration(milliseconds: 200);

  /// Returns the App's [ThemeMode] if any.
  Curve? onThemeAnimationCurve() =>
      inThemeAnimationCurve?.call() ?? Curves.linear;

  /// Returns the App's [Color] if any.
  Color? onColor() => inColor?.call();

  /// Returns current [Locale] if any.
  Locale? onLocale() => inLocale?.call();

  /// Returns the 'Localization Delegates' if any.
  Iterable<LocalizationsDelegate<dynamic>>? onLocalizationsDelegates() =>
      inLocalizationsDelegates?.call();

  /// Returns 'Locale Resolutions' routine if any.
  Locale? onLocaleListResolutionCallback(
          List<Locale>? locales, Iterable<Locale> supportedLocales) =>
      inLocaleListResolutionCallback?.call(locales, supportedLocales);

  /// Returns 'Local Resolution' routine if any.
  /// Turn to the I10n class to provide the locale.
  Locale? onLocaleResolutionCallback(
          Locale? locale, Iterable<Locale> supportedLocales) =>
      inLocaleResolutionCallback?.call(
          locale, supportedLocales); // ?? L10n.localeResolutionCallback;

  /// Returns the Locale Iteration if any.
  List<Locale>? onSupportedLocales() => inSupportedLocales?.call();

  /// Returns 'Show Material Grid' boolean indicator if any.
  bool? onDebugShowMaterialGrid() => inDebugShowMaterialGrid?.call();

  /// Returns 'Show Performance Overlay' boolean indicator if any.
  bool? onShowPerformanceOverlay() => inShowPerformanceOverlay?.call() ?? false;

  /// Returns 'Raster Cache Checkerboard' boolean indicator if any.
  bool? onCheckerboardRasterCacheImages() =>
      inCheckerboardRasterCacheImages?.call() ?? false;

  /// Returns 'Off Screen Layers Checkerboard' boolean indicator if any.
  bool? onCheckerboardOffscreenLayers() =>
      inCheckerboardOffscreenLayers?.call() ?? false;

  /// Returns 'Show Semantics' boolean indicator if any.
  bool? onShowSemanticsDebugger() => inShowSemanticsDebugger?.call() ?? false;

  /// Returns 'Show Debug Banner' boolean indicator if any.
  bool? onDebugShowWidgetInspector() =>
      inDebugShowWidgetInspector?.call() ?? true;

  /// Returns 'Show Debug Banner' boolean indicator if any.
  bool? onDebugShowCheckedModeBanner() =>
      inDebugShowCheckedModeBanner?.call() ?? true;

  /// Returns Map of 'LogicalKeySets' if any.
  Map<LogicalKeySet, Intent>? onShortcuts() => inShortcuts?.call();

  /// Returns Map of 'Intent Actions' if any.
  Map<Type, Action<Intent>>? onActions() => inActions?.call();

  /// Returns the 'Restore Scope Id' routine if any.
  String? onRestorationScopeId() => inRestorationScopeId?.call();

  /// Returns the App's [ScrollBehavior] if any.
  ScrollBehavior? onScrollBehavior() => inScrollBehavior?.call();

  /// Perform asynchronous operations
  final Future<bool> Function()? inInitAsync;

  /// Catch initAsync() error
  final void Function(Object error)? inCatchAsyncError;

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
  final void Function(Object error)? inAsyncError;

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
  void activate() {
    _errorHandler?.activate();
    super.activate(); // IMPORTANT to call last
  }

  @override
  void deactivate() {
    _errorHandler?.deactivate();
    super.deactivate(); // IMPORTANT to call last
  }

  @override
  void dispose() {
    _errorHandler?.dispose();
    _errorHandler = null;
    super.dispose();
  }

  FlutterExceptionHandler? errorHandler;
  bool? presentError;
  ErrorWidgetBuilder? errorScreen;
  ReportErrorHandler? errorReport;

  final void Function(FlutterErrorDetails details)? inErrorHandler;

  final ErrorWidgetBuilder? inErrorScreen;

  final Future<void> Function(Object exception, StackTrace stack)?
      inErrorReport;

  /// Override to provide an 'overall' Error Handler for your app.
  void onErrorHandler(FlutterErrorDetails details) {}

  /// The Widget to display when an app's widget fails to display.
  /// Override if you like.
  Widget onErrorScreen(FlutterErrorDetails details) =>
      inErrorScreen?.call(details) ??
      AppWidgetErrorDisplayed(stackTrace: App.inDebugMode).builder(details);

  /// If there's a error reporting routine available.
  /// Override if you like
  Future<void> onErrorReport(Object exception, StackTrace stack) async {
    if (inErrorReport != null) {
      await inErrorReport!(exception, stack);
    }
  }

  /// A flag indicating we're running in the error routine.
  ///
  /// Set to avoid infinite loop if in errors in the error routine.
  bool inErrorRoutine = false;

  /// Supply an 'error handler' routine to fire when an error occurs.
  // details.exception, details.stack
  /// Override if you like to customize error handling.
  //  @mustCallSuper // Allow a complete override. gp
  @override
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (inErrorRoutine) {
      return;
    }
    // In case there's an error in this routine
    inErrorRoutine = true;

    // Call the latest SateX object's error routine
    // Possibly the error occurred there.
    onStateError(details);

    if (AppErrorHandler.presentError) {
      // Logs 'every' error as the error count is reset.
      logErrorDetails(details);
    }

    try {
      // Call the App's error handler.
      _errorHandler?.flutteryExceptionHandler?.call(details);
    } catch (e, stack) {
      recordException(e, stack);
    }

    // Always test if there was an error in the error handler
    // Include it in the error reporting as well.
    if (hasError) {
      _onErrorInHandler();
    }

    try {
      // If an external handler was provided
      if (errorHandler != null) {
        onErrorHandler(details);
      }
      // If there's any 'inline function' error handler.
      // It takes last precedence.
      inErrorHandler?.call(details);
    } catch (e, stack) {
      recordException(e, stack);
    }
    // Always test if there was an error in the error handler
    // Include it in the error reporting as well.
    if (hasError) {
      _onErrorInHandler();
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

/// The extension of the State class.
///
/// dartdoc:
/// {@category Get started}
/// {@category StateX class}
/// {@category Testing}
class StateX<T extends StatefulWidget> extends s.StateX<T>
    with NavigatorStateMethodsMixin {
  /// Default useInherited to false
  StateX({
    super.controller,
    super.runAsync,
    super.useInherited,
    @Deprecated('Always route-aware now.') bool? routeAware,
    super.printEvents,
  });

  /// This function is wrapped in a Builder widget.
  /// If you don't use it, use the buildAndroid() or buildiOS() function.
  @override
  Widget builder(BuildContext context) =>
      App.useMaterial ? buildAndroid(context) : buildiOS(context);

  /// This is an optional function allowing you to make the distinction.
  /// Build the Android interface.
  /// By convention, this involves Material Interface
  Widget buildAndroid(BuildContext context) => const SizedBox();

  /// This is an optional function allowing you to make the distinction.
  /// Build the iOS interface.
  /// By convention, this involves Cupertino Interface
  /// Defaults to the Material interface design if called yet not implemented
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}

/// Supply the Global Navigator and all its methods.
mixin NavigatorStateMethodsMixin {
  /// Whether the navigator can be popped.
  bool canPop() => App.appState?.navigator?.canPop() ?? false;

  /// Complete the lifecycle for a route that has been popped off the navigator.
  void finalizeRoute(Route<dynamic> route) =>
      App.appState!.navigator?.finalizeRoute(route);

  /// Consults the current route's [Route.popDisposition] method, and acts
  /// accordingly, potentially popping the route as a result; returns whether
  /// the pop request should be considered handled.
  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) =>
      App.appState!.navigator!.maybePop<T>(result);

  /// Pop the top-most route off the navigator.
  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) =>
      App.appState!.navigator?.pop<T>(result);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.appState!.navigator!.popAndPushNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Calls [pop] repeatedly until the predicate returns true.
  void popUntil(RoutePredicate predicate) =>
      App.appState!.navigator?.popUntil(predicate);

  /// Push the given route onto the navigator.
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) =>
      App.appState!.navigator!.push<T>(route);

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
          Route<T> newRoute, RoutePredicate predicate) =>
      App.appState!.navigator!.pushAndRemoveUntil<T>(newRoute, predicate);

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      App.appState!.navigator!.pushNamed(routeName, arguments: arguments);

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate, {Object? arguments}) =>
      App.appState!.navigator!.pushNamedAndRemoveUntil<T>(
          newRouteName, predicate,
          arguments: arguments);

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
          Route<T> newRoute,
          {TO? result}) =>
      App.appState!.navigator!.pushReplacement<T, TO>(newRoute, result: result);

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.appState!.navigator!.pushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Immediately remove `route` from the navigator, and [Route.dispose] it.
  void removeRoute(Route<dynamic> route) =>
      App.appState!.navigator?.removeRoute(route);

  /// Immediately remove a route from the navigator, and [Route.dispose] it. The
  /// route to be removed is the one below the given `anchorRoute`.
  void removeRouteBelow(Route<dynamic> anchorRoute) =>
      App.appState!.navigator?.removeRouteBelow(anchorRoute);

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  void replace<T extends Object?>(
          {required Route<dynamic> oldRoute, required Route<T> newRoute}) =>
      App.appState!.navigator!
          .replace<T>(oldRoute: oldRoute, newRoute: newRoute);

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>(
          {required Route<dynamic> anchorRoute, required Route<T> newRoute}) =>
      App.appState!.navigator!
          .replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.appState!.navigator!.restorablePopAndPushNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Push a new route onto the navigator.
  @optionalTypeArgs
  String restorablePush<T extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {Object? arguments}) =>
      App.appState!.navigator!
          .restorablePush<T>(routeBuilder, arguments: arguments);

  /// Push a new route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
          RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate,
          {Object? arguments}) =>
      App.appState!.navigator!.restorablePushAndRemoveUntil<T>(
          newRouteBuilder, predicate,
          arguments: arguments);

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      App.appState!.navigator!
          .restorablePushNamed(routeName, arguments: arguments);

  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context, and then remove all the previous routes until
  /// the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate, {Object? arguments}) =>
      App.appState!.navigator!.restorablePushNamedAndRemoveUntil<T>(
          newRouteName, predicate,
          arguments: arguments);

  /// Replace the current route of the navigator by pushing a new route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {TO? result,
          Object? arguments}) =>
      App.appState!.navigator!.restorablePushReplacement<T, TO>(routeBuilder,
          result: result, arguments: arguments);

  /// Replace the current route of the navigator that most tightly encloses the
  /// given context by pushing the route named [routeName] and then disposing
  /// the previous route once the new route has finished animating in.
  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      App.appState!.navigator!.restorablePushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments);

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  String restorableReplace<T extends Object?>(
          {required Route<dynamic> oldRoute,
          required RestorableRouteBuilder<T> newRouteBuilder,
          Object? arguments}) =>
      App.appState!.navigator!.restorableReplace<T>(
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
      App.appState!.navigator!.restorableReplaceRouteBelow<T>(
          anchorRoute: anchorRoute,
          newRouteBuilder: newRouteBuilder,
          arguments: arguments);
}
