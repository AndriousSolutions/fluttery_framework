/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_view.dart';

void testStringExtension() {
  //
//  test('Test String Extension', () async {
  '123'.isNum;

  '123'.isNumericOnly;

  '123'.isAlphabetOnly;

  '123'.isBool;

  '123'.isVectorFileName;

  '123'.isImageFileName;

  '123'.isAudioFileName;

  '123'.isVideoFileName;

  '123'.isTxtFileName;

  '123'.isDocumentFileName;

  '123'.isExcelFileName;

  '123'.isPPTFileName;

  '123'.isAPKFileName;

  '123'.isPDFFileName;

  '123'.isHTMLFileName;

  '123'.isURL;

  '123'.isEmail;

  '123'.isPhoneNumber;

  '123'.isDateTime;

  '123'.isMD5;

  '123'.isSHA1;

  '123'.isSHA256;

  '123'.isBinary;

  '123'.isIPv4;

  '123'.isIPv6;

  '123'.isHexadecimal;

  '123'.isPalindrom;

  '123'.isPassport;

  '123'.isCurrency;

  '123'.isCpf;

  '123'.isCnpj;

  '123'.isCaseInsensitiveContains('2');

  '123'.isCaseInsensitiveContainsAny('2');

  '123'.capitalize;

  '123'.capitalizeFirst;

  '123'.removeAllWhitespace;

  'camelCase'.camelCase;

  '123'.paramCase;

  '123'.numericOnly();

  '123'.createPath();

  '123'.capitalizeAllWordsFirstLetter();
//  });
}
