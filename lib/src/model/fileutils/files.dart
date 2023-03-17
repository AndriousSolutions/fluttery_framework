/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  11 May 2018
///
import 'dart:async' show Future;
import 'dart:io' show File;

import 'package:path_provider/path_provider.dart'
    if (dart.library.html) 'package:fluttery_framework/src/fake_classes_for_web.dart'
    show getApplicationDocumentsDirectory;

// ignore: avoid_classes_with_only_static_members
/// Utility class to manipulate all files.
class Files {
  static String? _path;

  /// Return the local path location.
  static Future<String?> get localPath async {
    if (_path == null) {
      final directory = await getApplicationDocumentsDirectory();
      _path = directory.path;
    }
    return _path;
  }

  /// Return the contents of the specified file.
  /// Pass the name of the file.
  static Future<String> read(String fileName) async {
    final file = await get(fileName);
    return readFile(file);
  }

  /// Return the contents of the specified file.
  /// Pass the [File] object
  static Future<String> readFile(File file) async {
    String contents;
    try {
      // Read the file
      contents = await file.readAsString();
    } catch (e) {
      // If we encounter an error
      contents = '';
    }
    return contents;
  }

  /// Write the file
  static Future<File> write(String fileName, String content) async {
    final file = await get(fileName);
    return writeFile(file, content);
  }

  /// Write the file
  static Future<File> writeFile(File file, String content) =>
      file.writeAsString(content, flush: true);

  /// Return a boolean indicating if a file exists or not.
  /// Pass in the name of the file.
  static Future<bool> exists(String fileName) async {
    final file = await get(fileName);
    // ignore: avoid_slow_async_io
    return file.exists();
  }

  /// Return the File object of the specified file.
  /// Pass in the name of the file.
  static Future<File> get(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }
}
