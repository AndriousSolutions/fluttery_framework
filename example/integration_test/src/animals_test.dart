// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../_test_imports.dart';

// const _location = '========================== animals_test.dart';

Future<void> animalsTest(WidgetTester tester) async {
  // Switch the app through the popupmenu
  await openApplicationMenu(tester);

  /// New Dogs
  await tester.tap(find.byKey(const Key('New Dogs')));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  /// New Cats
  await tester.tap(find.byKey(const Key('New Cats')));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  /// New Foxes
  await tester.tap(find.byKey(const Key('New Foxes')));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  /// New Birds
  await tester.tap(find.byKey(const Key('New Birds')));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  // /// Press the 'back button'
  // await tester.tap(find.byType(IconButton));
  // await tester.pumpAndSettle();
  /// Press the 'back button'
  await tapBackButtonTester(tester);
}
