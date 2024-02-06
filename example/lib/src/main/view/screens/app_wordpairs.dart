/// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

/// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';

class WordPairs extends StatefulWidget {
  const WordPairs({Key? key}) : super(key: key);

  @override
  State createState() => _WordPairsState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _WordPairsState extends StateX<WordPairs> {
  _WordPairsState() : super(controller: WordPairsController()) {
    con = controller as WordPairsController;
  }
  late WordPairsController con;

  @override
  void initState() {
    super.initState();
    appCon = ExampleAppController();
  }

  late ExampleAppController appCon;

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildAndroid(BuildContext context) => _RandomWordsAndroid(state: this);

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildiOS(BuildContext context) => _RandomWordsiOS(state: this);

  // Merely for demonstration purposes. Erase if not using.
  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  //ignore: unnecessary_overrides
  void activate() {
    super.activate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method when this [State] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// An 'error handler' routine to fire when an error occurs.
  /// Allows the user to define their own with each State.
  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);
  }

  // Merely for demonstration purposes. Erase if not using.
  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when a dependency of this [State] object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    super.reassemble();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  /// Observers are notified in registration order until one returns
  /// true. If none return true, the application quits.
  @override
  Future<bool> didPopRoute() async {
    return super.didPopRoute();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification. Observers are notified in registration
  /// order until one returns true.
  ///
  /// This method exposes the `pushRoute` notification from
  // ignore: comment_references
  @override
  Future<bool> didPushRoute(String route) async {
    return super.didPushRoute(route);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.suspending (Android only)
    super.didChangeAppLifecycleState(state);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }
}

/// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
@override

/// The Android-style of interface
class _RandomWordsAndroid extends StatelessWidget {
  //
  const _RandomWordsAndroid({Key? key, required this.state}) : super(key: key);
  final _WordPairsState state;

  @override
  Widget build(BuildContext context) {
    final con = state.con;
    return Scaffold(
      key: const Key('Scaffold'),
      appBar: AppBar(
        title: Text('Startup Name Generator'.tr),
        actions: [
          IconButton(
            key: const Key('listSaved'),
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          AppMenu(),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return const Divider();
            }
            con.build(i);
            return ListTile(
              title: Text(
                con.data,
                style: const TextStyle(fontSize: 25),
              ),
              trailing: con.trailing,
              onTap: () {
                con.onTap(i);
              },
            );
          }),
    );
  }

  void _pushSaved() {
    Navigator.of(state.context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = state.con.tiles();
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'.tr),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

/// The iOS-style of interface
class _RandomWordsiOS extends StatelessWidget {
  //
  const _RandomWordsiOS({Key? key, required this.state}) : super(key: key);
  final _WordPairsState state;
  @override
  Widget build(BuildContext context) {
    final con = state.con;
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Startup Name Generator'.tr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  key: const Key('listSaved'),
                  onPressed: _pushSaved,
                  child: const Icon(Icons.list),
                ),
                AppMenu(),
              ],
            ),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  if (i.isOdd) {
                    return const Divider();
                  }
                  con.build(i);
                  return CupertinoListTile(
                    title: Text(con.data),
                    trailing: con.trailing,
                    onTap: () {
                      con.onTap(i);
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(state.context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<Widget> tiles = state.con.tiles();
          final Iterator<Widget> it = tiles.iterator;
          it.moveNext();
          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Saved Suggestions'.tr),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final tile = it.current;
                        it.moveNext();
                        return tile;
                      },
                      childCount: tiles.length,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
