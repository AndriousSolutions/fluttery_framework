/// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  09 Apr 2020
///
///
mixin HandleError {
  /// Return the 'last' error if any.
  Exception? getError([dynamic error]) {
    var ex = _error;
    if (error == null) {
      _error = null;
    } else {
      if (error is! Exception) {
        _error = Exception(error.toString());
      } else {
        _error = error;
      }
      ex ??= _error;
    }
    return ex;
  }

  /// Simply display the error.
  String get errorMsg => _error == null ? '' : _error.toString();

  /// Indicate if app is 'in error.'
  bool get inError => _error != null;

  /// Indicate if the app is 'in error.'
  bool get hasError => _error != null;
  Exception? _error;
}
