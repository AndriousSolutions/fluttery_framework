// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  01 Apr 2023
//

import '/view.dart';

/// Supply the Global Navigator and all its methods.
mixin RouteNavigatorMethodsMixin {
  /// Supply app's NavigatorState object
  NavigatorState? get appNavigator =>
      _appNavigator ??= App.appState?.navigatorState;

  // Make the effort to call this when thw app shuts down
  set appNavigator(NavigatorState? navigator) => _appNavigator = navigator;
  NavigatorState? _appNavigator;

  /// Whether the navigator can be popped.
  bool canPop() => appNavigator?.canPop() ?? false;

  /// Complete the lifecycle for a route that has been popped off the navigator.
  void finalizeRoute(Route<dynamic> route) =>
      appNavigator?.finalizeRoute(route);

  /// Consults the current route's [Route.popDisposition] method, and acts
  /// accordingly, potentially popping the route as a result; returns whether
  /// the pop request should be considered handled.
  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) async {
    final pop = await appNavigator?.maybePop<T>(result);
    return pop ?? false;
  }

  /// Pop the top-most route off the navigator.
  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) => appNavigator?.pop<T>(result);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {TO? result,
      Object? arguments}) async {
    final pop = await appNavigator?.popAndPushNamed<T, TO>(routeName,
        result: result, arguments: arguments);
    return pop;
  }

  /// Calls [pop] repeatedly until the predicate returns true.
  void popUntil(RoutePredicate predicate) => appNavigator?.popUntil(predicate);

  /// Push the given route onto the navigator.
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) async {
    final push = appNavigator?.push<T>(route);
    return push;
  }

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, RoutePredicate predicate) async {
    final push = appNavigator?.pushAndRemoveUntil<T>(newRoute, predicate);
    return push;
  }

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    final push = appNavigator?.pushNamed<T>(routeName, arguments: arguments);
    return push;
  }

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  @optionalTypeArgs
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String newRouteName, RoutePredicate predicate,
      {Object? arguments}) async {
    final push = appNavigator?.pushNamedAndRemoveUntil<T>(
        newRouteName, predicate,
        arguments: arguments);
    return push;
  }

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Route<T> newRoute,
      {TO? result}) async {
    final push =
        await appNavigator?.pushReplacement<T, TO>(newRoute, result: result);
    return push;
  }

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {TO? result,
      Object? arguments}) async {
    final push = await appNavigator?.pushReplacementNamed<T, TO>(routeName,
        result: result, arguments: arguments);
    return push;
  }

  /// Immediately remove `route` from the navigator, and [Route.dispose] it.
  void removeRoute(Route<dynamic> route) => appNavigator?.removeRoute(route);

  /// Immediately remove a route from the navigator, and [Route.dispose] it. The
  /// route to be removed is the one below the given `anchorRoute`.
  void removeRouteBelow(Route<dynamic> anchorRoute) =>
      appNavigator?.removeRouteBelow(anchorRoute);

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  void replace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
  }) =>
      appNavigator?.replace<T>(oldRoute: oldRoute, newRoute: newRoute);

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required Route<T> newRoute,
  }) =>
      appNavigator?.replaceRouteBelow<T>(
          anchorRoute: anchorRoute, newRoute: newRoute);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      appNavigator?.restorablePopAndPushNamed<T, TO>(routeName,
          result: result, arguments: arguments) ??
      '';

  /// Push a new route onto the navigator.
  @optionalTypeArgs
  String restorablePush<T extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {Object? arguments}) =>
      appNavigator?.restorablePush<T>(routeBuilder, arguments: arguments) ?? '';

  /// Push a new route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
          RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate,
          {Object? arguments}) =>
      appNavigator?.restorablePushAndRemoveUntil<T>(newRouteBuilder, predicate,
          arguments: arguments) ??
      '';

  /// Push a named route onto the navigator.
  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      appNavigator?.restorablePushNamed<T>(routeName, arguments: arguments) ??
      '';

  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context, and then remove all the previous routes until
  /// the `predicate` returns true.
  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate, {Object? arguments}) =>
      appNavigator?.restorablePushNamedAndRemoveUntil<T>(
          newRouteName, predicate,
          arguments: arguments) ??
      '';

  /// Replace the current route of the navigator by pushing a new route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
          RestorableRouteBuilder<T> routeBuilder,
          {TO? result,
          Object? arguments}) =>
      appNavigator?.restorablePushReplacement<T, TO>(routeBuilder,
          result: result, arguments: arguments) ??
      '';

  /// Replace the current route of the navigator that most tightly encloses the
  /// given context by pushing the route named [routeName] and then disposing
  /// the previous route once the new route has finished animating in.
  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      appNavigator?.restorablePushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments) ??
      '';

  /// Replaces a route on the navigator that most tightly encloses the given
  /// context with a new route.
  @optionalTypeArgs
  String restorableReplace<T extends Object?>(
          {required Route<dynamic> oldRoute,
          required RestorableRouteBuilder<T> newRouteBuilder,
          Object? arguments}) =>
      appNavigator?.restorableReplace<T>(
          oldRoute: oldRoute,
          newRouteBuilder: newRouteBuilder,
          arguments: arguments) ??
      '';

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>(
          {required Route<dynamic> anchorRoute,
          required RestorableRouteBuilder<T> newRouteBuilder,
          Object? arguments}) =>
      appNavigator?.restorableReplaceRouteBelow<T>(
          anchorRoute: anchorRoute,
          newRouteBuilder: newRouteBuilder,
          arguments: arguments) ??
      '';
}
