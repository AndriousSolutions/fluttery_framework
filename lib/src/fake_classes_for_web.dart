// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//            Created 16 March 2023
//
//  Fake classes to import when used on the Web
//

// \Pub\Cache\hosted\pub.dev\path_provider-2.0.13\lib\path_provider.dart
/// This supplies a directory though not as intended since on the Web
Future<Directory> getApplicationDocumentsDirectory() async => Directory();

/// A 'fake' Directory class.
/// \flutter\bin\cache\pkg\sky_engine\lib\io\directory.dart'
class Directory {
  /// Supply whatever data type that required ot this time.
  String get path => '';
}
