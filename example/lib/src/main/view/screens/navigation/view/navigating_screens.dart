// ignore_for_file: unused_element
//
import '/src/controller.dart';

import '/src/view.dart';

///
class Page01 extends NavWidget {
  ///
  const Page01({super.key});

  @override
  State createState() => _NavState<Page01>();
}

///
class Page02 extends NavWidget {
  ///
  const Page02({super.key});

  @override
  State createState() => _NavState<Page02>();
}

///
class Page03 extends NavWidget {
  ///
  const Page03({super.key});

  @override
  State createState() => _NavState<Page03>();
}

///
class Page04 extends NavWidget {
  ///
  const Page04({super.key});

  @override
  State createState() => _NavState<Page04>();
}

///
class Page05 extends NavWidget {
  ///
  const Page05({super.key});

  @override
  State createState() => _NavState<Page05>();
}

///
class Page06 extends NavWidget {
  ///
  const Page06({super.key});

  @override
  State createState() => _NavState<Page06>();
}

///
class Page07 extends NavWidget {
  ///
  const Page07({super.key});

  @override
  State createState() => _NavState<Page07>();
}

///
class Page08 extends NavWidget {
  ///
  const Page08({super.key});

  @override
  State createState() => _NavState<Page08>();
}

///
class Page09 extends NavWidget {
  ///
  const Page09({super.key});

  @override
  State createState() => _NavState<Page09>();
}

///
class Page10 extends NavWidget {
  ///
  const Page10({super.key});

  @override
  State createState() => _NavState<Page10>();
}

///
class NavWidget extends StatefulWidget {
  ///
  const NavWidget({super.key});

  @override
  State createState() => _NavState();
}

/// Supply a particular State class for this example app.
class _NavState<T extends NavWidget> extends NavState<T> {
  ///
  @override
  void initState() {
    super.initState();
    con = controller as NavController;
  }

  late NavController con;

  ///
  @override
  Widget build(BuildContext context) {
    //
    var text = '';
    if (con.mainText.isNotEmpty) {
      text = con.mainText;
      // Nullify theses properties now
      con.mainText = '';
    }
    // Reference for the previous page
    final prevTitle = prevWidget == null ? 'Exit' : 'Prev Page';
    return Scaffold(
      appBar: AppBar(
        title: Text('App Navigation'.tr),
      ),
      primary: false,
      drawer: AppDrawer(),
      body: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 48),
          ),
          Flexible(
            child: ListView(
              controller: ListListener(
                offset: con.list01Offset,
                callback: (offset) {
                  con.list01Offset = offset;
                },
              ).scrollController,
              children: [
                canPopWidget(),
                finalizeRouteWidget(),
                maybePopWidget(),
                popWidget(),
                popAndPushNamedWidget(),
                popUntilWidget(),
                pushWidget(),
                pushAndRemoveUntilWidget(),
                pushNamedWidget(),
                pushNamedAndRemoveUntilWidget(),
                pushReplacementWidget(),
                pushReplacementNamedWidget(),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
            thickness: 2,
          ),
          Flexible(
            child: ListView(
              controller: ListListener(
                offset: con.list02Offset,
                callback: (offset) {
                  con.list02Offset = offset;
                },
              ).scrollController,
              children: [
                removeRouteWidget(),
                removeRouteBelowWidget(),
                replaceWidget(),
                replaceRouteBelowWidget(),
                restorablePopAndPushNamedWidget(),
                restorablePushWidget(),
                restorablePushAndRemoveUntilWidget(),
                restorablePushNamedWidget(),
                restorablePushNamedAndRemoveUntilWidget(),
                restorablePushReplacementWidget(),
                restorablePushReplacementNamedWidget(),
                restorableReplaceWidget(),
                restorableReplaceRouteBelowWidget(),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              key: Key(prevTitle),
              child: Text(prevTitle.tr),
              onPressed: () {
                if (canPop()) {
                  con.maybePop<bool>(true);
                } else {
                  con.mainText = 'Nowhere to go.';
                }
              },
            ),
            Flexible(child: Text(text)),
            if (nextWidget == null)
              const Text('         ')
            else
              ElevatedButton(
                key: const Key('Next Page'),
                child: Text('Next Page'.tr),
                onPressed: () async {
                  await con.push();
                },
              ),
          ],
        ),
      ],
    );
  }
}
