// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// The Home page
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key, this.title});

  ///
  final String? title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends StateX<HomePage> {
  _HomePageState() : super(controller: HomeController()) {
    con = controller as HomeController;
  }
  late HomeController con;

  @override
  Widget buildAndroid(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: L10n.t(widget.title ?? 'Inherited State Object Demo'),
          actions: [AppMenu().popupMenuButton],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: InheritBird(
          child: InheritCat(
            child: InheritDog(
              child: InheritFox(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: con.children,
                ),
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          // OverflowBar(
          //   spacing: 5,
          //   overflowAlignment: OverflowBarAlignment.center,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () => con.newDogs(),
                  child: Text('New Dogs'.tr),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () => con.newCats(),
                  child: Text('New Cats'.tr),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () => con.newFoxes(),
                  child: Text('New Foxes'.tr),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () => con.newBirds(),
                  child: Text('New Birds'.tr),
                ),
              ),
            ],
          ),
        ],
      );

  /// Currently not providing an 'iOS' version of the interface.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}
