// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

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
        newKey: () {
          startState?.setState(() {});
        },
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
    required void Function() newKey,
    required void Function() page1counter,
    required void Function() page2counter,
  }) =>
      BuildPage(
        label: '3',
        count: count,
        counter: counter,
        column: (_) => [
          Flexible(
            child: ElevatedButton(
              key: const Key('New Key'),
              onPressed: newKey,
              child: const Text('New Key for Page 1'),
            ),
          ),
        ],
        row: (BuildContext context) => [
          Flexible(
            child: ElevatedButton(
              key: const Key('Page 1'),
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              child: const Text('Page 1'),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              key: const Key('Page 2'),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Page 2'),
            ),
          ),
        ],
        persistentFooterButtons: <Widget>[
          ElevatedButton(
            key: const Key('Page 1 Counter'),
            onPressed: page1counter,
            child: const Text('Page 1 Counter'),
          ),
          ElevatedButton(
            key: const Key('Page 2 Counter'),
            onPressed: page2counter,
            child: const Text('Page 2 Counter'),
          ),
        ],
      );

  // This Cupertino interface is not implemented.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}
