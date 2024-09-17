// ignore_for_file: avoid_classes_with_only_static_members

// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  11 Feb 2019
//
//

import 'package:device_info_plus/device_info_plus.dart';

//todo: Commented out to make it Linux and Windows compatible
// /// Gets the ANDROID_ID for android and identifierForVendor for iOS platforms.
// /// Returns an empty string for any other platform
// import 'package:unique_identifier/unique_identifier.dart'
//     if (dart.library.html) 'package:fluttery_framework/src/controller/unique_identifier.dart';

/// Supplies the devices information.
///
///
/// dartdoc:
/// {@category Device Information}
class DeviceInfo {
  static bool _init = false;
  static Map<String, String> _deviceParameters = {};

  static String? _deviceId;

  /// Collect all the Device's information.
  static Future<Map<String, dynamic>> initAsync() async {
    //
    if (_init) {
      return _deviceParameters;
    }

    _init = true;

    // _deviceId = await UniqueIdentifier.serial;

    final info = await DeviceInfoPlugin().deviceInfo;

    return _deviceParameters =
        info.data.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Supply the device information
  static Map<String, dynamic> get data => _deviceParameters;

  /// The unique identifier of the device
  static String get deviceId => _deviceId ?? '';

  // Android

  /// The name of the underlying board, like "goldfish". Empty string if not available.
  static String get board => _deviceParameters['board'] ?? '';

  /// The system bootloader version number. Empty string if not available.
  static String get bootloader => _deviceParameters['bootloader'] ?? '';

  /// The consumer-visible brand with which the product/hardware will be associated.  Empty string if not available.
  static String get brand => _deviceParameters['brand'] ?? '';

  /// The name of the industrial design. Empty string if not available.
  static String get device => _deviceParameters['device'] ?? '';

  /// A build ID string meant for displaying to the user. Empty string if not available.
  static String get display => _deviceParameters['display'] ?? '';

  /// A string that uniquely identifies this build. Empty string if not available.
  static String get fingerprint => _deviceParameters['fingerprint'] ?? '';

  /// The name of the hardware (from the kernel command line or /proc). Empty string if not available.
  static String get hardware => _deviceParameters['hardware'] ?? '';

  /// Hostname. Empty string if not available.
  static String get host => _deviceParameters['host'] ?? '';

  /// Either a changelist number, or a label like "M4-rc20". Empty string if not available.
  static String get id => _deviceParameters['id'] ?? '';

  /// The manufacturer of the product/hardware. Empty string if not available.
  static String get manufacturer => _deviceParameters['manufacturer'] ?? '';

  /// The end-user-visible name for the end product. Empty string if not available.
  static String get model => _deviceParameters['model'] ?? '';

  /// The name of the overall product. Empty string if not available.
  static String get product => _deviceParameters['product'] ?? '';

  /// An ordered list of 32 bit ABIs supported by this device. Empty string if not available.
  static String get supported32BitAbis =>
      _deviceParameters['supported32BitAbis'] ?? '';

  /// An ordered list of 64 bit ABIs supported by this device. Empty string if not available.
  static String get supported64BitAbis =>
      _deviceParameters['supported64BitAbis'] ?? '';

  /// An ordered list of ABIs supported by this device. Empty string if not available.
  static String get supportedAbis => _deviceParameters['supportedAbis'] ?? '';

  /// Comma-separated tags describing the build, like "unsigned,debug". Empty string if not available.
  static String get tags => _deviceParameters['tags'] ?? '';

  /// The type of build, like "user" or "eng". Empty string if not available.
  static String get type => _deviceParameters['type'] ?? '';

  /// `false` if the application is running in an emulator, `true` otherwise. Empty string if not available.
  static String get isPhysicalDevice =>
      _deviceParameters['isPhysicalDevice'] ?? '';

  /// Removed from version 4.0.0 to avoid Google Play policies violations. Empty string if not available.
  // /// The Android hardware device ID that is unique between the device + user and app signing.
  // static String get androidId => _deviceParameters['androidId'] ?? '';

  /// The base OS build the product is based on. Empty string if not available.
  static String get versionBaseOs => _deviceParameters['versionBaseOs'] ?? '';

  /// The current development codename, or the string "REL" if this is a release build. Empty string if not available.
  static String get versionCodename =>
      _deviceParameters['versionCodename'] ?? '';

  /// The internal value used by the underlying source control to represent this build. Empty string if not available.
  static String get versionIncremental =>
      _deviceParameters['versionIncremental'] ?? '';

  /// The developer preview revision of a prerelease SDK. Empty string if not available.
  static String get versionPreviewSdk =>
      _deviceParameters['versionPreviewSdk'] ?? '';

  /// The user-visible version string. Empty string if not available.
  static String get versionRelease => _deviceParameters['versionRelease'] ?? '';

  /// The user-visible SDK version of the framework.
  ///
  /// Possible values are defined in: https://developer.android.com/reference/android/os/Build.VERSION_CODES.html
  /// Empty string if not available.
  static String get versionSdk => _deviceParameters['versionSdk'] ?? '';

  /// The user-visible security patch level. Empty string if not available.
  static String get versionSecurityPatch =>
      _deviceParameters['versionSecurityPatch'] ?? '';

  // iOS

  /// Device name. Empty string if not available.
  static String get name => _deviceParameters['name'] ?? '';

  /// The name of the current operating system. Empty string if not available.
  static String get systemName => _deviceParameters['systemName'] ?? '';

  /// The current operating system version. Empty string if not available.
  static String get systemVersion => _deviceParameters['systemVersion'] ?? '';

  /// Localized name of the device model. Empty string if not available.
  static String get localizedModel => _deviceParameters['localizedModel'] ?? '';

  /// Unique UUID value identifying the current device. Empty string if not available.
  static String get identifierForVendor =>
      _deviceParameters['identifierForVendor'] ?? '';

  /// Operating system information derived from `sys/utsname.h`. Empty string if not available.
  static String get utsname => _deviceParameters['utsname'] ?? '';

  /// Operating system name. Empty string if not available.
  static String get utsnameSysname => _deviceParameters['utsnameSysname'] ?? '';

  /// Network node name. Empty string if not available.
  static String get utsnameNodename =>
      _deviceParameters['utsnameNodename'] ?? '';

  /// Release level. Empty string if not available.
  static String get utsnameRelease => _deviceParameters['utsnameRelease'] ?? '';

  /// Version level. Empty string if not available.
  static String get utsnameVersion => _deviceParameters['utsnameVersion'] ?? '';

  /// Hardware type (e.g. 'iPhone7,1' for iPhone 6 Plus). Empty string if not available.
  static String get utsnameMachine => _deviceParameters['utsnameMachine'] ?? '';
}
