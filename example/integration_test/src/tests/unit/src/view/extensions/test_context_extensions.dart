/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import '../_unit_test_view.dart';

void testContextExtension(BuildContext context) {
  //
//  test('Test Context Extension', () async {
  //
  context.mediaQuerySize;

  context.height;

  context.width;

  context.heightTransformer();

  context.widthTransformer();

  context.ratio();

  context.theme;

  context.isDarkMode;

  context.iconColor;

  context.textTheme;

  context.mediaQueryPadding;

  context.mediaQuery;

  context.mediaQueryViewPadding;

  context.mediaQueryViewInsets;

  context.orientation;

  context.isLandscape;

  context.isPortrait;

  context.devicePixelRatio;

  context.textScaleFactor;

  context.mediaQueryShortestSide;

  context.showNavbar;

  context.isPhone;

  context.isSmallTablet;

  context.isLargeTablet;

  context.isTablet;

  context.responsiveValue<String>(
    mobile: 'mobile',
    tablet: 'tablet',
    desktop: 'desktop',
    watch: 'watch',
  );
//  });
}
