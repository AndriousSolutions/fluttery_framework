// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This widget works with the free Cat API.
///

import '../../../../../controller.dart';

import '../../../../../view.dart';

///
class RandomCat extends StatefulWidget {
  ///
  const RandomCat({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RandomCatState();
}

class _RandomCatState extends ImageAPIStateX<RandomCat> {
  _RandomCatState()
      : super(
          controller: CatController(),
          uri: Uri(
            scheme: 'https',
            host: 'shibe.online',
            path: 'api/cats',
          ),
          message: 'file',
        );
}