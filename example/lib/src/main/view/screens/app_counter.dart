library;

import 'dart:ui';

// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

import '/src/controller.dart';

///
class CounterPage extends StatefulWidget {
  ///
  const CounterPage({super.key});
  @override
  State createState() => _CounterPageState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _CounterPageState extends StateX<CounterPage> {
  _CounterPageState()
      : super(
          controller: CounterController(),
          useInherited: CounterController().useInherited,
          printEvents: true,
        ) {
    con = controller as CounterController;
  }

  late CounterController con;

  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  @override
  void initState() {
    super.initState();
    // What happens when this command is uncommented?
//    throw Exception('Throws an error to demonstrate error handling!');
  }

  TextStyle? style;

  Widget get wordPair => con.wordPair;

  int counter = 0;

  // Display the Switch widget?
  bool _showSwitch() {
    bool show = false;
    final appController = rootCon;
    if (appController != null && appController is AppController) {
      show = appController.useOnHome && appController.useInheritedWidget;
    }
    return show;
  }

  /// Place breakpoints and step through the functions below to see how this all works.
  @override
  //ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  /// Try the 'reactive' option
  /// Increment this variable and the value displayed will 'magically' update
//  late Rx<int> rxCounter = watch(0); // or use  rxInt(0);

  /// Supply the 'Material' Interface for the Android platform and
  /// as the default interface for the Web and Windows platform.
  @override
  Widget buildAndroid(BuildContext context) {
    style ??= Theme.of(context).textTheme.headlineMedium;
    final isPortrait = context.isPortrait || !UniversalPlatform.isMobile;
    return TwoTabScaffold(
      appBar: AppBar(
        title: Text('Counter Page Demo'.tr),
        actions: [AppMenu()],
      ),
      tab01: (_) => Scaffold(
        key: const Key('Scaffold'),
        drawer: AppDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              con.wordPair,
              SizedBox(height: 10.h),
              Text('You have pushed the button this many times:'.tr,
                  style: const TextStyle(fontSize: 15)),
              setBuilder((_) {
                return Text(con.data, style: style);
              }),
//            Text('$rxCounter', style: style),
              if (_showSwitch())
                if (isPortrait)
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text('Using built-in InheritedWidget'.tr),
                  ),
              if (isPortrait)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: ElevatedButton(
                          key: const Key('Page 1'),
                          onPressed: () async {
                            //
                            // if (AppController().useRoutes) {
                            //   await pushNamed('/Page1');
                            // } else {
                            //   final route = App.appState?.onGenerateRoute(
                            //     const RouteSettings(name: '/Page1'),
                            //   );
                            //   if (route != null) {
                            //     await App.push(route);
                            //   }
                            // }
                            if (AppController().useRoutes) {
                              await App.context?.pushNamed('/Page1');
                            } else {
                              await App.context?.push('/Page1');
                            }
                          },
                          child: L10n.t('Page 1'),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('IncrementButton'),
          onPressed: () {
            // Don't interrupt any testing.
            if (App.inWidgetsFlutterBinding && AppController().buttonError) {
              // Deliberately throw an error to demonstrate error handling.
              throw Exception('Fake error to demonstrate error handling!'.tr);
            }
            // ignore: dead_code
            setState(con.onPressed);
          },
          child: const Icon(Icons.add),
        ),
      ),
      tab02: (_) => SettingsScreen(
        title: 'Settings'.tr,
        child: const SettingsPage(),
      ),
    );
  }

  /// Supply the 'Cupertino' Interface for the iOS platform.
  /// If not supplied, an iOS phone calls instead the buildAndroid() function.
  @override
  Widget buildiOS(BuildContext context) {
    final isPortrait = context.isPortrait || !UniversalPlatform.isMobile;
    return TwoTabScaffold(
      tab01: (context) => CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Counter Page Demo'.tr),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [AppMenu()],
          ),
        ),
        SliverToBoxAdapter(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 15.h), child: con.wordPair),
                Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Text('You have pushed the button this many times:'.tr,
                      style: TextStyle(fontSize: 16.sp)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                  child: setBuilder(
                    (context) => Text(
                      con.data,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                if (_showSwitch())
                  if (isPortrait)
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Column(
                        children: [
                          Text('Using built-in InheritedWidget'.tr),
                          // CupertinoSwitch(
                          //   value: con.useInherited,
                          //   onChanged: (v) {
                          //     con.useInherited = v;
                          //     setState(() {});
                          //     App.setState(() {});
                          //   },
                          // ),
                        ],
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: ElevatedButton(
                          key: const Key('Page 1'),
                          onPressed: () async {
                            if (AppController().useRoutes) {
                              await App.context?.pushNamed('/Page1');
                            } else {
                              await App.context?.push('/Page1');
                            }
                          },
                          child: L10n.t('Page 1'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: CupertinoButton.filled(
                    onPressed: () {
                      // Don't interrupt any testing.
                      if (App.inWidgetsFlutterBinding &&
                          AppController().buttonError) {
                        // Deliberately throw an error to demonstrate error handling.
                        throw Exception(
                            'Fake error to demonstrate error handling!'.tr);
                      }
                      // This code is not reached unless in testing.
                      setState(con.onPressed);
                      //                       rxCounter.value++;
                    },
                    child: Text('Add'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      tab02: (_) => SettingsScreen(
        title: 'Settings'.tr,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [AppMenu()],
        ),
        child: const SettingsPage(),
      ),
      useMaterial: App.useMaterial,
    );
  }

  @override
  void onError(FlutterErrorDetails details) {
    final stackObj = details.stack;
    if (stackObj != null) {
      final stack = stackObj.toString();
      final msg = details.exceptionAsString();
      if (stack.contains('handleTap') &&
          msg.contains('Fake error to demonstrate error handling!')) {
        //
        setState(con.onPressed);
//      rxCounter.value++;
      }
    }
  }

  /// Place breakpoints and step through the functions below to see how this all works.

  @override
  //ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);

  /// The framework calls this method whenever it removes this [StateX] object
  /// from the tree.
  @override
  // ignore: unnecessary_overrides
  void deactivate() {
    super.deactivate();
  }

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  // ignore: unnecessary_overrides
  void activate() {
    super.activate();
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU WILL HAVE NO IDEA WHEN THIS WILL RUN in the Framework.
  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  // ignore: unnecessary_overrides
  void didUpdateWidget(CounterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// Called when immediately after [initState].
  /// Otherwise called only if a dependency of an [InheritedWidget].
  @override
  // ignore: unnecessary_overrides
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  // ignore: unnecessary_overrides
  void reassemble() {
    super.reassemble();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when this State is *first* added to as a Route observer?!
  @override
  void didPush() {
    super.didPush();
  }

  /// New route has been pushed, and this State object's route is no longer current.
  @override
  void didPushNext() {
    super.didPushNext();
  }

  /// Called when this State is popped off a route.
  @override
  void didPop() {
    super.didPop();
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    super.didPopNext();
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
  }

  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// Passing these possible values:
    /// AppLifecycleState.detached
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.hidden
    /// AppLifecycleState.paused (may enter the suspending state at any time)
  }

  /// The application is visible and responding to user input.
  @override
  void resumedAppLifecycleState() {}

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {}

  /// All views of an application are hidden, either because the application is
  /// about to be paused (on iOS and Android), or because it has been minimized
  /// or placed on a desktop that is no longer visible (on non-web desktop), or
  /// is running in a window or tab that is no longer visible (on the web).
  @override
  void hiddenAppLifecycleState() {}

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  /// Only iOS and Android
  @override
  void pausedAppLifecycleState() {}

  /// Either be in the progress of attaching when the  engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  /// Only iOS, Android and the Web
  @override
  void detachedAppLifecycleState() {}

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  /// Called when a request is received from the system to exit the application.
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    await super.didRequestAppExit();
    return AppExitResponse.exit;
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }
}
