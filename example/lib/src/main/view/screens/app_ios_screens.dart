library;

//
import 'package:flutter/gestures.dart' show PointerDeviceKind;

import '/src/controller.dart' show AppErrorHandler;

// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

///
class TwoTabScaffold extends StatelessWidget {
  ///
  const TwoTabScaffold({
    super.key,
    required this.tab01,
    this.tab01Label,
    required this.tab02,
    this.tab02Label,
    this.currentIndex,
    this.appBar,
    this.navigationBar,
    this.persistentFooterButtons,
    this.useMaterial,
    this.useNavigator,
  });

  ///
  final WidgetBuilder tab01, tab02;

  ///
  final Map<String, Icon>? tab01Label, tab02Label;

  ///
  final int? currentIndex;

  ///
  final PreferredSizeWidget? appBar;

  ///
  final CupertinoNavigationBar? navigationBar;

  ///
  final List<Widget>? persistentFooterButtons;

  /// Use Material Navigation widgets
  final bool? useMaterial;

  /// Use Navigator so to utilize Routes.
  final bool? useNavigator;

  @override
  Widget build(BuildContext context) => _BottomBarScaffold(
        tab01: tab01,
        tab01Label: tab01Label,
        tab02: tab02,
        tab02Label: tab02Label,
        currentIndex: currentIndex,
        appBar: appBar,
        navigationBar: navigationBar,
        persistentFooterButtons: persistentFooterButtons,
        useMaterial: App.useMaterial,
        useNavigator: useNavigator,
      );
}

//
class _BottomBarScaffold extends StatefulWidget {
  const _BottomBarScaffold({
    required this.tab01,
    this.tab01Label,
    required this.tab02,
    this.tab02Label,
    this.currentIndex,
    this.appBar,
    this.navigationBar,
    this.persistentFooterButtons,
    this.useMaterial,
    this.useNavigator,
  });

  final WidgetBuilder tab01, tab02;
  final Map<String, Icon>? tab01Label, tab02Label;
  final PreferredSizeWidget? appBar;
  final CupertinoNavigationBar? navigationBar;
  final int? currentIndex;
  final List<Widget>? persistentFooterButtons;
  final bool? useMaterial;
  final bool? useNavigator;

  @override
  State<StatefulWidget> createState() => _BottomBarScaffoldState();
}

//
class _BottomBarScaffoldState extends State<_BottomBarScaffold> {
  //
  @override
  void initState() {
    super.initState();
    globalKeys = {
      0: GlobalKey<_BottomBarScaffoldState>(debugLabel: 'StackIndex01'),
      1: GlobalKey<_BottomBarScaffoldState>(debugLabel: 'StackIndex02'),
      2: GlobalKey<_BottomBarScaffoldState>(debugLabel: 'BarItem01'),
      3: GlobalKey<_BottomBarScaffoldState>(debugLabel: 'BarItem02'),
    };

    // Supply the initial index
    currentIndex = widget.currentIndex ?? 0;

    final label01 = widget.tab01Label;
    if (label01 != null && label01.isNotEmpty) {
      tab01Label = label01;
    }

    final label02 = widget.tab02Label;
    if (label02 != null && label02.isNotEmpty) {
      tab02Label = label02;
    }
  }

  late int currentIndex;
  Map<int, GlobalKey>? globalKeys;
  Widget? tab01, tab02;
  Widget? body;
  Map<String, Icon>? tab01Label, tab02Label;
  // Flag when tabs are switched
  bool switched = false;

  @override
  void dispose() {
    globalKeys = null;
    tab01 = null;
    tab02 = null;
    body = null;
    super.dispose();
  }

  @override
  void deactivate() {
    // Don't build if and when returning
    switched = true;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // Switching tabs
    if (switched) {
      switched = false;
    } else {
      tab01 = null;
      tab02 = null;
    }
    return App.useMaterial ? _returnScaffold() : _returnCupertinoPageScaffold();
  }

  /// Return a Scaffold widget
  Widget _returnScaffold() => Scaffold(
        appBar: widget.appBar,
        body: IndexedStack(
          index: currentIndex,
          children: <Widget>[
            _StackPage(
              key: globalKeys![0]!,
              child: tab01 ??= widget.tab01(context),
            ),
            _StackPage(
              key: globalKeys![1]!,
              child: tab02 ??= widget.tab02(context),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            if (currentIndex != index) {
              currentIndex = index;
              switched = true;
              setState(() {});
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              key: globalKeys![2]!,
              icon: tab01Label?.values.last ?? const Icon(Icons.home),
              label: tab01Label?.keys.last ?? 'Home'.tr,
            ),
            BottomNavigationBarItem(
              key: globalKeys![3]!,
              icon: tab02Label?.values.last ?? const Icon(Icons.settings),
              label: tab02Label?.keys.last ?? 'Settings'.tr,
            ),
          ],
        ),
        persistentFooterButtons: widget.persistentFooterButtons,
      );

  /// Return a CupertinoPageScaffold widget
  Widget _returnCupertinoPageScaffold() => CupertinoPageScaffold(
        navigationBar: widget.navigationBar,
        child: SafeArea(
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: tab01Label?.values.last ??
                        const Icon(CupertinoIcons.home),
                    label: tab01Label?.keys.last ?? 'Home'.tr),
                BottomNavigationBarItem(
                    icon: tab02Label?.values.last ??
                        const Icon(CupertinoIcons.settings),
                    label: tab02Label?.keys.last ?? 'Settings'.tr),
              ],
              currentIndex: currentIndex,
              onTap: (index) => currentIndex = index,
            ),
            tabBuilder: (_, index) => CupertinoTabView(
              onUnknownRoute: AppErrorHandler.onUnknownRoute,
              builder: (context) => index == 0
                  ? tab01 ??= widget.tab01(context)
                  : tab02 ??= widget.tab02(context),
            ),
          ),
        ),
      );
}

// class _NavigatorPage extends StatefulWidget {
//   const _NavigatorPage({
//     required this.navigatorKey,
//     this.useMaterial,
//     required this.child,
//   });
//
//   final GlobalKey navigatorKey;
//   final bool? useMaterial;
//   final Widget child;
//
//   @override
//   _NavigatorPageState createState() => _NavigatorPageState();
// }
//
// class _NavigatorPageState extends State<_NavigatorPage> {
//   @override
//   Widget build(BuildContext context) => Navigator(
//         key: widget.navigatorKey,
//         onGenerateRoute: (RouteSettings settings) {
//           Route<dynamic> route;
//           if (widget.useMaterial ?? true) {
//             route = MaterialPageRoute(builder: (_) => widget.child);
//           } else {
//             route = CupertinoPageRoute(builder: (_) => widget.child);
//           }
//           return route;
//         },
//       );
// }

// class _NavigatorPage extends StatelessWidget {
//   const _NavigatorPage({
//     required this.navigatorKey,
//     this.useMaterial,
//     required this.child,
//   });
//
//   final GlobalKey navigatorKey;
//   final bool? useMaterial;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) => Navigator(
//         key: navigatorKey,
//         onGenerateRoute: (RouteSettings settings) {
//           Route<dynamic> route;
//           if (useMaterial ?? true) {
//             route = MaterialPageRoute(builder: (_) => child);
//           } else {
//             route = CupertinoPageRoute(builder: (_) => child);
//           }
//           return route;
//         },
//       );
// }

//
class _StackPage extends StatelessWidget {
  const _StackPage({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(_) => child ?? const SizedBox.shrink();
}

///
class BackButtonCupertinoPageScaffold extends StatelessWidget {
  ///
  const BackButtonCupertinoPageScaffold({
    super.key,
    this.title,
    this.child,
  });

  /// Title page
  final String? title;

  /// Displayed widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    //
    Widget widget = child ??
        CupertinoButton(
          child: const Text('Press me'),
          onPressed: () => Navigator.of(context).maybePop(),
        );

    if (kIsWeb || UniversalPlatform.isWindows) {
      widget = ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: widget,
      );
    }

    //
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        middle: Text(title ?? ''),
      ),
      child: SafeArea(
        child: widget,
      ),
    );
  }
}
