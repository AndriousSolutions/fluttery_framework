// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This StatefulWidget works with the 'Dog' InheritedWidget
///

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritDog extends StatefulWidget {
  ///
  const InheritDog({super.key, required this.child});

  ///
  final Widget? child;
  @override
  State<StatefulWidget> createState() => _InheritDogState();
}

/// Supply an InheritedWidget to a StateX object: InheritedStateX
class _InheritDogState extends StateIn<InheritDog> {
  _InheritDogState() : super(controller: DogController());
  @override
  Widget buildAndroid(BuildContext context) => widget.child!;
}
