// ignore_for_file: prefer_interpolation_to_compose_strings
import '/src/controller.dart';

import '/src/view.dart';

///
class NavController extends StateXController {
  ///
  factory NavController() => _this ??= NavController._();

  NavController._() {
    /// set up the necessary lists
    routes = rootState?.onRoutes() ?? {};
    if (routes.isEmpty) {
      keysList = [];
      routeList = [];
    } else {
      keysList = routes.keys.toList(growable: false);
      routeList = routes.values.toList(growable: false);
    }
  }

  static NavController? _this;

  // The State object
  late NavState _s;

  @override
  void initState() {
    super.initState();
    // Initialize the current State object
    _initNavState();
    onFirstPage = _s.title == 'Page01';
    canPopRoute = onFirstPage || _s.canPop();
    lastRoute = onFirstPage || (_s.index < keysList.length - 1);
  }

  ///
  late bool onFirstPage;

  ///
  late bool canPopRoute;

  ///
  late bool lastRoute;

  ///
  late final Map<String, WidgetBuilder> routes;

  ///
  late final List<String> keysList;

  ///
  late final List<WidgetBuilder> routeList;

  /// Record the last selected widget
  Key? key;

  /// Supply text to the widget
  String? text;

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
  Future<void> maybePop() async {
    final pop = _s.canPop();
    if (pop) {
      await _s.maybePop();
    } else {
      text = 'has returned $pop'.tr;
      setState(() {});
    }
  }

  ///
  void pop() {
    final pop = _s.canPop();
    if (!pop) {
      text = ' Nothing to pop to.'.tr;
      setState(() {});
    } else {
      _s.pop();
    }
  }

  ///
  void popAndPushNamed() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      _s.popAndPushNamed(name);
    }
  }

  ///
  void popUntil() {
    if (_notFirstPage()) {
      const predicate = '/Page02';
      text = 'Pop until `$predicate`';
      _s.popUntil(ModalRoute.withName(predicate));
    }
  }

  ///
  Future<void> push() async {
    setState(() {});
    await _s.push(_nextRoute());
  }

  ///
  void pushAndRemoveUntil() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      const predicate = '/Page02';
      text =
          'Push to $name onto the navigator, and then remove all the previous routes until the `$predicate` returns true.';
      _s.pushAndRemoveUntil(_nextRoute(name), ModalRoute.withName(predicate));
    }
  }

  ///
  void pushNamed() {
    final name = _pushNextName(1);
    if (name.isEmpty) {
      text = 'Unable to find the next page.'.tr;
      setState(() {});
    } else {
      text = 'Pushed'.tr + ' ' + 'to'.tr + ' ' + name;
      _s.pushNamed(name);
    }
  }

  ///
  void pushNamedAndRemoveUntil() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      const predicate = '/Page02';
      text =
          'Push to $name onto the navigator, and then remove all the previous routes until the `$predicate` returns true.';
      _s.pushNamedAndRemoveUntil(name, ModalRoute.withName(predicate));
    }
  }

  ///
  void pushReplacement() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.pushReplacement(_nextRoute(name));
    }
  }

  ///
  void pushReplacementNamed() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.pushReplacementNamed(name);
    }
  }

  ///
  void removeRoute() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Removed'.tr + ' ' + key;
      _s.removeRoute(_nextRoute(name));
    }
  }

  ///
  void removeRouteBelow() {
    // _s.removeRouteBelow(anchorRoute);
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void replace() {
    final name = _pushNextName(2);
    if (_notFirstPage() && name.isNotEmpty) {
      final key = _s.routekey;
      text = 'Replaced'.tr + ' ' + key + ' ' + 'with'.tr + ' ' + name;
      _s.replace(oldRoute: _nextRoute(key), newRoute: _nextRoute(name));
    }
  }

  ///
  void replaceRouteBelow() {
    // _s.replaceRouteBelow<T>(
    //   anchorRoute: anchorRoute,
    //   newRoute: newRoute,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePopAndPushNamed() {
    // _s.restorablePopAndPushNamed<T, U>(
    //   routeName,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePush() {
    // _s.restorablePush<T>(
    //   routeBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePushAndRemoveUntil() {
    // _s.restorablePushAndRemoveUntil<T>(
    //   newRouteBuilder,
    //   predicate,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePushNamed() {
    // _s.restorablePushNamed<T>(
    //   routeName,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePushNamedAndRemoveUntil() {
    // _s.restorablePushNamedAndRemoveUntil<T>(
    //   newRouteName,
    //   predicate,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePushReplacement() {
    // _s.restorablePushReplacement<T, U>(
    //   routeBuilder,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorablePushReplacementNamed() {
    // _s.restorablePushReplacementNamed<T, U>(
    //   routeName,
    //   result: result,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorableReplace() {
    // _s.restorableReplace<T>(
    //   oldRoute: oldRoute,
    //   newRouteBuilder: newRouteBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void restorableReplaceRouteBelow() {
    // _s.restorableReplaceRouteBelow<T>(
    //   anchorRoute: anchorRoute,
    //   newRouteBuilder: newRouteBuilder,
    //   arguments: arguments,
    // );
    text = 'NOT IMPLEMENTED YET.';
    setState((){});
  }

  ///
  void _initNavState() {
    //
    _s = state as NavState;

    if (_s.routekey.isEmpty) {
      _s.title = _s.widget.runtimeType.toString();
      _s.routekey = '/${_s.title}';
      _s.index = keysList.indexOf(_s.routekey);
      if (_s.index >= 0) {
        final prev = _s.index - 1;
        if (prev >= 0) {
          _s.prevWidget = routeList[prev].call(_s.context);
        }
        final next = _s.index + 1;
        if (next < routeList.length) {
          _s.nextWidget = routeList[next].call(_s.context);
        }
      }
    }
  }

  /// Returns the route for the 'next' Widget
  PageRoute<T> _nextRoute<T extends Object?>([String? name]) {
    WidgetBuilder? builder;
    // If provided a Route name
    if (name != null) {
      final index = keysList.indexOf(name);
      if (index > 0) {
        builder = routeList[index];
      }
    }

    // The State object itself will provide the 'next' Widget.
    builder ??= (BuildContext context) => (state as NavState).nextWidget!;

    PageRoute<T> route;
    if (App.useMaterial) {
      route = MaterialPageRoute<T>(builder: builder);
    } else {
      route = CupertinoPageRoute<T>(builder: builder);
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
