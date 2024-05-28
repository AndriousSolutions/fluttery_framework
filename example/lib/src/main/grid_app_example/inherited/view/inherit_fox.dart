// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This StatefulWidget works with the Fox InheritedWidget.
///

import '/src/controller.dart';

import '/src/view.dart';

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
class _InheritFoxState extends StateX<InheritFox> {
  _InheritFoxState() : super(controller: FoxController(), useInherited: true);

  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  // ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);

  /// Should use these two if you've two separate interfaces:
  /// Material for Android and Cupertino for iOS.
  @override
  Widget buildAndroid(BuildContext context) => widget.child!;

  /// Currently not providing an 'iOS' version of the interface.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}
