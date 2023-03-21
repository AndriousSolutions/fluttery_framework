/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_view.dart';

void testDialogBoxes(WidgetTester tester) {
  testShowBox(tester);
  testDialogBox(tester);
}

Future<void> testShowBox(WidgetTester tester) async {
  //
//  test('Test ShowBox', () async {});
  final result = await showBox(
    context: App.context!,
    text: 'This is a test.',
    button01: Option(text: 'Stay', result: true),
    button02: Option(text: 'New', result: false),
  );
}

void testDialogBox(WidgetTester tester) {
  //
//  test('Test DialogBox', () async {});
}
