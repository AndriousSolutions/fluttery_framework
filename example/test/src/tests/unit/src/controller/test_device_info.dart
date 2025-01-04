library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '_unit_test_controller.dart';

Future<void> testDeviceInfo() async {
  //
  // Native platform code is not present in a Flutter Test
  if (!App.inFlutterTest) {
    await DeviceInfo.initAsync();
  }

  DeviceInfo.data;

  DeviceInfo.deviceId;

  DeviceInfo.board;

  DeviceInfo.bootloader;

  DeviceInfo.brand;

  DeviceInfo.device;

  DeviceInfo.display;

  DeviceInfo.fingerprint;

  DeviceInfo.hardware;

  DeviceInfo.host;

  DeviceInfo.id;

  DeviceInfo.manufacturer;

  DeviceInfo.model;

  DeviceInfo.product;

  DeviceInfo.supported32BitAbis;

  DeviceInfo.supported64BitAbis;

  DeviceInfo.supportedAbis;

  DeviceInfo.tags;

  DeviceInfo.type;

  DeviceInfo.isPhysicalDevice;

  DeviceInfo.versionBaseOs;

  DeviceInfo.versionCodename;

  DeviceInfo.versionIncremental;

  DeviceInfo.versionPreviewSdk;

  DeviceInfo.versionRelease;

  DeviceInfo.versionSdk;

  DeviceInfo.versionSecurityPatch;

  DeviceInfo.name;

  DeviceInfo.systemName;

  DeviceInfo.systemVersion;

  DeviceInfo.localizedModel;

  DeviceInfo.identifierForVendor;

  DeviceInfo.utsname;

  DeviceInfo.utsnameSysname;

  DeviceInfo.utsnameNodename;

  DeviceInfo.utsnameRelease;

  DeviceInfo.utsnameVersion;

  DeviceInfo.utsnameMachine;
}
