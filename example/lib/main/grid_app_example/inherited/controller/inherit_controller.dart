// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
//  The 'Animal' Controller to call the appropriate InheritedWidget.
//

import '/src/controller.dart';

///
class InheritController extends StateXController {
  //
  final _imageControllers = <ImageAPIController>{};

  ///
  bool addImageController(ImageAPIController controller) =>
      _imageControllers.add(controller);

  /// Link this Controller's Widget to a specific InheritedWidget
  /// The InheritedWidget is the first State object it registered with.
  @override
  bool dependOnInheritedWidget(BuildContext? context) =>
      firstState!.dependOnInheritedWidget(context);

  /// Rebuild the InheritedWidget to also rebuild its dependencies.
  void newAnimals() {
    _newAnimals = true;
    firstState!.notifyClients();
  }

  // Flag if there are to be new animals
  bool _newAnimals = false;

  /// Determine if the dependencies should be updated.
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //
    final update = _newAnimals;
    if (update) {
      //
      _newAnimals = false;

      for (final con in _imageControllers.toList(growable: false)) {
        con.runAsyncAgain = true;
      }
    }
    return update;
  }
}
