/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_view.dart';

void testSimpleBottomAppBar(WidgetTester tester) {
  //
//  test('Test SimpleBottomAppBar', () async {});
  SimpleBottomAppBar(
    button01: HomeBarButton(),
    button02: DeleteBarButton(),
    button03: EditBarButton(),
    button04: SearchBarButton(),
  );
}
