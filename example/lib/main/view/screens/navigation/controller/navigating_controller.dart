// ignore_for_file: prefer_interpolation_to_compose_strings

import '/src/controller.dart';

import '/src/view.dart';

///
class NavController extends StateXController {
  ///
  factory NavController() => _this ??= NavController._();

  NavController._() {
    /// set up the necessary lists
    routes = appState?.onRoutes() ?? {};
    // if (routes.isEmpty) {
    //   keysList = [];
    //   routeList = [];
    // } else {
    //   keysList = routes.keys.toList(growable: false);
    //   routeList = routes.values.toList(growable: false);
    // }
    routesLength = routes.length;
  }

  static NavController? _this;

  // The State object
  late NavState _s;

  @override
  void initState() {
    super.initState();
    // Initialize the current State object
    _s = state as NavState;
    _s.title = _s.widget.runtimeType.toString();
    _s.routekey = '/${_s.title}';
    _s.index = routes.keys.toList(growable: false).indexOf(_s.routekey);
    lastRoute = _s.index == routesLength - 1;
    onFirstPage = _s.index == 0;
    canPopRoute = onFirstPage || _s.canPop();
  }

  ///
  late bool onFirstPage;

  ///
  late bool canPopRoute;

  ///
  late bool lastRoute;

  /// Routes Map
  late final Map<String, WidgetBuilder> routes;

  /// Length of the Routes Map
  int routesLength = 0;

  // ///
  // late final List<String> keysList;
  //
  // ///
  // late final List<WidgetBuilder> routeList;

  /// Record the last selected widget
  Key? key;

  /// Supply text to the widget
  static String? text;

  /// Main screen text
  String mainText = '';

  ///
  bool canPop() {
    final pop = _s.canPop();
    text = 'has returned $pop'.tr;
    setState(() {});
    return pop;
  }

  ///
  void finalizeRoute() {
    // _s.finalizeRoute(route);
    setState(() {});
  }

  ///
  Future<void> maybePop<T extends Object?>([T? result]) async {
    final pop = _s.canPop();
    if (pop) {
      await _s.maybePop<T>(result);
    } else {
      text = 'has returned $pop'.tr;
      setState(() {});
    }
  }

  ///
  void pop<T extends Object?>([T? result]) {
    final pop = _s.canPop();
    if (!pop) {
      text = ' Nothing to pop to.'.tr;
      setState(() {});
    } else {
      _s.pop<T>(result);
    }
  }

  ///
  void popAndPushNamed() {
    final name = _pushNextName(1);
    if (_notFirstPage() && name.isNotEmpty) {
      ReturnRouteFunctionType func;
      if (App.useMaterial) {
        func = (WidgetBuilder builder, RouteSettings settings) =>
            MaterialPageRoute<bool>(builder: builder, settings: settings);
      } else {
        func = (WidgetBuilder builder, RouteSettings settings) =>
            CupertinoPageRoute<bool>(builder: builder, settings: settings);
      }
      _s.popAndPushNamed<bool, bool>(name, result: true, arguments: func);
    }
  }

  ///
  void popUntil() {
    if (_notFirstPage()) {
      const predicate = '/Page02';
      final index = routes.keys.toList(growable: false).indexOf(predicate);
      if (index > _s.index) {
        routesLength = routesLength - (index - _s.index);
      }
      text = 'Pop until `$predicate`';
      _s.popUntil(ModalRoute.withName(predicate));
    }
  }

  ///
  Future<void> push() async {
    setState(() {});
    await _s.push<bool>(_nextRoute<bool>());
  }

  ///
  void pushAndRemoveUntil() {
    final name = _pushNextName(1);
    if (_notFirstPage() && name.isNotEmpty) {
      const predicate = '/Page01';
      text =
          'Push to $name onto the navigator, and then remove all the previous routes until the `$predicate` returns true.';
      _s.pushAndRemoveUntil<bool>(
          _nextRoute(name), ModalRoute.withName(predicate));
    }
  }

  ///
  void pushNamed() {
    final name = _pushNextName(1);
    if (name.isEmpty) {
      text = 'Unable to find the next page.'.tr;
      setState(() {});
    } else {
      //
      text = 'Pushed'.tr + ' ' + 'to'.tr + ' ' + name;
      ReturnRouteFunctionType func;
      if (App.useMaterial) {
        func = (WidgetBuilder builder, RouteSettings settings) =>
            MaterialPageRoute<bool>(builder: builder, settings: settings);
      } else {
        func = (WidgetBuilder builder, RouteSettings settings) =>
            CupertinoPageRoute<bool>(builder: builder, settings: settings);
      }
      _s.pushNamed<bool>(name, arguments: func);
    }
  }

  ///
  void pushNamedAndRemoveUntil() {
    final name = _pushNextName(1);
    if (_notFirstPage() && name.isNotEmpty) {
      const predicate = '/Page02';
      final index = routes.keys.toList(growable: false).indexOf(predicate);
      final currentIndex = _s.index;
      if (index > currentIndex) {
        routesLength = index - currentIndex;
      }
      text =
          'Push to $name onto the navigator, and then remove all the previous routes until the `$predicate` returns true.';
      _s.pushNamedAndRemoveUntil<bool>(name, ModalRoute.withName(predicate));
    }
  }

  ///
  void pushReplacement() {
    final name = _pushNextName(1);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.pushReplacement<bool, bool>(_nextRoute(name), result: true);
    } else {
      text = "Unable to find the next page for 'pushReplacement'.".tr;
      setState(() {});
    }
  }

  ///
  void pushReplacementNamed() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.pushReplacementNamed<bool, bool>(name);
    }
  }

  ///
  void removeRoute() {
    var name = _pushNextName(2);
    if (_notFirstPage()) {
      if (name.isEmpty) {
        name = _pushNextName();
      }
      if (name.isNotEmpty) {
        final key = _s.routekey;
        text = 'Removed'.tr + ' ' + key;
        _s.removeRoute(_nextRoute(name));
      }
    }
  }

  ///
  void removeRouteBelow() {
    // _s.removeRouteBelow(anchorRoute);
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void replace() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.replace<bool>(oldRoute: _nextRoute(key), newRoute: _nextRoute(name));
    }
  }

  ///
  void replaceRouteBelow() {
    // _s.replaceRouteBelow<T>(
    //   anchorRoute: anchorRoute,
    //   newRoute: newRoute,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePopAndPushNamed() {
    // _s.restorablePopAndPushNamed<T, U>(
    //   routeName,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePush() {
    // _s.restorablePush<T>(
    //   routeBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePushAndRemoveUntil() {
    // _s.restorablePushAndRemoveUntil<T>(
    //   newRouteBuilder,
    //   predicate,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePushNamed() {
    // _s.restorablePushNamed<T>(
    //   routeName,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePushNamedAndRemoveUntil() {
    // _s.restorablePushNamedAndRemoveUntil<T>(
    //   newRouteName,
    //   predicate,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePushReplacement() {
    // _s.restorablePushReplacement<T, U>(
    //   routeBuilder,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorablePushReplacementNamed() {
    // _s.restorablePushReplacementNamed<T, U>(
    //   routeName,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorableReplace() {
    // _s.restorableReplace<T>(
    //   oldRoute: oldRoute,
    //   newRouteBuilder: newRouteBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  ///
  void restorableReplaceRouteBelow() {
    // _s.restorableReplaceRouteBelow<T>(
    //   anchorRoute: anchorRoute,
    //   newRouteBuilder: newRouteBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState(() {});
  }

  /// Returns the route for the 'next' Widget
  PageRoute<T> _nextRoute<T extends Object?>([String? name]) {
    WidgetBuilder? builder;

    var index = _s.index;

    if (name != null) {
      // If provided a Route name
      builder = routes[name];
    } else {
      // The next one if any
      if (index + 1 < routesLength) {
        index++;
      }
    }
    //
    builder ??= routes.values.toList(growable: false)[index];

    PageRoute<T> route;
    if (App.useMaterial) {
      route = MaterialPageRoute<T>(
          settings: RouteSettings(name: name), builder: builder);
    } else {
      route = CupertinoPageRoute<T>(
          settings: RouteSettings(name: name), builder: builder);
    }
    return route;
  }

  /// The current position of the ListView 1
  double list01Offset = 0;

  /// The current position of the ListView 2
  double list02Offset = 0;

  String _pushNextName([int? increment]) {
    //
    var name = '';
    final keysList = routes.keys.toList(growable: false);
    final index = keysList.indexOf(_s.routekey);
    var push = index >= 0;
    if (push) {
      final next = index + (increment ?? 0);
      push = next < keysList.length;
      if (push) {
        name = keysList[next];
        text = 'Replaced with $name';
      } else {
        text = '';
      }
    }
    return name;
  }

  // Indicate can't be performed on the first page
  bool _notFirstPage() {
    final notFirstPage = _s.title != 'Page01';
    if (!notFirstPage) {
      text = "Can't on the first page.";
      setState(() {});
    }
    return notFirstPage;
  }
}
