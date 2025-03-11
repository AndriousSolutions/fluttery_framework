library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 07 February, 2025
///

import '../xport/_export_tests.dart';

String _location = '========================== multi_counters_test.dart';

/// Testing the counter app
Future<void> multiScreenTest(WidgetTester tester) async {
  // tap button
  await tester.tap(find.byKey(const Key('Page 1')));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // Go to Page 2
  await tester.tap(find.byKey(const Key('Page 2')));
  await tester.pumpAndSettle();

  // Don't go to Page 3. It invokes an error.

  // Back to Page 1
  await tester.tap(find.byKey(const Key('Page 1')));
  await tester.pumpAndSettle();

  // Press the 'back button'
  await tapBackButtonTester(tester);
}
