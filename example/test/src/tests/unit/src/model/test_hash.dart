// ignore_for_file: unused_local_variable
library;

/// Copyright 2024 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 September, 2024
///

import '_unit_test_model.dart';

Future<void> testHash(WidgetTester tester) async {
  int hash;

  hash = hashObjects(['1', '2', '3', '4']);

  hash = hash2('1', '2');

  hash = hash3('1', '2', '3');

  hash = hash4('1', '2', '3', '4');
}
