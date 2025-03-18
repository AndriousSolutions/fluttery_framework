// Copyright 2025 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

// Specify the name of this file
const _location = '========================== routes_test.dart';

/// Test App when using Routes
void testRoutesRoutine() {
  //
  testWidgets('Test App when using Routes', (WidgetTester tester) async {
    //
    await tester.pumpWidget(FlutteryExampleApp());

    // Wait for all animations to complete.
    await tester.pumpAndSettle();

    // Multi Counter Screens testing
    await multiScreenTest(tester);
  });
}
