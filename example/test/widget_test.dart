//
library;

/// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 18 July, 2022
///

/// Calls the example app's very own test
import '../integration_test/widget_test.dart';

/// Flutter Test files
import '../test/src/_tests_exports.dart';

/// Test the App when using Routes
import '../integration_test/src/routes_test.dart';

void main() => testFlutteryFramework();

//const _deskTopSize = Size(1920, 1040); // physical pixels

void testFlutteryFramework() {
  // Set up anything necessary before testing begins.
  // Runs once before ALL tests or groups
  setUpAll(() {
    // Allows for SharedPreferences to be ready for testing.
    SharedPreferences.setMockInitialValues({});
  });

  // Be sure the close the app after all the testing.
  // Runs once after ALL tests or groups
  tearDownAll(() {});

  // Runs before EACH test or group
  setUp(() {
    // // (TODO: Tip # 4) Consider configuring your default screen size here.
    // // You can reset it to something else within a test
    // binding.window.physicalSizeTestValue = _deskTopSize;
  });

  // Runs after EACH test or group
  tearDown(() {
    // Code that clears caches can go here
  });

  /// Integration and unit tests
  /// Calls a number of testWidgets() functions one after the other
  group('Integration Tests', integrationTestFlutteryFramework);

  /// Run test when the App is using Routes
  group('routes_test.dart', testRoutesRoutine);

  /// Test the built-in runApp() routine
  group('run_app.dart Test', testRunAppRoutine);

  ///
  group('error_handler.dart Tests', testAppErrorHandler);

  ///
  group('Run Code Coverage Tests', codeCoverage);
}
