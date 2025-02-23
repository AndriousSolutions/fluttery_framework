library;
// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';

/// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

/// The third page displayed in this app.
class Page3 extends StatefulWidget {
  /// You can instantiate the State Controller in the StatefulWidget;
  const Page3({super.key});

  @override
  State createState() => _Page3State();
}

class _Page3State extends StateX<Page3> {
  //
  int count = 0;

  @override
  Widget buildAndroid(BuildContext context) => TwoTabScaffold(
        appBar: AppBar(
          title: Text('Three-page example'.tr),
          actions: [AppMenu()],
        ),
        tab01: (_) => _buildPage3(
          count: count,
          counter: () {
            setState(() => count++);
          },
          page1counter: () {
            // Merely instantiating the StatefulWidget to call its function.
            final state = Controller().ofState<Page2State>()!;
            state.onPressed();
          },
          page2counter: () {
            Controller().onPressed();
          },
          newKey: () {},
        ),
        tab02: (_) => SettingsScreen(
          title: 'Settings'.tr,
          child: const SettingsPage(),
        ),
      );

  /// Ignore this function. Study the features above instead.
  Widget _buildPage3({
    int count = 0,
    required void Function() counter,
    required void Function() newKey,
    required void Function() page1counter,
    required void Function() page2counter,
  }) =>
      BuildPage(
        label: '3',
        count: count,
        counter: counter,
        row: (BuildContext context) => [
          Flexible(
            child: ElevatedButton(
              key: const Key('Page 1'),
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              child: L10n.t('Page 1'),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              key: const Key('Page 2'),
              onPressed: () {
                Navigator.pop(context);
              },
              child: L10n.t('Page 2'),
            ),
          ),
        ],
        column: (_) => [const Text(' ')],
        persistentFooterButtons: <Widget>[
          ElevatedButton(
            key: const Key('Page 1 Counter'),
            onPressed: page1counter,
            child: L10n.t('Page 1 Counter'),
          ),
          ElevatedButton(
            key: const Key('Page 2 Counter'),
            onPressed: page2counter,
            child: L10n.t('Page 2 Counter'),
          ),
        ],
      );

  /// Place breakpoints and step through the functions below
  /// to see how this all works.

  @override
  Widget build(BuildContext context) => super.build(context);

  @override
  // ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);
}
