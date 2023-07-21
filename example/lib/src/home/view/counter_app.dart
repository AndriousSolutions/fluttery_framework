//
import 'package:fluttery_framework_example/src/view.dart';

import 'package:fluttery_framework_example/src/controller.dart';

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
          useInheritedWidget: CounterController().useInherited,
        ) {
    con = controller as CounterController;
  }

  late CounterController con;

  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  @override
  void initState() {
    super.initState();
    appCon = ExampleAppController();
    con.timer.initTimer();
  }

  late ExampleAppController appCon;

  Widget get wordPair => con.wordPair;

  /// Supply the 'Material' Interface for the Android platform and
  /// as the default interface for the Web and Windows platform.
  @override
  Widget buildAndroid(BuildContext context) => Scaffold(
        key: const Key('Scaffold'),
        appBar: AppBar(
          title: Text('Counter Page Demo'.tr),
          actions: [AppMenu().popupMenuButton],
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
              state((context) => Text(con.data,
                  style: Theme.of(context).textTheme.headlineMedium)),
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
                                  Page1(key: UniqueKey()),
                            ),
                          );
                        },
                        child: const Text(
                          'Page 1',
                        ),
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
            // Deliberately throw an error to demonstrate error handling.
            throw Exception('Fake error to demonstrate error handling!');
            // This code is greyed out by the IDE because it can never bt reached.
            setState(con.onPressed);
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: SimpleBottomAppBar(
          button01: HomeBarButton(),
          button02: StatsBarButton(),
          button03: EventsBarButton(),
          button04: HistoryBarButton(),
        ),
      );

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
              children: [
                AppMenu().popupMenuButton,
              ],
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
                        const Text('Use built-in InheritedWidget'),
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
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: CupertinoButton.filled(
                      onPressed: () {
                        // Deliberately throw an error to demonstrate error handling.
                        throw Exception(
                            'Fake error to demonstrate error handling!');
                        // This code is greyed out by the IDE because it can never bt reached.
                        setState(con.onPressed);
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
    }
  }
}
