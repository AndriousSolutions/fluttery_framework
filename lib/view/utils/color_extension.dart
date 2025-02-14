//
import 'dart:ui';

///
/// Addresses the following conversion error since Flutter 3.27
/// "'value' is deprecated and shouldn't be used. Use component accessors like .r"
/// https://github.com/flutter/flutter/issues/160184#issuecomment-2540720622
///
///

/// This class is to supplement deprecated_member_use for value
/// value converted RGBA into a 32 bit integer, but the SDK doesn't provide
/// a successor?
extension ColorExts on Color {
  /// Replaced in Dart 2.9.0 with toARGB32() in class Color
  // /// A 32 bit value representing this color.
  // ///
  // /// The bits are assigned as follows:
  // ///
  // /// * Bits 24-31 are the alpha value.
  // /// * Bits 16-23 are the red value.
  // /// * Bits 8-15 are the green value.
  // /// * Bits 0-7 are the blue value.
  // int get toARGB32 =>
  //     floatToInt8(a) << 24 |
  //     floatToInt8(r) << 16 |
  //     floatToInt8(g) << 8 |
  //     floatToInt8(b) << 0;

  ///
  int get intAlpha => floatToInt8(a);

  ///
  int get intRed => floatToInt8(r);

  ///
  int get intGreen => floatToInt8(g);

  ///
  int get intBlue => floatToInt8(b);

  ///
  static int floatToInt8(double x) => (x * 255.0).round() & 0xff;
}
