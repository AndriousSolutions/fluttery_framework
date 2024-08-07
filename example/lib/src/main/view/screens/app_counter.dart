//

/// An absolute path is preferred but this source code is copied by other app.

import 'dart:ui';

import '/src/view.dart';

import '/src/controller.dart';

///
class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);
  @override
  State createState() => _CounterPageState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _CounterPageState extends StateX<CounterPage> {
  _CounterPageState()
      : super(
          controller: CounterController(),
          useInherited: CounterController().useInherited,
          routeAware: true,
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
    appCon = ExampleAppController();
  }

  late ExampleAppController appCon;

  TextStyle? style;

  Widget get wordPair => con.wordPair;

  int counter = 0;

  /// Try the 'reactive' option
  /// Increment this variable and the value displayed will 'magically' update
//  late Rx<int> rxCounter = watch(0); // or use  rxInt(0);

  /// Supply the 'Material' Interface for the Android platform and
  /// as the default interface for the Web and Windows platform.
  @override
  Widget buildAndroid(BuildContext context) {
    style ??= Theme.of(context).textTheme.headlineMedium;
    final isPortrait = context.isPortrait;
    return Scaffold(
      key: const Key('Scaffold'),
      appBar: AppBar(
        title: Text('Counter Page Demo'.tr),
        actions: [AppMenu()],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            con.wordPair,
            SizedBox(height: 10.h),
            Text('You have pushed the button this many times:'.tr,
                style: const TextStyle(fontSize: 15)),
            state((_) {
              return Text(con.data, style: style);
            }),
//            Text('$rxCounter', style: style),
            if (isPortrait)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  children: [
                    Text('Use built-in InheritedWidget'.tr),
                    CupertinoSwitch(
                      key: const Key('InheritedSwitch'),
                      value: con.useInherited,
                      onChanged: (v) {
                        con.useInherited = v;
                        App.setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            if (isPortrait)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: ElevatedButton(
                        key: const Key('Page 1'),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const Page1(),
                            ),
                          );
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
          if (App.inWidgetsFlutterBinding) {
            // Deliberately throw an error to demonstrate error handling.
            throw Exception('Fake error to demonstrate error handling!');
          }
          setState(con.onPressed);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: !isPortrait
          ? null
          : SimpleBottomAppBar(
              button01: HomeBarButton(),
              button02: StatsBarButton(),
              button03: EventsBarButton(),
              button04: HistoryBarButton(),
            ),
    );
  }

  /// Supply the 'Cupertino' Interface for the iOS platform.
  /// If not supplied, an iOS phone calls instead the buildAndroid() function.
  @override
  Widget buildiOS(BuildContext context) => CupertinoPageScaffold(
        key: const Key('Scaffold'),
        child: CustomScrollView(slivers: <Widget>[
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
                    child: Text(
                        'You have pushed the button this many times:'.tr,
                        style: TextStyle(fontSize: 13.sp)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                    child: state(
                      (context) => Text(
                        con.data,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Column(
                      children: [
                        Text('Use built-in InheritedWidget'.tr),
                        CupertinoSwitch(
                          value: con.useInherited,
                          onChanged: (v) {
                            con.useInherited = v;
                            App.setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: ElevatedButton(
                            key: const Key('Page 1'),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Page1(),
                                ),
                              );
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
                        if (App.inWidgetsFlutterBinding) {
                          // Deliberately throw an error to demonstrate error handling.
                          throw Exception(
                              'Fake error to demonstrate error handling!');
                        }
                        // This code is not reached unless in testing.
                        setState(con.onPressed);
//                       rxCounter.value++;
                      },
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );

  @override
  void onError(FlutterErrorDetails details) {
    final stack = details.stack;
    if (stack != null && stack.toString().contains('handleTap')) {
      setState(con.onPressed);
//      rxCounter.value++;
    }
  }

  /// Place breakpoints and step through the functions below
  /// to see how this all works.

  @override
  //ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  //ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);

  /// The framework calls this method whenever it removes this [StateX] object
  /// from the tree.
  @override
  // ignore: unnecessary_overrides
  void deactivate() {
    super.deactivate();
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: deactivate in $this');
    }
  }

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  // ignore: unnecessary_overrides
  void activate() {
    super.activate();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: activate in $this');
    }
  }

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU WILL HAVE NO IDEA WHEN THIS WILL RUN in the Framework.
  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: dispose in $this');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  // ignore: unnecessary_overrides
  void didUpdateWidget(CounterPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didUpdateWidget in $this');
    }
  }

  /// Called when immediately after [initState].
  /// Otherwise called only if a dependency of an [InheritedWidget].
  @override
  // ignore: unnecessary_overrides
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeDependencies in $this');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  // ignore: unnecessary_overrides
  void reassemble() {
    super.reassemble();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: reassemble in $this');
    }
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushRouteInformation in $this');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Called when this State is *first* added to as a Route observer?!
  @override
  void didPush() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPush in $this');
    }
    super.didPush();
  }

  /// New route has been pushed, and this State object's route is no longer current.
  @override
  void didPushNext() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushNext in $this');
    }
    super.didPushNext();
  }

  /// Called when this State is popped off a route.
  @override
  void didPop() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPop in $this');
    }
    super.didPop();
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPopNext in $this');
    }
    super.didPopNext();
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeMetrics in $this');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeTextScaleFactor in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangePlatformBrightness in $this');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeLocales in $this');
    }
  }

  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeAppLifecycleState in $this');
    }

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
  void resumedLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: resumedLifecycleState in $this');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: inactiveLifecycleState in $this');
    }
  }

  /// All views of an application are hidden, either because the application is
  /// about to be paused (on iOS and Android), or because it has been minimized
  /// or placed on a desktop that is no longer visible (on non-web desktop), or
  /// is running in a window or tab that is no longer visible (on the web).
  @override
  void hiddenLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: hiddenLifecycleState in $this');
    }
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: pausedLifecycleState in $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didHaveMemoryPressure in $this');
    }
  }

  /// Called when a request is received from the system to exit the application.
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didRequestAppExit in $this');
    }
    super.didRequestAppExit();
    return AppExitResponse.exit;
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();

    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeAccessibilityFeatures in $this');
    }
  }
}
