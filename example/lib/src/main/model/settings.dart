// ignore_for_file: avoid_classes_with_only_static_members, avoid_positional_boolean_parameters

import 'dart:async' show Future;

// The fluttery framework.
import 'package:fluttery_framework/view.dart' show AppSettings;

import 'package:flutter/material.dart'
    show StatelessWidget, TextStyle, VoidCallback;

import '/src/view.dart' show Prefs;

///
class Settings {
  ///
  static bool get(String? setting) {
    if (setting == null || setting.trim().isEmpty) {
      return false;
    }
    return Prefs.getBool(setting, false);
  }

  ///
  static Future<bool> set(String? setting, bool value) {
    if (setting == null || setting.trim().isEmpty) {
      return Future.value(false);
    }
    return Prefs.setBool(setting, value);
  }

  ///
  static bool getOrder() => Prefs.getBool('order_of_items', false);

  ///
  static Future<bool> setOrder(bool value) =>
      Prefs.setBool('order_of_items', value);

  ///
  static bool getLeftHanded() => Prefs.getBool('left_handed', false);

  ///
  static Future<bool> setLeftHanded(bool value) =>
      Prefs.setBool('left_handed', value);

  ///
  static StatelessWidget tapText(String text, VoidCallback onTap,
          {TextStyle? style}) =>
      AppSettings.tapText(text, onTap, style: style);
}
