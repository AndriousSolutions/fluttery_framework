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
  Widget buildAndroid(BuildContext context) => _buildPage3(
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
      );

  /// Ignore this function. Study the features above instead.
  Widget _buildPage3({
    int count = 0,
    required void Function() counter,
    // required void Function() newKey,
    required void Function() page1counter,
    required void Function() page2counter,
  }) =>
      BuildPage(
        label: '3',
        count: count,
        counter: counter,
        // column: (_) => [
        //   Flexible(
        //     child: ElevatedButton(
        //       key: const Key('New Key'),
        //       onPressed: newKey,
        //       child: const Text('New Key for Page 1'),
        //     ),
        //   ),
        // ],
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

  // This Cupertino interface is not implemented.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);

  /// Place breakpoints and step through the functions below
  /// to see how this all works.

  @override
  Widget build(BuildContext context) => super.build(context);

  @override
  Widget buildF(BuildContext context) => super.buildF(context);
}
