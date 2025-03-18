@TestOn('!browser')
library;


/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import 'package:fluttery_framework_example/test/src/_tests_xport.dart';


///
Future<void> testFiles(WidgetTester tester) async {
  //
  // Files are not accessible on the Web!
  if (UniversalPlatform.isWeb) {
    return;
  }
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
