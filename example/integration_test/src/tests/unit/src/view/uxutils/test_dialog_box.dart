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
    button01: const Option(text: 'Stay', result: true),
    button02: const Option(text: 'New', result: false),
    useMaterial: App.useMaterial,
  );
}

void testDialogBox(WidgetTester tester) {
  //
//  test('Test DialogBox', () async {});
  dialogBox(
    App.context!,
    title: 'This is a test.',
    button01: OKOption(),
    button02: CancelOption(),
    press01: () {},
    press02: () {},
    barrierDismissible: true,
    switchButtons: true,
  );

  MsgBox(
    context: App.context!,
  );
}
