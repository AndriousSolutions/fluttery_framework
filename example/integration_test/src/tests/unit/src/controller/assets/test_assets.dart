/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_controller.dart';

Future<void> testAssets() async {
//  test('Test Assets class', () async {
  //
  final byteData = await Assets.getStreamF('key');

  final string = await Assets.getStringF('key');

  final assets = Assets();

  final data =
      await assets.getData<String>('key', (value) => Future.value('test'));
//  });
}
