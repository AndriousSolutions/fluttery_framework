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

import 'package:fluttery_framework/view.dart';

///
class RxBool extends Rx<bool> {
  ///
  //ignore: avoid_positional_boolean_parameters
  RxBool(super.value, super.hashCode, super.stateCode);

  @override
  String toString() {
    return value ? 'true' : 'false';
  }
}

// ///
// class RxnBool extends Rx<bool?> {
//   ///
//   //ignore: avoid_positional_boolean_parameters
//   RxnBool(super.value);
//
//   @override
//   String toString() {
//     return '$value';
//   }
// }

///
extension RxBoolExt on Rx<bool> {
  ///
  bool get isTrue => value;

  ///
  bool get isFalse => !isTrue;

  ///
  bool operator &(bool other) => other && value;

  ///
  bool operator |(bool other) => other || value;

  ///
  bool operator ^(bool other) => !other == value;

// /// Toggles the bool [value] between false and true.
// /// A shortcut for `flag.value = !flag.value;`
// /// FIXME: why return this? fluent interface is not
// ///  not really a dart thing since we have '..' operator
// // ignore: avoid_returning_this
// Rx<bool> toggle() {
//   subject.add(_value = !_value);
//   return this;
// }
}

// ///
// extension RxnBoolExt on Rx<bool?> {
//   ///
//   bool? get isTrue => value;
//
//   ///
//   bool? get isFalse {
//     if (value != null) {
//       return !isTrue!;
//     }
//     return null;
//   }
//
//   ///
//   bool? operator &(bool other) {
//     //
//     if (value != null) {
//       return other && value!;
//     }
//     return null;
//   }
//
//   ///
//   bool? operator |(bool other) {
//     //
//     if (value != null) {
//       return other || value!;
//     }
//     return null;
//   }
//
//   ///
//   bool? operator ^(bool other) => !other == value;
//
//   // /// Toggles the bool [value] between false and true.
//   // /// A shortcut for `flag.value = !flag.value;`
//   // /// FIXME: why return this? fluent interface is not
//   // ///  not really a dart thing since we have '..' operator
//   // // ignore: avoid_returning_this
//   // Rx<bool?>? toggle() {
//   //   if (_value != null) {
//   //     subject.add(_value = !_value!);
//   //     return this;
//   //   }
//   //   return null;
//   // }
// }
