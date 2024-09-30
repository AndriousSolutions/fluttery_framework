library;

import 'package:integration_test/integration_test.dart';

/// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 18 July, 2022
///

/// Flutter Test files
import '../integration_test/src/_test_imports.dart';

/// Calls the example app's very own test
import '../integration_test/widget_test.dart';

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

  // //
  group('Integration Tests', _testIntegrationGroup);

  //
  // group('Builder Error Tests', _builderErrorTest);

  // //
  // group('Async Error Tests', asyncErrorTest);
}

void _builderErrorTest() {
  ///
  testWidgets('Error in Builder', (WidgetTester tester) async {
    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(FlutteryExampleApp(key: UniqueKey()));

    // Now trip an error right at start up.
    ExampleAppController().errorInBuilder = true;

    // pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();
  });
}

void asyncErrorTest() {
  ///
  testWidgets('Error in initAsync()', (WidgetTester tester) async {
    // The Example app
    await tester.pumpWidget(FlutteryExampleApp(key: UniqueKey()));

    // Throw an error in the initAsync() function
    ExampleAppController().initAsyncError = true;

    // pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();
  });
}

/// Calls a number of testWidgets() functions one after the other
void _testIntegrationGroup() {
  // Run the Example app and perform some tests
  integrationTestFlutteryFramework();
}
