// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This widget works with the free Fox API.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomFox extends StatefulWidget {
  ///
  const RandomFox({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RandomFoxState();
}

class _RandomFoxState extends ImageAPIStateX<RandomFox> {
  _RandomFoxState()
      : super(
          controller: FoxController(),
          uri: Uri(
            scheme: 'https',
            host: 'randomfox.ca',
            path: 'floof',
          ),
          message: 'image',
        );

  /// Place a breakpoint and see the process
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);
}
