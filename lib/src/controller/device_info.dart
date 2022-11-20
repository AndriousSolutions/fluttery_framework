///
/// Copyright (C) 2019 Andrious Solutions c/o Jakub Homlala
///
/// https://github.com/Andrious/catcher/blob/de2e19d0be34b35382c29903f546d4119607bd1c/lib/core/catcher.dart#L121
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  11 Feb 2019
///
///
//import 'dart:io' show Platform;
// Replace 'dart:io' for Web applications

import 'package:device_info_plus/device_info_plus.dart';

/// Gets the ANDROID_ID for android and identifierForVendor for iOS platforms.
import 'package:unique_identifier/unique_identifier.dart';

import 'package:universal_platform/universal_platform.dart';

// ignore: avoid_classes_with_only_static_members
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

    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      // Supply the device's unique identifier.
      _deviceId = await UniqueIdentifier.serial;
    }

    final info = await DeviceInfoPlugin().deviceInfo;

    return _deviceParameters =
        info.data.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Supply the device information
  static Map<String, String> get data => _deviceParameters;

  /// The unique identifier of the device
  static String get deviceId => _deviceId ?? '';

// // ignore: avoid_classes_with_only_static_members
// /// Supplies the devices information.
// class DeviceInfo {
//   static bool _init = false;
//   static late Map<String, dynamic> _deviceParameters = {};
// //  static Map<String, dynamic> _applicationParameters = Map();
//
//   /// Collect all the Device's information.
//   static Future<Map<String, dynamic>> initAsync() async {
//     //
//     if (_init) {
//       return _deviceParameters;
//     }
//
//     _init = true;
//
//     if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
//       // Supply the device's unique identifier.
//       _deviceId = await UniqueIdentifier.serial;
//     }
//
//     if (UniversalPlatform.isAndroid) {
//       final info = await DeviceInfoPlugin().androidInfo;
//       _loadAndroidParameters(info);
//     } else if (UniversalPlatform.isIOS) {
//       final info = await DeviceInfoPlugin().iosInfo;
//       _loadiOSParameters(info);
//     } else if (UniversalPlatform.isWeb) {
//       final info = await DeviceInfoPlugin().webBrowserInfo;
//       _loadBrowserParameters(info);
//     } else if (UniversalPlatform.isWindows) {
//       final info = await DeviceInfoPlugin().windowsInfo;
//       _loadWindowsParameters(info);
//     } else if (UniversalPlatform.isFuchsia) {
//     } else if (UniversalPlatform.isLinux) {
//       final info = await DeviceInfoPlugin().linuxInfo;
//       _loadLinuxParameters(info);
//     } else if (UniversalPlatform.isMacOS) {
//       final info = await DeviceInfoPlugin().macOsInfo;
//       _loadMacOsParameters(info);
//     }
//     return _deviceParameters;
//   }
//
//   /// The unique identifier of the device
//   static String get deviceId => _deviceId ?? '';
//   static String? _deviceId;
//
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
//
//   static void _loadAndroidParameters(AndroidDeviceInfo info) {
//     _deviceParameters =  info.data;
//     // The base OS build the product is based on.
//     _deviceParameters['baseOS'] = info.version.baseOS;
//     // The current development codename
//     _deviceParameters['codename'] = info.version.codename;
//     // The internal value used by the underlying source control
//     _deviceParameters['incremental'] = info.version.incremental;
//     // The developer preview revision of a pre-release SDK
//     _deviceParameters['previewSdkInt'] = info.version.previewSdkInt;
//     // The user-visible version string.
//     _deviceParameters['release'] = info.version.release;
//     // The user-visible SDK version of the framework.
//     _deviceParameters['sdkInt'] = info.version.sdkInt;
//     // The user-visible security patch level.
//     _deviceParameters['securityPatch'] = info.version.securityPatch;
//     // Either a changelist number, or a label like "M4-rc20".
//     _deviceParameters['id'] = info.id;
//     // _deviceParameters['androidId'] = androidDeviceInfo.androidId;
//     _deviceParameters['board'] = info.board;
//     _deviceParameters['bootloader'] = info.bootloader;
//     _deviceParameters['brand'] = info.brand;
//     _deviceParameters['device'] = info.device;
//     _deviceParameters['display'] = info.display;
//     _deviceParameters['fingerprint'] = info.fingerprint;
//     _deviceParameters['hardware'] = info.hardware;
//     _deviceParameters['host'] = info.host;
//     _deviceParameters['isPsychicalDevice'] = info.isPhysicalDevice;
//     _deviceParameters['manufacturer'] = info.manufacturer;
//     _deviceParameters['model'] = info.model;
//     _deviceParameters['product'] = info.product;
//     _deviceParameters['supported32BitAbis'] = info.supported32BitAbis;
//     _deviceParameters['supported64BitAbis'] = info.supported64BitAbis;
//     _deviceParameters['supportedAbis'] = info.supportedAbis;
//     _deviceParameters['tags'] = info.tags;
//     _deviceParameters['type'] = info.type;
//     _deviceParameters['versionBaseOs'] = info.version.baseOS;
//     _deviceParameters['versionCodename'] = info.version.codename;
//     _deviceParameters['versionIncremental'] = info.version.incremental;
//     _deviceParameters['versionPreviewSdk'] = info.version.previewSdkInt;
//     _deviceParameters['versionRelease'] = info.version.release;
//     _deviceParameters['versionSdk'] = info.version.sdkInt;
//     _deviceParameters['versionSecurityPatch'] = info.version.securityPatch;
//   }
//
//   static void _loadiOSParameters(IosDeviceInfo info) {
//     _deviceParameters['name'] = info.name;
//     _deviceParameters['systemName'] = info.systemName;
//     _deviceParameters['systemVersion'] = info.systemVersion;
//     _deviceParameters['model'] = info.model;
//     _deviceParameters['localizedModel'] = info.localizedModel;
//     _deviceParameters['identifierForVendor'] = info.identifierForVendor;
//     _deviceParameters['isPsychicalDevice'] = info.isPhysicalDevice;
//     _deviceParameters['utsname'] = info.utsname;
//
//     _deviceParameters['utsnameSysname'] = info.utsname.sysname;
//     _deviceParameters['utsnameNodename'] = info.utsname.nodename;
//     _deviceParameters['utsnameRelease'] = info.utsname.release;
//     _deviceParameters['utsnameVersion'] = info.utsname.version;
//     _deviceParameters['utsnameMachine'] = info.utsname.machine;
//   }
//
//   static void _loadBrowserParameters(WebBrowserInfo info) {
//     // the name of the current browser.
//     _deviceParameters['name'] = info.browserName.name;
//     // the internal "code" name of the current browser.
//     _deviceParameters['appCodeName'] = info.appCodeName;
//     // a DOMString with the official name of the browser.
//     _deviceParameters['appName'] = info.appName;
//     // the version of the browser as a DOMString.
//     _deviceParameters['appVersion'] = info.appVersion;
//     // the amount of device memory in gigabytes.
//     _deviceParameters['deviceMemory'] = info.deviceMemory;
//     // the number of logical processor cores available.
//     _deviceParameters['hardwareConcurrency'] = info.hardwareConcurrency;
//     // a DOMString representing the preferred language of the user, usually the language of the browser UI. .
//     _deviceParameters['language'] = info.language;
//     // an array of DOMString representing the languages known to the user, by order of preference.
//     _deviceParameters['languages'] = info.languages;
//     // the version of the browser as a DOMString.
//     _deviceParameters['platform'] = info.platform;
//     // Always returns 'Gecko', on any browser.
//     _deviceParameters['product'] = info.product;
//     // the build number of the current browser
//     _deviceParameters['productSub'] = info.productSub;
//     // the build number of the current browser
//     _deviceParameters['userAgent'] = info.userAgent;
//     // the vendor name of the current browser
//     _deviceParameters['vendor'] = info.vendor;
//     // Returns the vendor version number
//     _deviceParameters['vendorSub'] = info.vendorSub;
//     // the maximum number of simultaneous touch contact points are supported by the current device.
//     _deviceParameters['maxTouchPoints'] = info.maxTouchPoints;
//     // the number of logical processor cores available.
//     _deviceParameters['hardwareConcurrency'] = info.hardwareConcurrency;
//   }
//
//   static void _loadWindowsParameters(WindowsDeviceInfo info) {
//     // The computer's fully-qualified DNS name, where available.
//     _deviceParameters['computerName'] = info.computerName;
//     // Number of CPU cores on the local machine
//     _deviceParameters['numberOfCores'] = info.numberOfCores;
//     // The physically installed memory in the computer.
//     _deviceParameters['systemMemoryInMegabytes'] = info.systemMemoryInMegabytes;
//     // userName
//     _deviceParameters['userName'] = info.userName;
//     // The major version number of the operating system.
//     _deviceParameters['majorVersion'] = info.majorVersion;
//     // The minor version number of the operating system.
//     _deviceParameters['minorVersion'] = info.minorVersion;
//     // The build number of the operating system.
//     _deviceParameters['buildNumber'] = info.buildNumber;
//     // The operating system platform.
//     _deviceParameters['platformId'] = info.platformId;
//     // The service-pack version string.
//     _deviceParameters['csdVersion'] = info.csdVersion;
//     // The major version number of the latest service pack installed on the system.
//     _deviceParameters['servicePackMajor'] = info.servicePackMajor;
//     // The minor version number of the latest service pack installed on the system.
//     _deviceParameters['servicePackMinor'] = info.servicePackMinor;
//     // The product suites available on the system.
//     _deviceParameters['suitMask'] = info.suitMask;
//     // The product type. This member contains additional information about the system.
//     _deviceParameters['productType'] = info.productType;
//     // Reserved for future use.
//     _deviceParameters['reserved'] = info.reserved;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\BuildLab` registry key.
//     _deviceParameters['buildLab'] = info.buildLab;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\BuildLabEx` registry key.
//     _deviceParameters['buildLabEx'] = info.buildLabEx;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId` registry key.
//     _deviceParameters['digitalProductId'] = info.digitalProductId;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DisplayVersion` registry key.
//     _deviceParameters['displayVersion'] = info.displayVersion;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\EditionID` registry key.
//     _deviceParameters['editionId'] = info.editionId;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\InstallDate` registry key.
//     _deviceParameters['installDate'] = info.installDate;
//     // Displayed as "Product ID" in Windows Settings.
//     _deviceParameters['productId'] = info.productId;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProductName` registry key.
//     _deviceParameters['productName'] = info.productName;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOwner` registry key.
//     _deviceParameters['registeredOwner'] = info.registeredOwner;
//     // Value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ReleaseId` registry key.
//     _deviceParameters['releaseId'] = info.releaseId;
//     // Displayed as "Device ID" in Windows Settings.
//     _deviceParameters['deviceId'] = info.deviceId;
//   }
//
//   static void _loadLinuxParameters(LinuxDeviceInfo info) {
//     // A string identifying the operating system, without a version component,
//     _deviceParameters['name'] = info.name;
//     // A string identifying the operating system version, excluding any OS name
//     _deviceParameters['version'] = info.version;
//     // A lower-case string identifying the operating system,
//     _deviceParameters['id'] = info.id;
//     // A space-separated list of operating system identifiers
//     _deviceParameters['idLike'] = info.idLike;
//     // A lower-case string identifying the operating system release code name
//     _deviceParameters['versionCodename'] = info.versionCodename;
//     // A lower-case string identifying the operating system version
//     _deviceParameters['versionId'] = info.versionId;
//     // A pretty operating system name in a format suitable for presentation
//     _deviceParameters['prettyName'] = info.prettyName;
//     // A string uniquely identifying the system image used
//     _deviceParameters['buildId'] = info.buildId;
//     // A string identifying a specific variant or edition of the operating system
//     _deviceParameters['variant'] = info.variant;
//     // A lower-case string identifying a specific variant of the operating system.
//     _deviceParameters['variantId'] = info.variantId;
//     // A unique machine ID of the local system that is set during installation
//     _deviceParameters['machineId'] = info.machineId;
//   }
//
//   static void _loadMacOsParameters(MacOsDeviceInfo info) {
//     // Name given to the local machine.
//     _deviceParameters['computerName'] = info.computerName;
//     // Operating system type
//     _deviceParameters['hostName'] = info.hostName;
//     // Machine cpu architecture
//     _deviceParameters['arch'] = info.arch;
//     // Device model
//     _deviceParameters['model'] = info.model;
//     // Machine Kernel version.
//     _deviceParameters['kernelVersion'] = info.kernelVersion;
//     // Operating system release number
//     _deviceParameters['osRelease'] = info.osRelease;
//     // Number of active CPUs
//     _deviceParameters['activeCPUs'] = info.activeCPUs;
//     // Machine's memory size
//     _deviceParameters['memorySize'] = info.memorySize;
//     // Device CPU Frequency
//     _deviceParameters['cpuFrequency'] = info.cpuFrequency;
//     // Device GUID
//     _deviceParameters['systemGUID'] = info.systemGUID;
//   }
}
