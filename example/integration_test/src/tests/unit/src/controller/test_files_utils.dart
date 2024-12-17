// ignore_for_file: unused_local_variable
library;

/// Copyright 2024 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 16 December, 2024
///

import '_unit_test_controller.dart';

import '../view/_unit_test_view.dart';

Future<void> testFileUtils(WidgetTester tester) async {
  //
  final fileName = InstallFile.fileName;

  final file = await Files.get(fileName);

  final id = await InstallFile.readInstallationFile(file);

  final here = await Files.exists(fileName);

  if (here) {
    //
    bool delete = await Files.delete(fileName);

    await InstallFile.id();

    if (delete && id.isNotEmpty) {
      await Files.writeFile(file, id);
    }
  }
}
