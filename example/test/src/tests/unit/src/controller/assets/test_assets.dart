// ignore_for_file: unused_local_variable
library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_controller.dart';

Future<void> testAssets() async {
//
  final byteData = await Assets.getStreamF('key');

  final string = await Assets.getStringF('key');

  final assets = Assets();

  final String? data =
      await assets.getData<String>('key', (value) => Future.value('test'));

  final String? stringData =
      await assets.getStringData('key', (value) => Future.value('test'));

  final bool boolData =
      await assets.getBoolData('key', (value) => Future.value(true));

  final assetImage = assets.getImage('test');

  final String? path = Assets.setPath('key');
}
