import 'package:flutter/material.dart';

/// A helper class. Manages the use of a RouteObserver that subscribes State objects.
class StateRouteObserver {
  /// A instance with one lone state observer.
  StateRouteObserver() {
    // Only need to instantiate once.
    routeObserver = RouteObserver<PageRoute<dynamic>>();
  }

  /// Supply the means to 'observe' the Flutter's routing mechanism
  late RouteObserver<PageRoute<dynamic>> routeObserver;

  /// Make a State object aware of route changes.
  bool subscribe(State state) {
    bool subscribed = state is RouteAware;
    if (subscribed) {
      final modelRoute = ModalRoute.of(state.context);
      subscribed = modelRoute != null && modelRoute is PageRoute;
      if (subscribed) {
        // So to be informed when there are changes to route.
        routeObserver.subscribe(state as RouteAware, modelRoute);
      }
    }
    return subscribed;
  }

  /// Remove the State object as a route observer.
  bool unsubscribe(State state) {
    final subscribed = state is RouteAware;
    if (subscribed) {
      routeObserver.unsubscribe(state as RouteAware);
    }
    return subscribed;
  }
}
