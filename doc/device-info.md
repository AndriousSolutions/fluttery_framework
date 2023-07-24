## _Mobile Phone Info._

There's an assortment of information available to you about the phone, for example, your app is running on.
Simply using the [DeviceInfo](https://pub.dev/documentation/fluttery_framework/latest/controller_device_info/DeviceInfo-class.html)
class and its omi-presence static properties to retain specific 
information anywhere at anytime about the host device your app is running on:

###### (Copy & paste and try it out.)
```Dart

import 'package:fluttery_framework_example/src/controller.dart';


void testingDeviceInfo() {
  /// Supplies all the device information below but all in a Map
  Map<String, dynamic> data = DeviceInfo.data;

  /// The name of the underlying board, like "goldfish". Empty string if not available.
  // or use nullable DeviceInfo.data['board']
  String board = DeviceInfo.board;

  /// The system bootloader version number. Empty string if not available.
  // or use nullable DeviceInfo.data['bootloader']
  String bootloader = DeviceInfo.bootloader;

  /// The consumer-visible brand with which the product/hardware will be associated, if any.
  /// Empty string if not available.
  //  or use nullable DeviceInfo.data['brand']
  String brand = DeviceInfo.brand;

  /// The name of the industrial design. Empty string if not available.
  // or use nullable DeviceInfo.data['device']
  String device = DeviceInfo.device;

  /// A build ID string meant for displaying to the user. Empty string if not available.
  // or use nullable DeviceInfo.data['display']
  String display = DeviceInfo.display;

  /// A string that uniquely identifies this build. Empty string if not available.
  // or use nullable DeviceInfo.data['fingerprint']
  String fingerprint = DeviceInfo.fingerprint;

  /// The name of the hardware (from the kernel command line or /proc). Empty string if not available.
  // or use nullable DeviceInfo.data['hardware']
  String hardware = DeviceInfo.hardware;

  /// Hostname. Empty string if not available.
  // or use nullable DeviceInfo.data['host']
  String host = DeviceInfo.host;

  /// Either a changelist number, or a label like "M4-rc20". Empty string if not available.
  // or use nullable DeviceInfo.data['id']
  String id = DeviceInfo.id;

  /// The manufacturer of the product/hardware. Empty string if not available.
  // or use nullable DeviceInfo.data['manufacturer']
  String manufacturer = DeviceInfo.manufacturer;

  /// The end-user-visible name for the end product. Empty string if not available.
  // or use nullable DeviceInfo.data['model']
  String model = DeviceInfo.model;

  /// The name of the overall product. Empty string if not available.
  // or use nullable DeviceInfo.data['product']
  String product = DeviceInfo.product;

  /// An ordered list of 32 bit ABIs supported by this device. Empty string if not available.
  // or use nullable DeviceInfo.data['supported32BitAbis']
  String supported32BitAbis = DeviceInfo.supported32BitAbis;

  /// An ordered list of 64 bit ABIs supported by this device. Empty string if not available.
  // or use nullable DeviceInfo.data['supported64BitAbis']
  String supported64BitAbis = DeviceInfo.supported64BitAbis;

  /// An ordered list of ABIs supported by this device. Empty string if not available.
  // or use nullable DeviceInfo.data['supportedAbis']
  String supportedAbis = DeviceInfo.supportedAbis;

  /// Comma-separated tags describing the build, like "unsigned,debug". Empty string if not available.
  // or use nullable DeviceInfo.data['tags']
  String tags = DeviceInfo.tags;

  /// The type of build, like "user" or "eng". Empty string if not available.
  // or use nullable DeviceInfo.data['type']
  String type = DeviceInfo.type;

  /// `false` if the application is running in an emulator, `true` otherwise. Empty string if not available.
  // or use nullable nullable DeviceInfo.data['isPhysicalDevice']
  String isPhysicalDevice = DeviceInfo.isPhysicalDevice;

  /// The base OS build the product is based on. Empty string if not available.
  // or use nullable DeviceInfo.data['versionBaseOs']
  String versionBaseOs = DeviceInfo.versionBaseOs;

  /// The current development codename, or the string "REL" if this is a release build. Empty string if not available.
  // or use nullable DeviceInfo.data['versionCodename']
  String versionCodename = DeviceInfo.versionCodename;

  /// The internal value used by the underlying source control to represent this build. Empty string if not available.
  // or use nullable DeviceInfo.data['versionIncremental']
  String versionIncremental = DeviceInfo.versionIncremental;

  /// The developer preview revision of a prerelease SDK. Empty string if not available.
  // or use nullable DeviceInfo.data['versionPreviewSdk']
  String versionPreviewSdk = DeviceInfo.versionPreviewSdk;

  /// The user-visible version string. Empty string if not available.
  // or use nullable DeviceInfo.data['versionRelease']
  String versionRelease = DeviceInfo.versionRelease;

  /// The user-visible SDK version of the framework.
  ///
  /// Possible values are defined in: https://developer.android.com/reference/android/os/Build.VERSION_CODES.html
  /// Empty string if not available.
  // or use nullable DeviceInfo.data['versionSdk']
  String versionSdk = DeviceInfo.versionSdk;

  /// The user-visible security patch level. Empty string if not available.
  // or use nullable DeviceInfo.data['versionSecurityPatch']
  String versionSecurityPatch = DeviceInfo.versionSecurityPatch;

  // iOS

  /// Device name. Empty string if not available.
  // or use nullable DeviceInfo.data['name']
  String name = DeviceInfo.name;

  /// The name of the current operating system. Empty string if not available.
  // or use nullable DeviceInfo.data['systemName']
  String systemName = DeviceInfo.systemName;

  /// The current operating system version. Empty string if not available.
  // or use nullable DeviceInfo.data['systemVersion']
  String systemVersion = DeviceInfo.systemVersion;

  /// Localized name of the device model. Empty string if not available.
  // or use nullable DeviceInfo.data['localizedModel']
  String localizedModel = DeviceInfo.localizedModel;

  /// Unique UUID value identifying the current device.
  /// Empty string if not available.
  // or use nullable DeviceInfo.data['identifierForVendor']
  String identifierForVendor = DeviceInfo.identifierForVendor;

  /// Operating system information derived from `sys/utsname.h`.
  /// Empty string if not available.
  // or use nullable DeviceInfo.data['utsname']
  String utsname = DeviceInfo.utsname;

  /// Operating system name. Empty string if not available.
  // or use nullable DeviceInfo.data['utsnameSysname']
  String utsnameSysname = DeviceInfo.utsnameSysname;

  /// Network node name. Empty string if not available.
  // or use nullable DeviceInfo.data['utsnameNodename']
  String utsnameNodename = DeviceInfo.utsnameNodename;

  /// Release level. Empty string if not available.
  // or use nullable DeviceInfo.data['utsnameRelease']
  String utsnameRelease = DeviceInfo.utsnameRelease;

  /// Version level. Empty string if not available.
  // or use nullable DeviceInfo.data['utsnameVersion']
  String utsnameVersion = DeviceInfo.utsnameVersion;

  /// Hardware type (e.g. 'iPhone7,1' for iPhone 6 Plus). Empty string if not available.
  // or use nullable DeviceInfo.data['utsnameMachine']
  String utsnameMachine = DeviceInfo.utsnameMachine;
}
```

