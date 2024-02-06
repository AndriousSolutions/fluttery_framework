// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  This StatefulWidget works with the 'Dog' InheritedWidget
///

import '/src/controller.dart';

import '/src/view.dart';

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

  /// Should use these two if you've two separate interfaces:
  /// Material for Android and Cupertino for iOS.
  @override
  Widget buildAndroid(BuildContext context) => widget.child!;

  /// Currently not providing an 'iOS' version of the interface.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}
