# Extensions
## _Extending Flutter's Capabilities_

These extensions alone would be reason enough to use the Fluttery Framework.
Thanks to Jonny Borges (author of GetX), I've incorporated many of his tried
and true extensions.

<ul style="list-style-type: none">
   <li><a href="#context">Context</a></li>
   <li><a href="#double">Double</a></li>
   <li><a href="#duration">Duration</a></li>
   <li><a href="#dynamic">Dynamic</a></li>
   <li><a href="#number">Number</a></li>
   <li><a href="#string">String</a></li>
   <li><a href="#widget">Widget</a></li>
</ul>

<h2 id="context">Context</h2>

```Dart
Widget build(BuildContext context) {
  
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
```

<h2 id="double">Double</h2>

```Dart
  1.21643.toPrecision(2);
```

<h2 id="duration">Duration</h2>

```Dart
  2.seconds.delay(() async {});
```

<h2 id="dynamic">Dynamic</h2>

```Dart
  ' '.isBlank;
```

<h2 id="number">Number</h2>

```Dart
  123.isLowerThan(12);

  123.isGreaterThan(12);

  123.isEqual(12);

  2.delay(() {});

  100.milliseconds;

  2.seconds;

  3.minutes;

  0.3.hours;

  .5.days;
```

<h2 id="string">String</h2>

```Dart
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
```

<h2 id="widget">Widget</h2>

```Dart
  const widget = SizedBox();

  widget.paddingAll(2);

  widget.paddingSymmetric(horizontal: 2, vertical: 2);

  widget.paddingOnly(left: 1, top: 2, right: 3, bottom: 4);

  widget.paddingZero;

  widget.marginAll(2);

  widget.marginSymmetric();

  widget.marginOnly();

  widget.marginZero;
```