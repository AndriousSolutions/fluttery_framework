// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  09 Mar 2019
//
//

import 'dart:async' show Future;

import 'package:flutter/material.dart'
    show AssetImage, BuildContext, DefaultAssetBundle;

import 'package:flutter/services.dart' show AssetBundle, ByteData;

/// The Assets manager for this custom framework.
class Assets {
  /// Singleton pattern
  factory Assets() => _this ??= Assets._();
  Assets._();
  static Assets? _this;

  /// Initialize the App's Assets Manager.
  Future<bool> init(BuildContext context, {String? dir}) {
    if (_assets == null) {
      _assets = DefaultAssetBundle.of(context);
      _dir = dir ?? 'assets';
    }
    return Future.value(true);
  }

  static AssetBundle? _assets;
  static String? _dir;

  /// Clean up after the Assets Manager
  void dispose() {
    _assets = null;
  }

  /// Retrieve a 'ByteData' object by its Key value.
  static Future<ByteData> getStreamF(String key) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    ByteData data;
    try {
      data = await Assets._assets!.load('$setPath(key)$key');
    } catch (ex) {
      data = ByteData(0);
    }
    return data;
  }

  /// Retrieve a String value by its Key value.
  static Future<String> getStringF(String key, {bool cache = true}) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    String asset;
    try {
      asset =
          await Assets._assets!.loadString('$setPath(key)$key', cache: cache);
    } catch (ex) {
      asset = '';
    }
    return asset;
  }

  /// Retrieve an object of type, T, by its String value.
  /// Supply a parser function to process the operation.
  /// (See. Flutter's [AssetBundle.loadStructuredData]
  Future<T?> getData<T>(
      String key, Future<T> Function(String value) parser) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    T? data;
    try {
      data =
          await Assets._assets!.loadStructuredData('$setPath(key)$key', parser);
    } catch (ex) {
      data = null;
    }
    return data;
  }

  /// Retrieve a String by its Key value.
  /// Supply a parser function to process the operation.
  /// (See. Flutter's [AssetBundle.loadStructuredData]
  Future<String?> getStringData(
      String key, Future<String> Function(String value) parser) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    String? data;
    try {
      data =
          await Assets._assets!.loadStructuredData('$setPath(key)$key', parser);
    } catch (ex) {
      data = null;
    }
    return data;
  }

  /// Retrieve a boolean value by its Key value.
  /// Supply a parser function to process the operation.
  /// (See. Flutter's [AssetBundle.loadStructuredData]
  Future<bool> getBoolData(
      String key, Future<bool> Function(String value) parser) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    bool data;
    try {
      data =
          await Assets._assets!.loadStructuredData('$setPath(key)$key', parser);
    } catch (ex) {
      data = false;
    }
    return data;
  }

  /// Retrieve an AssetImage by its Key value.
  /// Supply a parser function to process the operation.
  /// (See. Flutter's [AssetBundle.loadStructuredData]
  AssetImage getImage(String key, {AssetBundle? bundle, String? package}) =>
      AssetImage(key, bundle: bundle, package: package);

  /// Determine the appropriate path for the asset.
  static String? setPath(String key) {
    /// In case 'assets' begins the key or if '/' begins the key.
    final path = key.indexOf(_dir!) == 0
        ? ''
        : key.substring(0, 0) == '/'
            ? _dir
            : '$_dir/';
    return path;
  }
}
