// ignore_for_file: avoid_classes_with_only_static_members
/// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  14 Nov 2019
///
///

class VarStr {
  static final VariableString _varStr = VariableString();

  /// Set a String value to the Variable String object.
  static String set(String str) => _varStr.value = str;

  /// Return the Variable String Object's value.
  static String get get => _varStr.value;
}

/// Variable String Class
class VariableString {
  /// Variable String Constructor.
  VariableString() {
    regExp = RegExp("'(.*?)'");
  }

  /// Reg Expression.
  late RegExp regExp;

  String _value = '';

  set value(String? str) {
    _value = '';
    if (str != null && str.isNotEmpty) {
      final match = regExp.firstMatch(str);
      if (match != null) {
        _value = match.group(0)!.replaceAll("'", '');
      }
    }
  }

  /// Return the Variable String Object's value.
  String get value => _value;
}
