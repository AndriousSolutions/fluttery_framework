//
import 'package:flutter/gestures.dart' show PointerDeviceKind;

import '/src/controller.dart';

import '/src/view.dart';

/// The Home page
class GridPage extends StatefulWidget {
  ///
  const GridPage({super.key, this.title});

  ///
  final String? title;

  @override
  State<StatefulWidget> createState() => _GridPageState();
}

class _GridPageState extends StateX<GridPage> {
  _GridPageState() : super(controller: GridAppController()) {
    con = controller as GridAppController;
  }

  late GridAppController con;

  @override
  Widget buildAndroid(BuildContext context) => TwoTabScaffold(
        appBar: AppBar(
          title: L10n.t(widget.title ?? 'Inherited State Object Demo'),
          actions: [AppMenu()],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        tab01: (_) => gridAnimals,
        tab02: (_) => SettingsScreen(
          title: 'Settings'.tr,
          child: const SettingsPage(),
        ),
        persistentFooterButtons: [newAnimals()],
        useMaterial: App.useMaterial,
        useNavigator: true,
      );

  ///
  Widget newAnimals() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: TextButton(
              key: const Key('New Dogs'),
              onPressed: () => con.newDogs(),
              child: Text('New Dogs'.tr),
            ),
          ),
          Flexible(
            child: TextButton(
              key: const Key('New Cats'),
              onPressed: () => con.newCats(),
              child: Text('New Cats'.tr),
            ),
          ),
          Flexible(
            child: TextButton(
              key: const Key('New Foxes'),
              onPressed: () => con.newFoxes(),
              child: Text('New Foxes'.tr),
            ),
          ),
          Flexible(
            child: TextButton(
              key: const Key('New Birds'),
              onPressed: () => con.newBirds(),
              child: Text('New Birds'.tr),
            ),
          ),
        ],
      );

  /// Currently not providing an 'iOS' version of the interface.
  /// Look at the parent function and see what's inside
  @override
  Widget buildiOS(BuildContext context) {
    //
    final navigationBar = CupertinoNavigationBar(
      leading: L10n.t(widget.title ?? 'Inherited State Object Demo'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [AppMenu()],
      ),
    );

    //
    final column = Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(
        flex: 4,
        child: gridAnimals,
      ),
      Flexible(child: newAnimals()),
    ]);

    return TwoTabScaffold(
      navigationBar: navigationBar,
      tab01: (_) => column,
      tab02: (_) => SettingsScreen(
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [AppMenu()],
        ),
      ),
    );
  }

  Widget? _gridAnimals;

  ///
  Widget get gridAnimals {
    //
    Widget widget = GridView.count(
      cacheExtent: 1000,
      crossAxisCount: 3,
      children: con.children,
    );
    //
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

    return _gridAnimals = InheritBird(
      child: InheritCat(
        child: InheritDog(
          child: InheritFox(
            child: widget,
          ),
        ),
      ),
    );
  }

  /// Place breakpoints and step through the functions below
  /// to see how this all works.

  @override
  Widget build(BuildContext context) => super.build(context);

  @override
  // ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);
}
