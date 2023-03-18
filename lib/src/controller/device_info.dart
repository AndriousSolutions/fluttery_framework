// ignore_for_file: avoid_classes_with_only_static_members

/// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  11 Feb 2019
///
///
//import 'dart:io' show Platform;
// Replace 'dart:io' for Web applications

import 'package:device_info_plus/device_info_plus.dart'
    if (dart.library.html) 'package:device_info_plus/device_info_plus.dart';

/// Commented out to make it Linux and Windows compatible
// /// Gets the ANDROID_ID for android and identifierForVendor for iOS platforms.
// /// Returns an empty string for any other platform
// import 'package:unique_identifier/unique_identifier.dart'
//     if (dart.library.html) 'package:fluttery_framework/src/controller/unique_identifier.dart';

/// Supplies the devices information.
class DeviceInfo {
  static bool _init = false;
  static late Map<String, String> _deviceParameters = {};
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
  static Map<String, String> get data => _deviceParameters;

  /// The unique identifier of the device
  static String get deviceId => _deviceId ?? '';

  // Android

  /// The name of the underlying board, like "goldfish".
  @Deprecated("Use nullable DeviceInfo.data['board'] instead.")
  static String get board => _deviceParameters['board'] ?? '';

  /// The system bootloader version number.
  @Deprecated("Use nullable DeviceInfo.data['bootloader'] instead.")
  static String get bootloader => _deviceParameters['bootloader'] ?? '';

  /// The consumer-visible brand with which the product/hardware will be associated, if any.
  @Deprecated("Use nullable DeviceInfo.data['brand'] instead.")
  static String get brand => _deviceParameters['brand'] ?? '';

  /// The name of the industrial design.
  @Deprecated("Use nullable DeviceInfo.data['device'] instead.")
  static String get device => _deviceParameters['device'] ?? '';

  /// A build ID string meant for displaying to the user.
  @Deprecated("Use nullable DeviceInfo.data['display'] instead.")
  static String get display => _deviceParameters['display'] ?? '';

  /// A string that uniquely identifies this build.
  @Deprecated("Use nullable DeviceInfo.data['fingerprint'] instead.")
  static String get fingerprint => _deviceParameters['fingerprint'] ?? '';

  /// The name of the hardware (from the kernel command line or /proc).
  @Deprecated("Use nullable DeviceInfo.data['hardware'] instead.")
  static String get hardware => _deviceParameters['hardware'] ?? '';

  /// Hostname.
  @Deprecated("Use nullable DeviceInfo.data['host'] instead.")
  static String get host => _deviceParameters['host'] ?? '';

  /// Either a changelist number, or a label like "M4-rc20".
  @Deprecated("Use nullable DeviceInfo.data['id'] instead.")
  static String get id => _deviceParameters['id'] ?? '';

  /// The manufacturer of the product/hardware.
  @Deprecated("Use nullable DeviceInfo.data['manufacturer'] instead.")
  static String get manufacturer => _deviceParameters['manufacturer'] ?? '';

  /// The end-user-visible name for the end product.
  @Deprecated("Use nullable DeviceInfo.data['model'] instead.")
  static String get model => _deviceParameters['model'] ?? '';

  /// The name of the overall product.
  @Deprecated("Use nullable DeviceInfo.data['product'] instead.")
  static String get product => _deviceParameters['product'] ?? '';

  /// An ordered list of 32 bit ABIs supported by this device.
  @Deprecated("Use nullable DeviceInfo.data['supported32BitAbis'] instead.")
  static String get supported32BitAbis =>
      _deviceParameters['supported32BitAbis'] ?? '';

  /// An ordered list of 64 bit ABIs supported by this device.
  @Deprecated("Use nullable DeviceInfo.data['supported64BitAbis'] instead.")
  static String get supported64BitAbis =>
      _deviceParameters['supported64BitAbis'] ?? '';

  /// An ordered list of ABIs supported by this device.
  @Deprecated("Use nullable DeviceInfo.data['supportedAbis'] instead.")
  static String get supportedAbis => _deviceParameters['supportedAbis'] ?? '';

  /// Comma-separated tags describing the build, like "unsigned,debug".
  @Deprecated("Use nullable DeviceInfo.data['tags'] instead.")
  static String get tags => _deviceParameters['tags'] ?? '';

  /// The type of build, like "user" or "eng".
  @Deprecated("Use nullable DeviceInfo.data['type'] instead.")
  static String get type => _deviceParameters['type'] ?? '';

  /// `false` if the application is running in an emulator, `true` otherwise.
  @Deprecated("Use nullable DeviceInfo.data['isPhysicalDevice'] instead.")
  static String get isPhysicalDevice =>
      _deviceParameters['isPhysicalDevice'] ?? '';

  /// Removed from version 4.0.0 to avoid Google Play policies violations.
  // /// The Android hardware device ID that is unique between the device + user and app signing.
  // static String get androidId => _deviceParameters['androidId'] ?? '';

  /// The base OS build the product is based on.
  @Deprecated("Use nullable DeviceInfo.data['versionBaseOs'] instead.")
  static String get versionBaseOs => _deviceParameters['versionBaseOs'] ?? '';

  /// The current development codename, or the string "REL" if this is a release build.
  @Deprecated("Use nullable DeviceInfo.data['versionCodename'] instead.")
  static String get versionCodename =>
      _deviceParameters['versionCodename'] ?? '';

  /// The internal value used by the underlying source control to represent this build.
  @Deprecated("Use nullable DeviceInfo.data['versionIncremental'] instead.")
  static String get versionIncremental =>
      _deviceParameters['versionIncremental'] ?? '';

  /// The developer preview revision of a prerelease SDK.
  @Deprecated("Use nullable DeviceInfo.data['versionPreviewSdk'] instead.")
  static String get versionPreviewSdk =>
      _deviceParameters['versionPreviewSdk'] ?? '';

  /// The user-visible version string.
  @Deprecated("Use nullable DeviceInfo.data['versionRelease'] instead.")
  static String get versionRelease => _deviceParameters['versionRelease'] ?? '';

  /// The user-visible SDK version of the framework.
  ///
  /// Possible values are defined in: https://developer.android.com/reference/android/os/Build.VERSION_CODES.html
  @Deprecated("Use nullable DeviceInfo.data['versionSdk'] instead.")
  static String get versionSdk => _deviceParameters['versionSdk'] ?? '';

  /// The user-visible security patch level.
  @Deprecated("Use nullable DeviceInfo.data['versionSecurityPatch'] instead.")
  static String get versionSecurityPatch =>
      _deviceParameters['versionSecurityPatch'] ?? '';

  // iOS

  /// Device name.
  @Deprecated("Use nullable DeviceInfo.data['name'] instead.")
  static String get name => _deviceParameters['name'] ?? '';

  /// The name of the current operating system.
  @Deprecated("Use nullable DeviceInfo.data['systemName'] instead.")
  static String get systemName => _deviceParameters['systemName'] ?? '';

  /// The current operating system version.
  @Deprecated("Use nullable DeviceInfo.data['systemVersion'] instead.")
  static String get systemVersion => _deviceParameters['systemVersion'] ?? '';

  /// Localized name of the device model.
  @Deprecated("Use nullable DeviceInfo.data['localizedModel'] instead.")
  static String get localizedModel => _deviceParameters['localizedModel'] ?? '';

  /// Unique UUID value identifying the current device.
  @Deprecated("Use nullable DeviceInfo.data['identifierForVendor'] instead.")
  static String get identifierForVendor =>
      _deviceParameters['identifierForVendor'] ?? '';

  /// Operating system information derived from `sys/utsname.h`.
  @Deprecated("Use nullable DeviceInfo.data['utsname'] instead.")
  static String get utsname => _deviceParameters['utsname'] ?? '';

  /// Operating system name.
  @Deprecated("Use nullable DeviceInfo.data['utsnameSysname'] instead.")
  static String get utsnameSysname => _deviceParameters['utsnameSysname'] ?? '';

  /// Network node name.
  @Deprecated("Use nullable DeviceInfo.data['utsnameNodename'] instead.")
  static String get utsnameNodename =>
      _deviceParameters['utsnameNodename'] ?? '';

  /// Release level.
  @Deprecated("Use nullable DeviceInfo.data['utsnameRelease'] instead.")
  static String get utsnameRelease => _deviceParameters['utsnameRelease'] ?? '';

  /// Version level.
  @Deprecated("Use nullable DeviceInfo.data['utsnameVersion'] instead.")
  static String get utsnameVersion => _deviceParameters['utsnameVersion'] ?? '';

  /// Hardware type (e.g. 'iPhone7,1' for iPhone 6 Plus).
  @Deprecated("Use nullable DeviceInfo.data['utsnameMachine'] instead.")
  static String get utsnameMachine => _deviceParameters['utsnameMachine'] ?? '';
}
