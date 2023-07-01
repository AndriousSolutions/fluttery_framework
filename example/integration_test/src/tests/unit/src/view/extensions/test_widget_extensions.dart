/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_view.dart';

void testWidgetExtension() {
  //
//  test('Test Widget Extension', () async {});
  const widget = SizedBox();

  widget.paddingAll(2);

  widget.paddingSymmetric(horizontal: 2, vertical: 2);

  widget.paddingOnly(left: 1, top: 2, right: 3, bottom: 4);

  widget.paddingZero;

  widget.marginAll(2);

  widget.marginSymmetric();

  widget.marginOnly();

  widget.marginZero;
}
