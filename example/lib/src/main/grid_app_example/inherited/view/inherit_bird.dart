// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../../controller.dart';

import '../../../../view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritBird extends StatefulWidget {
  ///
  const InheritBird({super.key, required this.child});

  ///
  final Widget? child;
  @override
  State<StatefulWidget> createState() => _InheritBirdState();
}

/// Supply an InheritedWidget to a StateX object, InheritedStateX
class _InheritBirdState extends StateIn<InheritBird> {
  _InheritBirdState() : super(controller: BirdController());

  /// Use builder() or buildIn() instead of build() to call the built-in InheritedWidget
  @override
  Widget builder(BuildContext context) => widget.child!;
}
