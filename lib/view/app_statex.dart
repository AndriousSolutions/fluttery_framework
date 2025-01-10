// ignore_for_file: avoid_positional_boolean_parameters

// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  27 Oct 2020
//

import 'dart:ui' as i show ParagraphStyle, TextStyle;

import 'package:flutter_test/flutter_test.dart' show Future, TestFailure;

import '/controller.dart'
    show
        App,
        AppErrorHandler,
        AppStateXController,
        AppWidgetErrorDisplayed,
        ReportErrorHandler,
        StateXController;

import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPageRoute, CupertinoTheme, CupertinoThemeData;

import 'package:flutter/foundation.dart' show FlutterExceptionHandler;

/// Translations
import 'package:l10n_translator/l10n.dart';

import 'package:state_extended/state_extended.dart' as s
    show AppStateX, RouteObserverStates, StateX;

import '/view.dart' as v;

import 'package:flutter/material.dart';

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

/// Replace 'dart:io' for Web applications
import 'package:universal_platform/universal_platform.dart';

///
/// The View for the app. The 'look and feel' for the whole app.
///
/// dartdoc:
/// {@category AppState class}
/// {@category Get started}
/// {@category StateX class}
/// {@category Error handling}

///
class AppStateX<T extends StatefulWidget> extends _AppState<T> {
  /// Provide a huge array of options and features to the 'App State object.'
  AppStateX({
    Key? key,
    Widget? home,
    AppStateXController? controller,
    super.controllers,
    super.object,
    super.notifyClientsInBuild,
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
    RebuildDirtyWidgetCallback? debugOnRebuildDirtyWidget,
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
    AnimationStyle? themeAnimationStyle,
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
    super.inDebugPaintSizeEnabled,
    super.inDebugPaintBaselinesEnabled,
    super.inDebugPaintPointersEnabled,
    super.inDebugPaintLayerBordersEnabled,
    super.inDebugRepaintRainbowEnabled,
    super.inDebugRepaintTextRainbowEnabled,
    super.inDebugPrintRebuildDirtyWidgets,
    super.inDebugOnRebuildDirtyWidget,
    super.inDebugPrintBuildScope,
    super.inDebugPrintScheduleBuildForStacks,
    super.inDebugPrintGlobalKeyedWidgetLifecycle,
    super.inDebugProfileBuildsEnabled,
    super.inDebugProfileBuildsEnabledUserWidgets,
    super.inDebugEnhanceBuildTimelineArguments,
    super.inDebugHighlightDeprecatedWidgets,
    super.inShortcuts,
    super.inActions,
    super.inRestorationScopeId,
    super.inScrollBehavior,
    super.inThemeAnimationStyle,
  }) : super(controller: controller ?? AppStateXController()) {
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
    _useRouterConfig = useRouterConfig ?? false;
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

    /// Development tools in Flutter's debug.dart
    this.debugPaintSizeEnabled = debugPaintSizeEnabled;
    this.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled;
    this.debugPaintPointersEnabled = debugPaintPointersEnabled;
    this.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled;
    this.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled;
    this.debugRepaintTextRainbowEnabled = debugRepaintTextRainbowEnabled;
    this.debugPrintRebuildDirtyWidgets = debugPrintRebuildDirtyWidgets;
    this.debugOnRebuildDirtyWidget = debugOnRebuildDirtyWidget;
    this.debugPrintBuildScope = debugPrintBuildScope;
    this.debugPrintScheduleBuildForStacks = debugPrintScheduleBuildForStacks;
    this.debugPrintGlobalKeyedWidgetLifecycle =
        debugPrintGlobalKeyedWidgetLifecycle;
    this.debugProfileBuildsEnabled = debugProfileBuildsEnabled;
    this.debugProfileBuildsEnabledUserWidgets =
        debugProfileBuildsEnabledUserWidgets;
    this.debugEnhanceBuildTimelineArguments =
        debugEnhanceBuildTimelineArguments;
    this.debugHighlightDeprecatedWidgets = debugHighlightDeprecatedWidgets;

    _debugShowMaterialGrid = debugShowMaterialGrid;
    _showPerformanceOverlay = showPerformanceOverlay;
    _checkerboardRasterCacheImages = checkerboardRasterCacheImages;
    _checkerboardOffscreenLayers = checkerboardOffscreenLayers;
    _showSemanticsDebugger = showSemanticsDebugger;
    _debugShowCheckedModeBanner = debugShowCheckedModeBanner;
    _debugShowWidgetInspector = debugShowWidgetInspector;

    _shortcuts = shortcuts;
    _actions = actions;
    _restorationScopeId = restorationScopeId;
    _scrollBehavior = scrollBehavior;
    _themeAnimationStyle = themeAnimationStyle;
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
  v.AppObject? get app => _app;

  /// Set the 'app' object but only once!
  set app(v.AppObject? app) => _app ??= app;

  /// The app's representation
  v.AppObject? _app;

  /// You need to be able access the widget.
  // if parentState is null then AppStatefulWidget was likely not used.
  @override
  T get widget => (parentState?.widget ?? super.widget) as T;

  /// The breakpoint used to determine whether the device is a mobile device or a tablet.
  double get maxMobileWidth => parentState == null
      ? 599
      : (parentState!.widget as v.AppStatefulWidget).onMaxMobileWidth() ?? 599;

  /// The breakpoint used to determine whether the device is a tablet or a desktop.
  double? get maxTabletWidth => parentState == null
      ? null
      : (parentState!.widget as v.AppStatefulWidget).onMaxTabletWidth();

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
    // Clear any listeners
    _navigationListeners.clear();
    super.dispose();
  }

  /// Override build to avoid the built-in Future Builder.
  @override
  Widget build(BuildContext context) => buildF(context);

  // Called by buildF()
  @override
  Widget builder(BuildContext context) {
    //
    Widget? app;

    assert(() {
      // Highlights UI while debugging.
      debug.debugPaintSizeEnabled =
          debugPaintSizeEnabled ?? onDebugPaintSizeEnabled() ?? false;
      // Causes each RenderBox to paint a line at each of its baselines.
      debug.debugPaintBaselinesEnabled =
          debugPaintBaselinesEnabled ?? onDebugPaintBaselinesEnabled() ?? false;
      // Causes objects like ['RenderPointerListener]' to flash when tapped.
      debug.debugPaintPointersEnabled =
          debugPaintPointersEnabled ?? onDebugPaintPointersEnabled() ?? false;
      // Causes each Layer to paint a box around its bounds.
      debug.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled ??
          onDebugPaintLayerBordersEnabled() ??
          false;
      // Overlay a rotating set of colors when repainting layers in debug mode.
      debug.debugRepaintRainbowEnabled =
          debugRepaintRainbowEnabled ?? onDebugRepaintRainbowEnabled() ?? false;
      // Overlay a rotating set of colors when repainting text in debug mode.
      debug.debugRepaintTextRainbowEnabled = debugRepaintTextRainbowEnabled ??
          onDebugRepaintTextRainbowEnabled() ??
          false;
      // Log the dirty widgets that are built each frame.
      debug.debugPrintRebuildDirtyWidgets =
          this.debugPrintRebuildDirtyWidgets ??
              onDebugPrintRebuildDirtyWidgets() ??
              false;
      // Callback invoked for every dirty widget built each frame.
      debug.debugOnRebuildDirtyWidget =
          this.debugOnRebuildDirtyWidget ?? onDebugOnRebuildDirtyWidget();
      // Log all calls to [BuildOwner.buildScope].
      debug.debugPrintBuildScope =
          this.debugPrintBuildScope ?? onDebugPrintBuildScope() ?? false;
      // Log the call stacks that mark widgets as needing to be rebuilt.
      debug.debugPrintScheduleBuildForStacks =
          this.debugPrintScheduleBuildForStacks ??
              onDebugPrintScheduleBuildForStacks() ??
              false;
      // Log when widgets with global keys are deactivated and log when they are reactivated.
      debug.debugPrintGlobalKeyedWidgetLifecycle =
          this.debugPrintGlobalKeyedWidgetLifecycle ??
              onDebugPrintGlobalKeyedWidgetLifecycle() ??
              false;
      // Adds [Timeline] events for every Widget built.
      debug.debugProfileBuildsEnabled = this.debugProfileBuildsEnabled ??
          onDebugProfileBuildsEnabled() ??
          false;
      // Adds [Timeline] events for every user-created [Widget] built.
      debug.debugProfileBuildsEnabledUserWidgets =
          this.debugProfileBuildsEnabledUserWidgets ??
              onDebugProfileBuildsEnabledUserWidgets() ??
              false;
      // Adds debugging information to [Timeline] events related to [Widget] builds.
      debug.debugEnhanceBuildTimelineArguments =
          this.debugEnhanceBuildTimelineArguments ??
              onDebugEnhanceBuildTimelineArguments() ??
              false;
      // Show banners for deprecated widgets.
      debug.debugHighlightDeprecatedWidgets =
          this.debugHighlightDeprecatedWidgets ??
              onDebugHighlightDeprecatedWidgets() ??
              false;

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
    _useRouterConfig = _routerConfig != null && _useRouterConfig;

    if (_useRouterConfig) {
      // Make the GoRouter readily available without requiring a context.
      v.App.goRouter = _routerConfig;
    } else {
      // Not to be used so not provided
      _routerConfig = null;
    }

    // If the routerConfig is to be used, the others must all be null.
    _routeInformationProvider = _useRouterConfig
        ? null
        : _routeInformationProvider ?? onRouteInformationProvider();

    _routeInformationParser = _useRouterConfig
        ? null
        : _routeInformationParser ?? onRouteInformationParser();

    _routerDelegate =
        _useRouterConfig ? null : _routerDelegate ?? onRouterDelegate();

    _backButtonDispatcher = _useRouterConfig
        ? null
        : _backButtonDispatcher ?? onBackButtonDispatcher();

    // There's possibly a preferred Locale.
    // The app can specify its own Locale
    if (_allowChangeLocale && v.App.preferredLocale != null) {
      _locale = v.App.preferredLocale;
    } else {
      _locale = _locale ?? onLocale();
    }

    // If the locale was saved in the preferences, save the new one if any
    if (_allowChangeLocale) {
      v.App.saveLocale(_locale);
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
        } else if (_routerDelegate == null && !_useRouterConfig) {
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
        } else if (_routerDelegate == null && !_useRouterConfig) {
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
            themeMode: _themeMode ?? onThemeMode(),
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
            themeAnimationStyle:
                _themeAnimationStyle ?? onThemeAnimationStyle(),
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
            themeMode: _themeMode ?? onThemeMode(),
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
            themeAnimationStyle:
                _themeAnimationStyle ?? onThemeAnimationStyle(),
          );
        }
      }
    }
    return app;
  }

  /// Supply the App widget if you wish.
  Widget? buildApp(AppStateX? appState) => null;

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
      final theme = v.App.iOSThemeData;
      if (theme != null) {
        cupertinoThemeData = theme;
      }
    }

    if (cupertinoThemeData == null) {
      // Possibly Material can provide
      final themeData = _theme ?? onTheme() ?? v.App.themeData;

      if (themeData == null) {
        // The original theme
        v.App.iOSThemeData ??= CupertinoTheme.of(context).resolveFrom(context);
      } else {
        // Assign the provided theme
        v.App.iOSThemeData = themeData;
      }
      cupertinoThemeData = v.App.iOSThemeData;
    } else {
      v.App.iOSThemeData = cupertinoThemeData;
    }
    return cupertinoThemeData;
  }

  /// Assigning the Material theme
  ThemeData? setThemeData(BuildContext context) {
    //
    ThemeData? themeData = _theme ?? onTheme();

    if (_allowChangeTheme) {
      // If a saved preference
      final theme = v.App.themeData;
      if (theme != null) {
        themeData = theme;
      }
    }

    // If not explicitly provided by the user
    if (themeData == null) {
      // possibly Cupertino can provide
      final cupertinoThemeData =
          _iOSTheme ?? oniOSTheme() ?? v.App.iOSThemeData;

      if (cupertinoThemeData == null) {
        // The original theme
        v.App.themeData ??= ThemeData.fallback(useMaterial3: false);
      } else {
        // Cupertino values
        v.App.themeData = cupertinoThemeData;
      }
      themeData = v.App.themeData;
    } else {
      v.App.themeData = themeData;
    }
    return themeData;
  }

  /// Rebuild the 'latest/current' State object and the 'root/first' State object
  /// This is to address the possibility an App has called another v.App.
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
    v.App.hotReload = true;
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

/// Signature for the common boolean Function implementations.
typedef BooleanFunctionIndicatorCallback = bool? Function();

/// A function that returns a specific type
typedef ReturnRouteFunctionType = Route<dynamic> Function(
    WidgetBuilder builder, RouteSettings settings);

/// The underlying State object representing the App's View in the MVC pattern.
/// Allows for setting debug settings and defining the App's error routine.
abstract class _AppState<T extends StatefulWidget> extends s.AppStateX<T>
    with v.DebugPaintPrintProfileOptionsMixin {
  //
  _AppState({
    AppStateXController? controller,
    super.controllers,
    super.object,
    super.notifyClientsInBuild,
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
    BooleanFunctionIndicatorCallback? inDebugPaintSizeEnabled,
    BooleanFunctionIndicatorCallback? inDebugPaintBaselinesEnabled,
    BooleanFunctionIndicatorCallback? inDebugPaintPointersEnabled,
    BooleanFunctionIndicatorCallback? inDebugPaintLayerBordersEnabled,
    BooleanFunctionIndicatorCallback? inDebugRepaintRainbowEnabled,
    BooleanFunctionIndicatorCallback? inDebugRepaintTextRainbowEnabled,
    BooleanFunctionIndicatorCallback? inDebugPrintRebuildDirtyWidgets,
    RebuildDirtyWidgetCallback? inDebugOnRebuildDirtyWidget,
    BooleanFunctionIndicatorCallback? inDebugPrintBuildScope,
    BooleanFunctionIndicatorCallback? inDebugPrintScheduleBuildForStacks,
    BooleanFunctionIndicatorCallback? inDebugPrintGlobalKeyedWidgetLifecycle,
    BooleanFunctionIndicatorCallback? inDebugProfileBuildsEnabled,
    BooleanFunctionIndicatorCallback? inDebugProfileBuildsEnabledUserWidgets,
    BooleanFunctionIndicatorCallback? inDebugEnhanceBuildTimelineArguments,
    BooleanFunctionIndicatorCallback? inDebugHighlightDeprecatedWidgets,
    this.inShortcuts,
    this.inActions,
    this.inRestorationScopeId,
    this.inScrollBehavior,
    this.inThemeAnimationStyle,
  }) : super(controller: controller) {
    // Listen to the device's connectivity.
    v.App.addConnectivityListener(controller);

    // Take in the parameters
    _locale = locale;

    // Supply a customized error handling.
    _errorHandler = AppErrorHandler(
      handler: errorHandler,
      screen: errorScreen,
      report: errorReport ?? onErrorReport, // has to be assigned
      presentError: presentError,
    );

    this.inDebugPaintSizeEnabled = inDebugPaintSizeEnabled;
    this.inDebugPaintBaselinesEnabled = inDebugPaintBaselinesEnabled;
    this.inDebugPaintPointersEnabled = inDebugPaintPointersEnabled;
    this.inDebugPaintLayerBordersEnabled = inDebugPaintLayerBordersEnabled;
    this.inDebugRepaintRainbowEnabled = inDebugRepaintRainbowEnabled;
    this.inDebugRepaintTextRainbowEnabled = inDebugRepaintTextRainbowEnabled;
    this.inDebugPrintRebuildDirtyWidgets = inDebugPrintRebuildDirtyWidgets;
    this.inDebugOnRebuildDirtyWidget = inDebugOnRebuildDirtyWidget;
    this.inDebugPrintBuildScope = inDebugPrintBuildScope;
    this.inDebugPrintScheduleBuildForStacks =
        inDebugPrintScheduleBuildForStacks;
    this.inDebugPrintGlobalKeyedWidgetLifecycle =
        inDebugPrintGlobalKeyedWidgetLifecycle;
    this.inDebugProfileBuildsEnabled = inDebugProfileBuildsEnabled;
    this.inDebugProfileBuildsEnabledUserWidgets =
        inDebugProfileBuildsEnabledUserWidgets;
    this.inDebugEnhanceBuildTimelineArguments =
        inDebugEnhanceBuildTimelineArguments;
    this.inDebugHighlightDeprecatedWidgets = inDebugHighlightDeprecatedWidgets;
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
  bool _useRouterConfig = false;

  RouterConfig<Object>? _routerConfig;
  GlobalKey<ScaffoldMessengerState>? get scaffoldMessengerKey =>
      _scaffoldMessengerKey;
  GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;
  Map<String, WidgetBuilder>? _routes;
  String? _initialRoute;
  RouteFactory? _onGenerateRoute;
  RouteFactory? _onUnknownRoute;

  /// Use this to navigate throughout the your app
  NavigatorState? get navigator => navigatorState;
  NavigatorState? get navigatorState {
    if (_navigatorState == null) {
      _navigatorState = navigatorKey!.currentState;
      if (_navigatorState == null) {
        final context = lastContext;
        if (context != null) {
          _navigatorState = Navigator.maybeOf(context, rootNavigator: true);
        }
      }
    }
    return _navigatorState;
  }

  NavigatorState? _navigatorState;

  /// The Navigator State Key
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey ??=
      GlobalObjectKey<NavigatorState>(this); //GlobalKey<NavigatorState>();
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
  Map<LogicalKeySet, Intent>? _shortcuts;
  Map<Type, Action<Intent>>? _actions;
  String? _restorationScopeId;
  ScrollBehavior? _scrollBehavior;
  AnimationStyle? _themeAnimationStyle;

  // @override
  // void activate() {
  //   // Return the Error Handler
  //   _errorHandler?.activate();
  //   super.activate(); // IMPORTANT to call last
  // }

  // @override
  // void deactivate() {
  //   // Restore original Error Handler
  //   _errorHandler?.deactivate();
  //   super.deactivate(); // IMPORTANT to call last
  // }

  @override
  void dispose() {
    // Restore original Error Handler
    _errorHandler?.dispose();
    _errorHandler = null;
    super.dispose();
  }

  /// Used to complete asynchronous operations
  Future<bool> onInitAsync() async => await inInitAsync?.call() ?? true;

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
  void onAsyncError(FlutterErrorDetails details) {}

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

  ///
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    var route = _onOnGenerateRoute(settings);
    if (route == null) {
      final routes = onRoutes();
      if (routes != null) {
        final builder = routes[settings.name];
        if (builder != null) {
          if (settings.arguments != null &&
              settings.arguments is ReturnRouteFunctionType) {
            route = (settings.arguments as ReturnRouteFunctionType).call(builder, settings);
          } else if (App.useMaterial) {
            route = MaterialPageRoute<dynamic>(
                settings: settings, builder: builder);
          } else {
            route = CupertinoPageRoute<dynamic>(
                settings: settings, builder: builder);
          }
        }
      }
    }
    return route;
  }

  Route<dynamic>? _onOnGenerateRoute(RouteSettings settings) {
    Route<dynamic>? route;
    route = _onGenerateRoute?.call(settings);
    // Passed parameter takes precedence over the function below.
    route ??= onOnGenerateRoute(settings);
    return route;
  }

  ///
  Route<dynamic>? onUnknownRoute(RouteSettings settings) =>
      _onOnUnknownRoute(settings);

  Route<dynamic>? _onOnUnknownRoute(RouteSettings settings) {
    Route<dynamic>? route;
    route = _onUnknownRoute?.call(settings);
    // Passed parameter takes precedence over the function below.
    route ??= onOnUnknownRoute(settings);
    return route;
  }

  /// Navigation listeners.
  final Set<NotificationListenerCallback<NavigationNotification>>
      _navigationListeners = {};

  /// Add a Navigation listener.
  bool addNavigationListener(
      NotificationListenerCallback<NavigationNotification>? listener) {
    var add = listener != null;
    if (add) {
      add = _navigationListeners.add(listener);
    }
    return add;
  }

  /// Remove a Navigation listener.
  bool removeNavigationListener(
      NotificationListenerCallback<NavigationNotification>? listener) {
    var remove = listener != null;
    if (remove) {
      remove = _navigationListeners.remove(listener);
    }
    return remove;
  }

  bool _onOnNavigationNotification(NavigationNotification notification) {
    final canHandlePop = _onNavigationNotification?.call(notification);
    var handled = onOnNavigationNotification(notification);
    for (final listener in _navigationListeners) {
      if (!listener(notification)) {
        handled = false;
      }
    }
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

  /// Used to override the theme animation curve and duration.
  AnimationStyle? onThemeAnimationStyle() => inThemeAnimationStyle?.call();

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

  /// Used to override the theme animation curve and duration.
  final AnimationStyle? Function()? inThemeAnimationStyle;

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

  FlutterExceptionHandler? errorHandler;
  bool? presentError;
  ErrorWidgetBuilder? errorScreen;
  ReportErrorHandler? errorReport;

  final void Function(FlutterErrorDetails details)? inErrorHandler;

  final ErrorWidgetBuilder? inErrorScreen;

  final Future<void> Function(Object exception, StackTrace stack)?
      inErrorReport;

  /// Override to provide an 'overall' Error Handler for your app.
  void onErrorHandler(FlutterErrorDetails details) {
    _errorHandlerOverridden = false;
  }

  // Flag indicating function was overridden and not directly called
  bool _errorHandlerOverridden = true;

  /// The Widget to display when an app's widget fails to display.
  /// Override if you like.
  Widget? onErrorScreen(FlutterErrorDetails details) =>
      inErrorScreen?.call(details);

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
  @override
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (inErrorRoutine) {
      return;
    }
    // In case there's an error in this routine
    inErrorRoutine = true;

    try {
      // If handler not explicitly passed as a parameter
      var callOriginal = _errorHandler?.errorHandler == null;

      if (!callOriginal) {
        _errorHandler?.errorHandler?.call(details);
      }

      // Any 'on' Error handler
      onErrorHandler(details);

      // It would appear it was not overwritten
      callOriginal = callOriginal && !_errorHandlerOverridden;

      // No 'in-line' version
      callOriginal = callOriginal && inErrorHandler == null;

      if (callOriginal) {
        _errorHandler?.oldOnError?.call(details);
      } else {
        // 'inline function' error handler, takes last precedence.
        inErrorHandler?.call(details);
      }
    } catch (e, stack) {
      recordException(e, stack);
    }
    // Always test if there was an error in the error handler
    // Include it in the error reporting as well.
    if (hasError) {
      _onErrorInHandler();
    }

    // If in testing, after the supplied handler, call its Error handler
    // An `Error` is a failure that the programmer should have avoided.
    if ((details.exception is TestFailure || details.exception is Error) &&
        WidgetsBinding.instance is! WidgetsFlutterBinding) {
      _errorHandler?.oldOnError?.call(details);
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
          v.App.onError(details);
        } catch (e, stack) {
          // Error in the error handler? That's a pickle.
          recordException(e, stack);
        }
      }
    }
  }
}

/// Supply a customized Error Widget.
Widget defaultErrorWidgetBuilder(
  FlutterErrorDetails details, {
  i.ParagraphStyle? paragraphStyle,
  i.TextStyle? textStyle,
  EdgeInsets? padding,
  double? minimumWidth,
  Color? backgroundColor,
  CustomPainter? customPainter,
  bool? stackTrace,
}) =>
    AppWidgetErrorDisplayed(
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor,
      customPainter: customPainter,
      stackTrace: stackTrace ?? v.App.inDebugMode,
    ).builder(details);

/// The extension of the State class.
///
/// dartdoc:
/// {@category Get started}
/// {@category StateX class}
/// {@category Testing}
class StateX<T extends StatefulWidget> extends s.StateX<T>
    with v.RouteNavigatorMethodsMixin {
  /// Default useInherited to false
  StateX({
    super.controller,
    super.runAsync,
    super.useInherited,
    super.printEvents,
  });

  /// This function is wrapped in a Builder widget.
  /// If you don't use it, use the buildAndroid() or buildiOS() function.
  @override
  Widget builder(BuildContext context) =>
      v.App.useMaterial ? buildAndroid(context) : buildiOS(context);

  /// This is an optional function allowing you to make the distinction.
  /// Build the Android interface.
  /// By convention, this involves Material Interface
  Widget buildAndroid(BuildContext context) => const SizedBox();

  /// This is an optional function allowing you to make the distinction.
  /// Build the iOS interface.
  /// By convention, this involves Cupertino Interface
  /// Defaults to the Material interface design if called yet not implemented
  Widget buildiOS(BuildContext context) => buildAndroid(context);

  /// Returns the 'first' StateX object in the App
  AppStateX? get appState => super.rootState as AppStateX;

  /// Provide the 'main' controller to this 'State View.'
  @override
  StateXController? get controller {
    final con = super.controller;
    if (con == null) {
      return null;
    }
    return con as StateXController;
  }

  /// Retrieve a StateXController by its a unique String identifier.
  @override
  StateXController? controllerById(String? id) {
    final con = super.controllerById(id);
    if (con == null) {
      return null;
    }
    return con as StateXController;
  }
}
