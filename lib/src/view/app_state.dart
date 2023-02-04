///
/// Copyright (C) 2020 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  27 Oct 2020
///

// Replace 'dart:io' for Web applications

import 'package:universal_platform/universal_platform.dart';

import 'package:flutter/foundation.dart' show FlutterExceptionHandler, Key;

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:fluttery_framework/controller.dart' show AppController;

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

/// The View for the app. The 'look and feel' for the whole app.
class AppState<T extends StatefulWidget> extends _AppState<T> {
  /// Provide a huge array of options and features to the 'App State object.'
  AppState({
    this.key,
    this.home,
    AppController? controller,
    super.controllers,
    super.object,
    super.materialApp,
    super.cupertinoApp,
    super.navigatorKey,
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
  }) : super(controller: controller ?? AppController()) {
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
  @override
  // ignore: avoid_as
  T get widget => parentState?.widget as T;

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

    _navigatorKey = null;

    super.dispose();
  }

  /// Override build to avoid the built-in Future Builder. It's been run.
  @override
  Widget build(BuildContext context) => v.Sizer(
      builder: (context, orientation, deviceType) => buildWidget(context));

  /// Override to impose your own WidgetsApp (like CupertinoApp or MaterialApp)
  @override
  Widget buildChild(BuildContext context) {
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
      } else if (_routerDelegate == null) {
        //
        app = CupertinoApp(
          key: key ?? cupertinoKey,
          navigatorKey: navigatorKey ?? onNavigatorKey(),
          routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
          initialRoute: initialRoute ?? onInitialRoute(),
          onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
          onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
          navigatorObservers: navigatorObservers ??
              onNavigatorObservers() ??
              const <NavigatorObserver>[],
          builder: builder ?? onBuilder(),
          title: title = onTitle(),
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
      } else if (_routerDelegate == null) {
        app = MaterialApp(
          key: key ?? materialKey,
          navigatorKey: navigatorKey ?? onNavigatorKey(),
          scaffoldMessengerKey:
              scaffoldMessengerKey ?? onScaffoldMessengerKey(),
          routes: routes ?? onRoutes() ?? const <String, WidgetBuilder>{},
          initialRoute: initialRoute ?? onInitialRoute(),
          onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
          onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
          navigatorObservers: navigatorObservers ??
              onNavigatorObservers() ??
              const <NavigatorObserver>[],
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

  // @override
  // void dispose() {
  //   _navigatorKey = null;
  //   super.dispose();
  // }

  /// Override if you like to customize error handling.
  @override
  void onError(FlutterErrorDetails details) {
    // Don't call this routine within itself.
    if (_inError) {
      return;
    }
    _inError = true;
    // Note, the AppController's Error Handler takes precedence if any.
    if (controller != null && controller is AppController) {
      (controller! as AppController).onError(details);
    } else if (inError != null) {
      inError!(details);
    } else {
      super.onError(details);
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
      refreshLastState();
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

  /// Returns the App's Navigator's Key.
  GlobalKey<NavigatorState> onNavigatorKey() =>
      _navigatorKey ??= GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState>? _navigatorKey;

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
    FlutterExceptionHandler? errorHandler,
    ErrorWidgetBuilder? errorScreen,
    v.ReportErrorHandler? errorReport,
  }) : super(controller: controller) {
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

    // assert(() {
    //   /// Highlights UI while debugging.
    //   debug.debugPaintSizeEnabled = debugPaintSizeEnabled ?? false;
    //   debug.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled ?? false;
    //   debug.debugPaintPointersEnabled = debugPaintPointersEnabled ?? false;
    //   debug.debugPaintLayerBordersEnabled =
    //       debugPaintLayerBordersEnabled ?? false;
    //   debug.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled ?? false;
    //   debug.debugRepaintTextRainbowEnabled =
    //       debugRepaintRainbowEnabled ?? false;
    //   return true;
    // }());

    if (errorHandler != null || errorScreen != null || errorReport != null) {
      // Supply a customized error handling.
      _errorHandler = v.AppErrorHandler(
          handler: errorHandler, screen: errorScreen, report: errorReport);
    }
  }
//  final AppController? con;
  v.AppErrorHandler? _errorHandler;

  /// The MaterialApp and CupertinoApp if provided.
  MaterialApp? materialApp;
  CupertinoApp? cupertinoApp;

  /// All the fields found in the widgets, MaterialApp and CupertinoApp
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
    super.dispose();
  }
}

/// The Error Screen if something happens at start up.
class AppError extends AppState {
  /// Supply an Exception object from the startup error.
  AppError(Object exception, {Key? key})
      : super(home: _AppError(exception, key: key));
}

class _AppError extends StatefulWidget {
  //
  const _AppError(this.exception, {Key? key}) : super(key: key);
  final Object exception;
  @override
  State<StatefulWidget> createState() => _AppErrorState();
}

class _AppErrorState extends State<_AppError> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(widget.exception.toString()),
        ),
      );
}
