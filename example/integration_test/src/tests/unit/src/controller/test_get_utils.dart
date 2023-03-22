/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

void testGetUtils(WidgetTester tester) {
  GetUtils.nil(null);

  GetUtils.hasCapitalletter('test');

  GetUtils.isChm('String filePath');

  GetUtils.isUsername('String s');

  GetUtils.isURL('String s');

  GetUtils.isSSN('String s');

  GetUtils.isOneAKind('1111');

  GetUtils.isOneAKind(1111);

  GetUtils.isLengthGreaterThan('test', 4);

  GetUtils.isLengthGreaterOrEqual('test', 4);

  GetUtils.isLengthLessThan('test', 4);

  GetUtils.isLengthLessOrEqual('test', 4);

  GetUtils.isLengthEqualTo('test', 4);

  GetUtils.isLengthBetween('dynamic value', 4, 13);
}
