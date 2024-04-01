// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  11 May 2018
//

import 'dart:async' show Future;

import 'dart:io' show File;

import 'package:uuid/uuid.dart' show Uuid;

import 'files.dart' show Files;

/// Introduces a 'install file' unique to the app.
class InstallFile {
  /// The name of the 'install file.'
  static const String FILE_NAME = '.install';

  /// The unique Id contained in the 'install file.'
  static String? sID;

  static bool _justInstalled = false;

  /// Indicate if this is the 'first' install of the app.
  bool get justInstalled => _justInstalled;

  /// Return the unique identifier for this app installation.
  static Future<String?> id() async {
    if (sID != null) {
      return sID;
    }

    final installFile = await Files.get(FILE_NAME);

    try {
      // ignore: avoid_slow_async_io
      final exists = await installFile.exists();

      if (!exists) {
        _justInstalled = true;
        sID = writeInstallationFile(installFile);
      } else {
        sID = await readInstallationFile(installFile);
      }
    } catch (ex) {
      sID = '';
    }

    return sID;
  }

  /// Returns the content of the 'install file.'
  /// Pass in a File object of the install file.
  static Future<String> readInstallationFile(File installFile) async {
    //
    final file = await Files.get(FILE_NAME);
    final content = await Files.readFile(file);
    return content;
  }

  /// Write to the 'install file.'
  /// Pass in a File object representing the install file.
  static String writeInstallationFile(File file) {
    const uuid = Uuid();
    // Generate a v4 (random) id
    final id = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    Files.writeFile(file, id);
    return id;
  }
}
