//
// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

/// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';
///
class WordPairs extends StatefulWidget {
  ///
  const WordPairs({super.key});

  @override
  State createState() => _WordPairsState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _WordPairsState extends StateX<WordPairs> {
  _WordPairsState() : super(controller: WordPairsController()) {
    con = controller as WordPairsController;
  }
  late WordPairsController con;

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildAndroid(BuildContext context) => _RandomWordsAndroid(state: this);

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildiOS(BuildContext context) => _RandomWordsiOS(state: this);
}

/// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
@override

/// The Android-style of interface
class _RandomWordsAndroid extends StatelessWidget {
  //
  const _RandomWordsAndroid({required this.state});
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
  const _RandomWordsiOS({required this.state});
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
