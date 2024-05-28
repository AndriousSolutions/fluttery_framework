//
import 'package:fluttery_framework/view.dart';

///
class StatesRouteObserver extends RouteObserver<Route<dynamic>> {
  /// Make a State object aware of route changes.
  bool subscribeState(State state) {
    //
    Route<dynamic>? route;

    var scribe = state is RouteAware;

    if (scribe) {
      //
      route = currentRoute;

      // // In fact, doesn't pop a route. Returns true at the start.
      // Navigator.popUntil(state.context, (r) {
      //   route = r;
      //   return true;
      // });
    }

    /// DO NOT USE ModalRoute.of()
    ///  I don't want to rebuilt the State objects with every Navigator change
//    route ??= ModalRoute.of(state.context); // InheritedWidget?!

    scribe = route != null;

    if (scribe) {
      // So to be informed when there are changes to route.
      subscribe(state as RouteAware, route);
    }

    return scribe;
  }

  /// Remove the State object as a route observer.
  bool unsubscribeState(State state) {
    //
    final un = state is RouteAware;

    if (un) {
      unsubscribe(state as RouteAware);
    }
    return un;
  }

  // /// Make a State object aware of route changes.
  // @override
  // void subscribe(RouteAware routeAware, Route<dynamic> route) {
  //   super.subscribe(routeAware, route);
  // }
  //
  // /// Remove the State object as a route observer.
  // @override
  // void unsubscribe(RouteAware routeAware) {
  //   super.unsubscribe(routeAware);
  // }

  @override
  // ignore: unnecessary_overrides
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = null;
    currentRoute = previousRoute;
    super.didPop(route, previousRoute);
  }

  @override
  // ignore: unnecessary_overrides
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = previousRoute;
    currentRoute = route;
    super.didPush(route, previousRoute);
  }

  ///
  Route<dynamic>? currentRoute;

  ///
  Route<dynamic>? previousRoute;
}

///
mixin StateXRouteAware {
  /// Called when the State's current route has been popped off.
  void didPopOff() {}
}
