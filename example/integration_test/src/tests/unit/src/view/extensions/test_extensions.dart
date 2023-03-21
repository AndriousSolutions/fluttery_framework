/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 20 March, 2023
///

import '../_unit_test_view.dart';

testExtensions(WidgetTester tester) {
  //
  testContextExtension(App.context!);

  testDoubleExtension();

  testDurationExtension();

  testDynamicExtension();

  testNumExtension();

  testStringExtension();

  testWidgetExtension();
}
