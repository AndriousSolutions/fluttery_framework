// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '/src/controller.dart';

import '/src/view.dart';

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
class _InheritBirdState extends StateX<InheritBird> {
  _InheritBirdState() : super(controller: BirdController(), useInherited: true);

  /// Use builder() to call buildAndroid() and buildiOS() with the built-in InheritedWidget
  @override
  Widget builder(BuildContext context) => widget.child!;

  /// Determine if the dependencies should be updated.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      (controller as InheritController).updateShouldNotify(oldWidget);
}
