library;

/// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 18 July, 2022
///

import 'package:flutter_test/flutter_test.dart';

/// Calls the example app's very own test
import '../integration_test/widget_test.dart';

void main() => testFlutteryFramework();

//const _deskTopSize = Size(1920, 1040); // physical pixels

void testFlutteryFramework() {
  /// Set up anything necessary before testing begins.
  /// Runs once before ALL tests or groups
  setUpAll(() async {});

  /// Runs before EACH test or group
  setUp(() async {
    // Ensure TestWidgetsFlutterBinding is explicitly initialized
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();

    // // (TODO: Tip # 4) Consider configuring your default screen size here.
    // // You can reset it to something else within a test
    // binding.window.physicalSizeTestValue = _deskTopSize;
  });

  /// Be sure the close the app after all the testing.
  /// Runs once after ALL tests or groups
  tearDownAll(() {});

  /// Runs after EACH test or group
  tearDown(() async {
    // Code that clears caches can go here
  });

  //
  group('Test Fluttery Framework', () => integrationTestFlutteryFramework());
}
