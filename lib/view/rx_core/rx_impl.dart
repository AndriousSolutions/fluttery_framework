// ignore_for_file: comment_references
// MIT License
//
// Copyright (c) 2019 Jonny Borges
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:fluttery_framework/model.dart' show hash2;

import 'package:fluttery_framework/view.dart';

/// All the App's reactive dependencies
final _rxDependencies = <Rx<dynamic>, int>{};

final _stateHashCodes = <int, State>{};

/// Works with the App's StateX objects
///
/// dartdoc:
/// {@category StateX class}
mixin RxStates on State {
  ///
  Rx<T> watch<T>(T obj) {
    Rx<T> rx;
    switch (T) {
      case Rx<dynamic>:
        rx = watch((obj as Rx<dynamic>).value);
        break;
      case String:
        rx = RxString(obj as String, obj.hashCode, hashCode) as Rx<T>;
        break;
      case int:
        rx = RxInt(obj as int, obj.hashCode, hashCode) as Rx<T>;
        break;
      case double:
        rx = RxDouble(obj as double, obj.hashCode, hashCode) as Rx<T>;
        break;
      default:
        rx = Rx<T>(obj, obj.hashCode, hashCode);
    }
    _rxDependencies.putIfAbsent(rx, () => hashCode);
    _stateHashCodes.putIfAbsent(hashCode, () => this);
    return rx;
  }

  @override
  void dispose() {
    //
    _stateHashCodes.remove(hashCode);
    _rxDependencies.removeWhere((_, value) => value == hashCode);
    super.dispose();
  }
}

/// Foundation class used for custom `Types` outside the common native Dart
/// types.
/// For example, any custom "Model" class, like User().obs will use `Rx` as
/// wrapper.
class Rx<T> {
  ///
  Rx(T value, int hashCode, int stateCode) {
    _value = value;
    _hashCode = hashCode;
    _stateCode = stateCode;
  }

  late T _value;
  late int _hashCode;
  late int _stateCode;

  /// Makes this Rx looks like a function so you can update a new
  /// value using `rx(someOtherValue)`. Practical to assign the Rx directly
  /// to some Widget that has a signature ::onChange( value )
  ///
  /// Example:
  /// ```
  /// final myText = 'GetX rocks!'.obs;
  ///
  /// // in your Constructor, just to check it works :P
  /// ever( myText, print ) ;
  ///
  /// // in your build(BuildContext) {
  /// TextField(
  ///   onChanged: myText,
  /// ),
  ///```
  T call([T? v]) {
    if (v != null) {
      value = v;
    }
    return value;
  }

  @override
  String toString() => value.toString();

  /// Returns the json representation of `value`.
  dynamic toJson() => value;

  /// This equality override works for _RxImpl instances and the internal
  /// values.
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object o) {
    // Todo, find a common implementation for the hashCode of different Types.
    if (o is T) {
      return value == o;
    }
    if (o is Rx) {
      return value == o.value;
    }
    return false;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => _thisCode ??= hash2(_hashCode, _stateCode);
  int? _thisCode;

  /// Updates the [value] and adds it to the stream, updating the observer
  /// Widget, only if it's different from the previous value.
  set value(T val) {
    if (_value != val) {
      _value = val;
      final hashCode = _rxDependencies[this];
      if (hashCode != null) {
        final state = _stateHashCodes[hashCode];
        if (state == null) {
          _rxDependencies.remove(_hashCode);
        } else {
          if (state.mounted) {
            //ignore: invalid_use_of_protected_member
            state.setState(() {});
          } else {
            _rxDependencies.remove(_hashCode);
            _stateHashCodes.remove(hashCode);
          }
        }
      }
    }
  }

  /// Returns the current [value]
  T get value => _value;
}
