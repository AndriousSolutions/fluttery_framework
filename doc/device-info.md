## _Mobile Phone Info._

There's an assortment of information available to you about the phone, for example, your app is running on.
Simply using the [DeviceInfo](https://pub.dev/documentation/fluttery_framework/latest/controller_device_info/DeviceInfo-class.html)
class and its omi-presence static properties to retain specific 
information anywhere at anytime about the host device your app is running on:

###### (Copy & paste and try it out.)
```Dart
  Map<String, dynamic> data = DeviceInfo.data;

  String board = DeviceInfo.board;

  String bootloader = DeviceInfo.bootloader;

  String brand = DeviceInfo.brand;

  String device = DeviceInfo.device;

  String display = DeviceInfo.display;

  String fingerprint = DeviceInfo.fingerprint;

  String hardware = DeviceInfo.hardware;

  String host = DeviceInfo.host;

  String id = DeviceInfo.id;

  String manufacturer = DeviceInfo.manufacturer;

  String model = DeviceInfo.model;

  String product = DeviceInfo.product;

  Strng supported32BitAbis = DeviceInfo.supported32BitAbis;

  String supported64BitAbis = DeviceInfo.supported64BitAbis;

  String supportedAbis = DeviceInfo.supportedAbis;

  String tags = DeviceInfo.tags;

  String type = DeviceInfo.type;

  String isPhysicalDevice = DeviceInfo.isPhysicalDevice;

  String versionBaseOs = DeviceInfo.versionBaseOs;

  String versionCodename = DeviceInfo.versionCodename;

  String versionIncremental = DeviceInfo.versionIncremental;

  String versionPreviewSdk = DeviceInfo.versionPreviewSdk;

  String versionRelease = DeviceInfo.versionRelease;

  String versionSdk = DeviceInfo.versionSdk;

  String versionSecurityPatch = DeviceInfo.versionSecurityPatch;

  String name = DeviceInfo.name;

  String systemName = DeviceInfo.systemName;

  String systemVersion = DeviceInfo.systemVersion;

  String localizedModel = DeviceInfo.localizedModel;

  String identifierForVendor = DeviceInfo.identifierForVendor;

  String utsname = DeviceInfo.utsname;

  String utsnameSysname = DeviceInfo.utsnameSysname;

  String utsnameNodename = DeviceInfo.utsnameNodename;

  String utsnameRelease = DeviceInfo.utsnameRelease;

  String utsnameVersion = DeviceInfo.utsnameVersion;

  String utsnameMachine = DeviceInfo.utsnameMachine;
```

