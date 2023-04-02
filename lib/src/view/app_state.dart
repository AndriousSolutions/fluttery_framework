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

import 'package:fluttery_framework/view.dart' as v
    show
        App,
        AppRouterDelegate,
        AppErrorHandler,
        AppRouteInformationParser,
        AppStateX,
        L10n,
        ReportErrorHandler,
        Sizer;

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debug;

import '../../view.dart';

/// The View for the app. The 'look and feel' for the whole app.
class AppState<T extends StatefulWidget> extends _AppState<T>
    with NavigatorStateMethodsMixin {
  /// Provide a huge array of options and features to the 'App State object.'
  AppState({
    this.key,
    this.home,
    AppController? controller,
    super.controllers,
    super.object,
    super.materialApp,
    super.cupertinoApp,
    @Deprecated('No longer available to the user.') super.navigatorKey,
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
    super.theme,
    super.iOSTheme,
    super.darkTheme,
    super.themeMode,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales,
    this.useMaterial,
    this.useCupertino,
    this.switchUI,
    super.debugShowMaterialGrid,
    super.showPerformanceOverlay,
    super.checkerboardRasterCacheImages,
    super.checkerboardOffscreenLayers,
    super.showSemanticsDebugger,
    super.debugShowCheckedModeBanner,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior,
    super.useInheritedMediaQuery,
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
    this.inThemeMode,
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
    this.inInheritedMediaQuery,
    this.inError,
    this.inAsyncError,
  })  : _stateRouteObserver = StateRouteObserver(),
        super(controller: controller ?? AppController()) {
    // In case null was explicitly passed in.
    useMaterial ??= false;
    useCupertino ??= false;
    switchUI ??= false;

    if (UniversalPlatform.isAndroid) {
      if (switchUI!) {
        useMaterial = false;
        useCupertino = true;
      } else if (useCupertino!) {
        useMaterial = false;
      } else {
        useMaterial = true;
        useCupertino = false;
      }
    } else if (UniversalPlatform.isIOS) {
      if (switchUI!) {
        useMaterial = true;
        useCupertino = false;
      } else if (useMaterial!) {
        useCupertino = false;
      } else {
        useMaterial = false;
        useCupertino = true;
      }
    } else {
      useMaterial = true;
      useCupertino = false;
    }

    // These ones can't be changed.
    _isMaterial = useMaterial;
    _isCupertino = useCupertino;
  }

  /// The 'App State Objects' [Key]
  final Key? key;

  /// The App's 'home screen'
  final Widget? home;

  /// Explicitly use the Material theme
  bool? useMaterial;

  /// Explicitly use the Cupertino theme
  bool? useCupertino;

  /// Use Cupertino UI in Android and vice versa.
  bool? switchUI;

  /// Is using the Material Design UI.
  bool? get isMaterial => _isMaterial;
  bool? _isMaterial;

  /// Is using the Cupertino Design UI.
  bool? get isCupertino => _isCupertino;
  bool? _isCupertino;

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

  /// Returns the App's [ThemeMode] if any.
  final ThemeMode? Function()? inThemeMode;

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

  /// Returns the App's 'Inherited Media Query' routine if any.
  final bool? Function()? inInheritedMediaQuery;

  /// Returns the App's 'Error Handler' if any.
  final void Function(FlutterErrorDetails details)? inError;

  /// Returns the App's 'Async Error Handler' if any.
  final bool? Function(FlutterErrorDetails details)? inAsyncError;

  // The error flag.
  bool _inError = false;

  /// Supply to the 'home' StatefulWidget
  /// Allows you to 're-create' the home widget's state object.
  @Deprecated('Prone to misuse. Recursive deactivation if used more than once.')
  static Key homeKey = UniqueKey();

  /// Reference the 'parent' State object
  State? get parentState => _parentState;
  State? _parentState;

  /// Set the 'parent' State object but only once!
  set parentState(State? state) => _parentState ??= state;

  /// Reference to the 'app' object.
  v.App? get app => _app;

  /// Set the 'app' object but only once!
  set app(v.App? app) => _app ??= app;

  /// The app's representation
  v.App? _app;

  /// You need to be able access the widget.
  // if parentState is null then AppStatefulWidget was likely not used.
  @override
  T get widget => (parentState?.widget ?? super.widget) as T;

  /// Used to complete asynchronous operations
  @override
  Future<bool> initAsync() async {
    var init = await super.initAsync();
    if (init && inInitAsync != null) {
      init = await inInitAsync!();
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
  Widget build(BuildContext context) => v.Sizer(
      // ignore: deprecated_member_use
      builder: (context, orientation, deviceType) => buildWidget(context));

  /// Override to impose your own WidgetsApp (like CupertinoApp or MaterialApp)
  @override
  Widget buildIn(BuildContext context) {
    //
    Widget app;

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

    final _routerDelegate = routerDelegate ?? onRouterDelegate();
    final _routerConfig = routerConfig ?? onRouterConfig();
    var _routeInformationParser =
        routeInformationParser ?? onRouteInformationParser();
    // Supply the appropriate parser for the developer.
    if (_routerDelegate is v.AppRouterDelegate &&
        _routeInformationParser == null) {
      _routeInformationParser = v.AppRouteInformationParser();
    }

    if (useCupertino!) {
      // A CupertinoApp object has been supplied.
      if (cupertinoApp != null) {
        app = cupertinoApp!;
        //
      } else if (_routerDelegate == null && _routerConfig == null) {
        //
        app = CupertinoApp(
          key: key ?? cupertinoKey,
          navigatorKey: v.App.navigatorKey,
          routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
          initialRoute: initialRoute ?? onInitialRoute(),
          onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
          onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
          navigatorObservers: _navigatorObservers(),
          builder: builder ?? onBuilder(),
          title: title = onTitle(), // Important to assign an empty string
          onGenerateTitle: onGenerateTitle ?? onOnGenerateTitle(context),
          color: color ?? onColor() ?? Colors.blue,
          theme: _iosThemeData(),
          locale:
              onLocale() ?? locale, // locale gets assigned elsewhere so switch
          localizationsDelegates:
              localizationsDelegates ?? onLocalizationsDelegates(),
          localeListResolutionCallback:
              localeListResolutionCallback ?? onLocaleListResolutionCallback,
          localeResolutionCallback:
              localeResolutionCallback ?? onLocaleResolutionCallback,
          supportedLocales: v.App.supportedLocales = supportedLocales ??
              onSupportedLocales() ??
              const <Locale>[Locale('en', 'US')],
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
          useInheritedMediaQuery:
              useInheritedMediaQuery ?? onInheritedMediaQuery() ?? false,
          // Let the parameters run before the home parameter.
          home: home ?? onHome(),
        );
      } else {
        //
        app = CupertinoApp.router(
          key: key ?? cupertinoKey,
          routeInformationProvider:
              routeInformationProvider ?? onRouteInformationProvider(),
          routeInformationParser: _routeInformationParser,
          routerDelegate: _routerDelegate,
          routerConfig: _routerConfig,
          theme: _iosThemeData(),
          builder: builder ?? onBuilder(),
          title: title = onTitle(),
          onGenerateTitle: onGenerateTitle ?? onOnGenerateTitle(context),
          color: color ?? onColor() ?? Colors.blue,
          locale:
              onLocale() ?? locale, // locale gets assigned elsewhere so switch
          localizationsDelegates:
              localizationsDelegates ?? onLocalizationsDelegates(),
          localeListResolutionCallback:
              localeListResolutionCallback ?? onLocaleListResolutionCallback,
          localeResolutionCallback:
              localeResolutionCallback ?? onLocaleResolutionCallback,
          supportedLocales: v.App.supportedLocales = supportedLocales ??
              onSupportedLocales() ??
              const <Locale>[Locale('en', 'US')],
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
          useInheritedMediaQuery:
              useInheritedMediaQuery ?? onInheritedMediaQuery() ?? false,
        );
      }
    } else {
      // A MaterialApp object has been supplied.
      if (materialApp != null) {
        app = materialApp!;
        //
      } else if (_routerDelegate == null && _routerConfig == null) {
        //
        app = MaterialApp(
          key: key ?? materialKey,
          navigatorKey: v.App.navigatorKey,
          scaffoldMessengerKey:
              scaffoldMessengerKey ?? onScaffoldMessengerKey(),
          routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
          initialRoute: initialRoute ?? onInitialRoute(),
          onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
          onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
          navigatorObservers: _navigatorObservers(),
          builder: builder ?? onBuilder(),
          title: title = onTitle(),
          onGenerateTitle: onGenerateTitle ?? onOnGenerateTitle(context),
          color: color ?? onColor() ?? Colors.white,
          theme: _themeData(),
          darkTheme: darkTheme ?? onDarkTheme(),
          themeMode: themeMode ?? onThemeMode() ?? ThemeMode.system,
          locale:
              onLocale() ?? locale, // locale gets assigned elsewhere so switch
          localizationsDelegates: onLocalizationsDelegates(),
          localeListResolutionCallback:
              localeListResolutionCallback ?? onLocaleListResolutionCallback,
          localeResolutionCallback:
              localeResolutionCallback ?? onLocaleResolutionCallback,
          supportedLocales: v.App.supportedLocales = supportedLocales ??
              onSupportedLocales() ??
              const <Locale>[Locale('en', 'US')],
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
          useInheritedMediaQuery:
              useInheritedMediaQuery ?? onInheritedMediaQuery() ?? false,
          // Let the parameters run before the home parameter.
          home: home ?? onHome(),
        );
      } else {
        //
        app = MaterialApp.router(
          key: key ?? materialKey,
          scaffoldMessengerKey:
              scaffoldMessengerKey ?? onScaffoldMessengerKey(),
          routeInformationProvider:
              routeInformationProvider ?? onRouteInformationProvider(),
          routeInformationParser: _routeInformationParser,
          routerDelegate: _routerDelegate,
          routerConfig: _routerConfig,
          backButtonDispatcher:
              backButtonDispatcher ?? onBackButtonDispatcher(),
          builder: builder ?? onBuilder(),
          title: title = onTitle(),
          onGenerateTitle: onGenerateTitle ?? onOnGenerateTitle(context),
          color: color ?? onColor() ?? Colors.white,
          theme: _themeData(),
          darkTheme: darkTheme ?? onDarkTheme(),
          themeMode: themeMode ?? onThemeMode() ?? ThemeMode.system,
          locale:
              onLocale() ?? locale, // locale gets assigned elsewhere so switch
          localizationsDelegates: onLocalizationsDelegates(),
          localeListResolutionCallback:
              localeListResolutionCallback ?? onLocaleListResolutionCallback,
          localeResolutionCallback:
              localeResolutionCallback ?? onLocaleResolutionCallback,
          supportedLocales: v.App.supportedLocales = supportedLocales ??
              onSupportedLocales() ??
              const <Locale>[Locale('en', 'US')],
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
          useInheritedMediaQuery:
              useInheritedMediaQuery ?? onInheritedMediaQuery() ?? false,
        );
      }
    }

//     // The theme may not have been set. This property must have a value.
//     // Assign Flutter's current theme default
// //    v.App.themeData ??= ThemeData.light();
//     if (v.App.themeData == null) {
//       v.App.themeData = ThemeData.light();
//       // If a color is already stored in preferences, don't overwrite.
//       v.App.preferredTheme(
//           color: v.App.themeData!.primaryColor, overWrite: false);
//     }
//
//     // Supply the iOS theme if necessary.
//     v.App.iOSTheme ??=
//         MaterialBasedCupertinoThemeData(materialTheme: v.App.themeData!);

    return app;
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

  CupertinoThemeData? _iosThemeData() {
    // ignore: join_return_with_assignment
    v.App.iOSTheme = iOSTheme ??
        oniOSTheme() ??
        const CupertinoThemeData(brightness: Brightness.light);
    return v.App.iOSTheme;
  }

  ThemeData? _themeData() {
    // ignore: join_return_with_assignment
    v.App.themeData = theme ?? onTheme();
    return v.App.themeData;
  }

  /// Override if you like to customize error handling.
  @override
  @mustCallSuper
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (_inError) {
      return;
    }
    _inError = true;

    // If it involves the widgets library,
    // call the latest SateX object's error routine
    // Possibly the error occurred there.
    final library = details.library;
    if (library != null && library.contains('widgets library')) {
      final state = endState;
      if (state != null) {
        try {
          (state as StateX).onError(details);
        } catch (e, stack) {
          recordException(e, stack);
        }
        // Always test if there was an error in the error handler
        // Include it in the error reporting as well.
        if (hasError) {
          _onErrorInHandler();
        }
      }
    }

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

    _inError = false;
  }

  /// Rebuild the 'latest/current' State object and the 'root/first' State object
  /// This is to address the possibility an App has called another App.
  void refresh() {
    _AppState? _state;
    if (_AppState._appInApp) {
      _state = lastContext?.findAncestorStateOfType<_AppState>();
    }
    if (_state == null) {
      // Rebuild 'latest' State object if any.
      //rebuildLastState();
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
    v.App.hotReload = true;
    super.reassemble();
  }

  /// Explicitly change to a particular interface.
  void changeUI(String? ui) {
    //
    if (ui == null || ui.isEmpty) {
      return;
    }

    ui = ui.trim();
    if (ui != 'Material' && ui != 'Cupertino') {
      return;
    }
    if (ui == 'Material') {
      useMaterial = true;
      useCupertino = false;
      switchUI = !UniversalPlatform.isAndroid;
    } else {
      useMaterial = false;
      useCupertino = true;
      switchUI = UniversalPlatform.isAndroid;
    }
    // Reload the whole App
    reload();
  }

  /// Reload the whole App
  void reload() => _parentState?.setState(() {});

  /// Returns the App's Navigator Key.
  @Deprecated("App's Navigator's Key is GlobalKey<NavigatorState>()")
  GlobalKey<NavigatorState> onNavigatorKey() => v.App.navigatorKey;

  /// Returns the App's ScaffoldMessenger Key.
  GlobalKey<ScaffoldMessengerState> onScaffoldMessengerKey() =>
      _scaffoldMessengerKey ??= GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;

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
  String onTitle() => inTitle != null ? inTitle!() : title ?? '';

  /// Returns the 'Generate Title' routine if any.
  GenerateAppTitle? onOnGenerateTitle(BuildContext context) =>
      inGenerateTitle ?? (context) => v.L10n.s(onTitle());

  /// Returns the App's [ThemeData] if any.
  ThemeData? onTheme() => inTheme != null ? inTheme!() : null;

  /// Returns the App's [CupertinoThemeData] if any.
  CupertinoThemeData? oniOSTheme() => iniOSTheme != null ? iniOSTheme!() : null;

  /// Returns the App's 'Dark Theme' [ThemeData] if any.
  ThemeData? onDarkTheme() => inDarkTheme != null ? inDarkTheme!() : null;

  /// Returns the App's [ThemeMode] if any.
  ThemeMode? onThemeMode() =>
      inThemeMode != null ? inThemeMode!() : ThemeMode.system;

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
              locale, supportedLocales); // ?? v.L10n.localeResolutionCallback;

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

  /// Returns the App's 'Inherited Media Query' routine if any.
  bool? onInheritedMediaQuery() =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      inInheritedMediaQuery != null ? inInheritedMediaQuery!() : false;
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
    this.navigatorKey,
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
    this.title,
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.iOSTheme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
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
    this.useInheritedMediaQuery,
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
    v.App.addConnectivityListener(controller);
//    title ??= '';
//    color ??= Colors.blue;
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
    _errorHandler = v.AppErrorHandler(
        handler: errorHandler ?? onErrorHandler,
        screen: errorScreen ?? onErrorScreen,
        report: errorReport ?? onErrorReport);
  }

  /// Save the current Error Handler.
  final FlutterExceptionHandler? currentErrorFunc;

  // The App's error handler.
  v.AppErrorHandler? _errorHandler;

  /// The MaterialApp and CupertinoApp if provided.
  MaterialApp? materialApp;
  CupertinoApp? cupertinoApp;

  /// All the fields found in the widgets, MaterialApp and CupertinoApp
  @Deprecated('No longer assignable by user. Is now provided internally.')
  GlobalKey<NavigatorState>? navigatorKey;
  RouteInformationProvider? routeInformationProvider;
  RouteInformationParser<Object>? routeInformationParser;
  RouterDelegate<Object>? routerDelegate;
  RouterConfig<Object>? routerConfig;
  BackButtonDispatcher? backButtonDispatcher;
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  Map<String, WidgetBuilder>? routes;
  String? initialRoute;
  RouteFactory? onGenerateRoute;
  RouteFactory? onUnknownRoute;
  List<NavigatorObserver>? navigatorObservers;
  TransitionBuilder? builder;
  String? title;
  GenerateAppTitle? onGenerateTitle;
  ThemeData? theme;
  CupertinoThemeData? iOSTheme;
  ThemeData? darkTheme;
  ThemeMode? themeMode;
  Color? color;
  Locale? locale;
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  LocaleListResolutionCallback? localeListResolutionCallback;
  LocaleResolutionCallback? localeResolutionCallback;
  List<Locale>? supportedLocales;
  bool? debugShowMaterialGrid;
  bool? showPerformanceOverlay;
  bool? checkerboardRasterCacheImages;
  bool? checkerboardOffscreenLayers;
  bool? showSemanticsDebugger;
  bool? debugShowWidgetInspector;
  bool? debugShowCheckedModeBanner;
  Map<LogicalKeySet, Intent>? shortcuts;
  Map<Type, Action<Intent>>? actions;
  String? restorationScopeId;
  ScrollBehavior? scrollBehavior;
  bool? useInheritedMediaQuery;

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
  v.ReportErrorHandler? errorReport;

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
      v.App.onError(details);
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
          v.App.onError(details);
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
mixin StateXonErrorMixin<T extends StatefulWidget> on s.StateX<T> {
  /// This is called within the framework.
  void onError(FlutterErrorDetails details) {}
}

///
abstract class StateX<T extends StatefulWidget> extends s.StateX<T>
    with NavigatorStateMethodsMixin, StateXonErrorMixin {
  ///
  StateX([StateXController? _controller]) : super(_controller);

  /// Use this to navigate throughout the your app
  static NavigatorState get router => App.router;

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe this to be informed about changes to route.
    App.state?.subscribe(this);
  }

  @override
  @mustCallSuper
  void activate() {
    super.activate();
    // Subscribe this to be informed about changes to route.
    App.state?.subscribe(this);
  }

  @override
  @mustCallSuper
  void deactivate() {
    super.deactivate();
    // No longer informed about changes to its route.
    App.state?.unsubscribe(this);
  }
}

/// Supply a specific Controller to this StatelessWidget.
abstract class View<T extends StateXController> extends StatelessWidget {
  ///
  const View({Key? key}) : super(key: key);

  /// Supply the specified Controller.
  T? get controller => App.state?.controllerByType<T>();

  @override
  Widget build(BuildContext context);
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
