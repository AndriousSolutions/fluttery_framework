import '/view.dart';

/// Supply a reference to the GoRouter itself.
///
///
/// dartdoc:
/// {@category Extensions}
extension GoRouterExtension on BuildContext {
  /// Get a location from route name and parameters.
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      App.goRouter?.namedLocation(name,
          pathParameters: pathParameters, queryParameters: queryParameters) ??
      '';

  /// Navigate to a location.
  void go(String location, {Object? extra}) {
    final router = App.goRouter;
    if (router == null) {
      push<void>(location, extra: extra);
    } else {
      router.go(location, extra: extra);
    }
  }

  /// Navigate to a named route.
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      App.goRouter?.goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  /// Push a location onto the page stack.
  Future<T?> push<T extends Object?>(String location, {Object? extra}) async {
    T? result;
    final router = App.goRouter;
    if (router == null) {
      result = await Navigator.pushNamed<T>(this, location, arguments: extra);
    } else {
      result = await router.push<T>(location, extra: extra);
    }
    return result;
  }

  /// Navigate to a named route onto the page stack.
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    T? result;
    final router = App.goRouter;
    if (router == null) {
      result = await Navigator.pushNamed<T>(this, name, arguments: extra);
    } else {
      result = await router.pushNamed<T>(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
    return result;
  }

  /// Returns `true` if there is more than 1 page on the stack.
  bool canPop() {
    bool canPop;
    final router = App.goRouter;
    if (router == null) {
      canPop = Navigator.canPop(this);
    } else {
      canPop = router.canPop();
    }
    return canPop;
  }

  /// Pop the top page off the Navigator's page stack by calling
  /// [Navigator.pop].
  void pop<T extends Object?>([T? result]) {
    final router = App.goRouter;
    if (router == null) {
      Navigator.pop<T>(this, result);
    } else {
      router.pop<T>(result);
    }
  }

  /// Replaces the top-most page of the page stack with the given URL location
  /// w/ optional query parameters, e.g. `/family/f2/person/p1?color=blue`.
  Future<T?> pushReplacement<T extends Object?>(String location,
          {Object? extra}) =>
      App.goRouter?.pushReplacement<T>(location, extra: extra) ??
      Future.value();

  /// Replaces the top-most page of the page stack with the named route w/
  /// optional parameters, e.g. `name='person', pathParameters={'fid': 'f2', 'pid':
  /// 'p1'}`.
  Future<T?> pushReplacementNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      App.goRouter?.pushReplacementNamed<T>(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      ) ??
      Future.value();

  /// Replaces the top-most page of the page stack with the given one but treats
  /// it as the same page.
  Future<T?> replace<T>(String location, {Object? extra}) async
//  => App.goRouter?.replace<T>(location, extra: extra) ?? Future.value();
  {
    T? result;
    final router = App.goRouter;
    if (router == null) {
      result = await Navigator.pushReplacementNamed<T, T>(
        this,
        location,
        arguments: extra,
      );
    } else {
      result = await router.replace<T>(location, extra: extra);
    }
    return result;
  }

  /// Replaces the top-most page with the named route and optional parameters,
  /// preserving the page key.
  Future<T?> replaceNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      App.goRouter?.replaceNamed<T>(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      ) ??
      Future.value();
}
