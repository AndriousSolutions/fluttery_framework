// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This StatefulWidget works with the Fox InheritedWidget.
///

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritFox extends StatefulWidget {
  ///
  const InheritFox({super.key, required this.child});

  ///
  final Widget? child;
  @override
  State<StatefulWidget> createState() => _InheritFoxState();
}

/// Supply an InheritedWidget to a StateX object: InheritedStateX
class _InheritFoxState extends StateIn<InheritFox> {
  _InheritFoxState() : super(controller: FoxController());
  @override
  Widget buildAndroid(BuildContext context) => widget.child!;
}
