library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_tests_unit_model.dart';

Future<void> testFiles(WidgetTester tester) async {
  //
  const fileName = InstallFile.fileName;

  final file = await Files.get(fileName);

  final id = await InstallFile.readInstallationFile(file);

  final here = await Files.exists(fileName);

  if (here) {
    //
    final delete = await Files.delete(fileName);

    await InstallFile.id();

    if (delete && id.isNotEmpty) {
      await Files.writeFile(file, id);
    }
  }
}
