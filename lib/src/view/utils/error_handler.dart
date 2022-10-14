///
/// Copyright (C) 2020 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  10 Feb 2020
///
///
import 'dart:ui' as ui
    show
        Paragraph,
        ParagraphBuilder,
        ParagraphConstraints,
        ParagraphStyle,
        TextStyle;

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart'
    show
        DiagnosticPropertiesBuilder,
        DiagnosticsTreeStyle,
        FlutterError,
        FlutterErrorDetails,
        FlutterExceptionHandler,
        InformationCollector,
        StringProperty;

import 'package:flutter/rendering.dart'
    show
        Color,
        DiagnosticPropertiesBuilder,
        EdgeInsets,
        FlutterError,
        Offset,
        Paint,
        PaintingContext,
        RenderBox,
        RenderObjectWithChildMixin,
        Size,
        StringProperty,
        TextAlign,
        TextDirection;

/// Define the type of function to handle errors.
typedef ReportErrorHandler = Future<void> Function(
    dynamic exception, StackTrace stack);

/// Your App's error handler.
class AppErrorHandler {
  /// Singleton Pattern with only one instance of this Error Handler.
  /// Optionally supply the Error handler, Builder, and Report routines.
  factory AppErrorHandler({
    FlutterExceptionHandler? handler,
    ErrorWidgetBuilder? screen,
    ReportErrorHandler? report,
    bool? allowNewHandlers,
  }) {
    //
    _this ??= AppErrorHandler._();

    /// Allows you to set an error handler more than once.
    final reassigned = set(handler: handler, screen: screen, report: report);

    // Allow for null. Simply allow new handles by default
    allowNewHandlers ??= true;

    // Once set to false, you can't assign different handlers anymore.
    // However, it's set to false only if one of the handlers was reassigned.
    if (!allowNewHandlers && reassigned) {
      _allowNewHandlers = false;
    }
    return _this!;
  }

  AppErrorHandler._() {
    // Record the current error handler.
    _oldOnError = FlutterError.onError;

    // Record the current Widget builder when a widget fails to build.
    _oldBuilder = ErrorWidget.builder;

    // At the start, define our own 'error building widget' widget if one is not provided.
    ErrorWidget.builder = errorDisplayWidget;

    FlutterError.onError = (FlutterErrorDetails details) {
      // Prevent an infinite loop and fall back to the original handler.
      if (_inHandler) {
        // An error in the Error Handler
        if (_onError != null && _oldOnError != null) {
          _onError = null;
          try {
            _oldOnError!(details);
          } catch (ex) {
            // intentionally left empty.
          }
        }
        return;
      }

      // If there's an error in the error handler, we want to know about it.
      _inHandler = true;

      final _handler = _onError ?? _oldOnError;

      if (_handler != null) {
        _handler(details);
        _inHandler = false;
      }
    };
    // Record the 'current' error handler.
    _flutterExceptionHandler = FlutterError.onError;
  }
  static AppErrorHandler? _this;
  static bool _allowNewHandlers = true;

  // FlutterExceptionHandler get oldOnError => _oldOnError;
  static FlutterExceptionHandler? _oldOnError;
  //
  // ErrorWidgetBuilder get oldBuilder => _oldBuilder;
  ErrorWidgetBuilder? _oldBuilder;

  static ReportErrorHandler? _errorReport;

  static bool _inHandler = false;

  /// Flag indicating the App has already executed.
  @Deprecated('A mutable static property is discouraged.')
  // Not certain why this is here in the first place.
  static bool ranApp = false;

  /// Return the current 'Flutter Exception Handler.'
  FlutterExceptionHandler? get flutterExceptionHandler =>
      _flutterExceptionHandler;
  static FlutterExceptionHandler? _flutterExceptionHandler;

  /// Return either the current and previous Error Handler.
  FlutterExceptionHandler? get onError => _onError ?? _oldOnError;
  static FlutterExceptionHandler? _onError;

  /// Set a handler and the report
  static bool set({
    FlutterExceptionHandler? handler,
    ErrorWidgetBuilder? screen,
    ReportErrorHandler? report,
  }) {
    // Once you're not allowed to reset the handlers, it can't be reversed.
    if (!_allowNewHandlers) {
      return false;
    }

    // Are you allowed to reset a handler?
    // Only if an item was passed to reset.
    var reset = false;

    if (handler != null) {
      // The default is to dump the error to the console. You can do more.
      _onError = handler;
      reset = true;
    }

    if (report != null) {
      _errorReport = report;
      reset = true;
    }

    if (screen != null) {
      // Change the widget presented when another widget fails to build.
      ErrorWidget.builder = screen;
      reset = true;
    }
    // Something was set;
    return reset;
  }

  /// Display the Error details in a widget.
  /// try..catch to ensure a widget is returned.
  Widget displayError(FlutterErrorDetails details) {
    Widget widget;
    try {
      widget = ErrorWidget.builder(details);
    } catch (ex) {
      widget = errorDisplayWidget(details);
    }
    return widget;
  }

  /// Return the original handlers.
  void dispose() {
    // Restore the error widget routine.
    if (_oldBuilder != null) {
      ErrorWidget.builder = _oldBuilder!;
    }
    // Return the original error routine.
    if (_oldOnError != null) {
      FlutterError.onError = _oldOnError;
    }
  }

  /// Determines if running in an IDE or in production.
  static bool get inDebugger {
    var inDebugMode = false;
    // assert is removed in production.
    assert(inDebugMode = true);
    return inDebugMode;
  }

  /// Report the error.
  Future<void> reportError(
    dynamic ex,
    StackTrace stack, {
    String? message,
    String? library,
    InformationCollector? informationCollector,
  }) async {
    if (_errorReport == null) {
      message ??= 'while attempting to execute your app';
      library ??= 'Your app';
      _debugReportException(
        ErrorSummary(message),
        ex,
        stack,
        library: library,
        informationCollector: informationCollector,
      );
    } else {
      await _errorReport!(ex, stack);
    }
  }

  /// Report the error in an isolate.
  void isolateError(dynamic ex, StackTrace stack) {
    reportError(
      ex,
      stack,
      message: 'while attempting to execute main()',
      library: 'likely main.dart',
    );
  }

  /// Report the error in a zone.
  void runZonedError(dynamic ex, StackTrace stack) {
    reportError(
      ex,
      stack,
      message: 'while attempting to execute runApp()',
      library: 'controller/app.dart',
    );
  }

  /// Display the error details.
  // This is a copy used in the Flutter Framework.
  FlutterErrorDetails _debugReportException(
    DiagnosticsNode context,
    dynamic exception,
    StackTrace stack, {
    String library = 'Flutter framework',
    InformationCollector? informationCollector,
  }) {
    final details = FlutterErrorDetails(
      exception: exception,
      stack: stack,
      library: library,
      context: context,
      informationCollector: informationCollector,
    );
    FlutterError.reportError(details);
    return details;
  }

  /// This class is intentionally doing things using the low-level
  /// primitives to avoid depending on any subsystems that may have ended
  /// up in an unstable state -- after all, this class is mainly used when
  /// things have gone wrong.
  static Widget errorDisplayWidget(FlutterErrorDetails details) {
    String message;
    try {
      message = 'ERROR\n\n${details.exception}\n\n';

      final stackTrace = details.stack.toString().split('\n');

      final length = stackTrace.length > 5 ? 5 : stackTrace.length;

      final buffer = StringBuffer()..write(message);
      for (var i = 0; i < length; i++) {
        buffer.write('${stackTrace[i]}\n');
      }
      message = buffer.toString();
    } catch (e) {
      message = 'Error';
    }
    return _ErrorRenderObjectWidget(message: message, error: details.exception);
  }
}

/// A low-level widget to present instead of the failed widget.
class _ErrorRenderObjectWidget extends LeafRenderObjectWidget {
  /// Supply an error message to display and or a Error object.
  const _ErrorRenderObjectWidget({
    super.key,
    this.message,
    this.error,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
  });

  /// The message to display.
  final String? message;

  ///
  final Object? error;

  ///
  final ui.ParagraphStyle? paragraphStyle;

  ///
  final ui.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  @override
  RenderBox createRenderObject(BuildContext context) => _ErrorBox(
        message: _errorMessage(message, error),
        paragraphStyle: paragraphStyle,
        textStyle: textStyle,
        padding: padding,
        minimumWidth: minimumWidth,
        backgroundColor: backgroundColor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (error == null || error is! FlutterError) {
      properties.add(StringProperty('message', _errorMessage(message, error),
          quoted: false));
    } else {
      final FlutterError _flutterError = error as FlutterError;
      properties.add(_flutterError.toDiagnosticsNode(
          style: DiagnosticsTreeStyle.whitespace));
    }
  }
}

///
class ErrorWidgetDisplay {
  ///
  const ErrorWidgetDisplay({
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
    this.stackTrace = false,
  });

  ///
  final ui.ParagraphStyle? paragraphStyle;

  ///
  final ui.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  ///
  final bool? stackTrace;

  ///
  Widget builder(FlutterErrorDetails details) {
    String? message;
    try {
      //
      if (stackTrace != null && stackTrace!) {
        //
        message = 'ERROR\n\n${details.exception}\n\n';

        final stack = details.stack.toString().split('\n');

        final length = stack.length > 5 ? 5 : stack.length;

        final buffer = StringBuffer()..write(message);

        for (var i = 0; i < length; i++) {
          buffer.write('${stack[i]}\n');
        }
        message = buffer.toString();
      }
    } catch (e) {
      message = null;
    }
    return errorWidgetChild(
      details: details,
      message: message,
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor,
    );
  }

  ///
  Widget errorWidgetChild({
    Key? key,
    FlutterErrorDetails? details,
    String? message,
    Object? error,
    ui.ParagraphStyle? paragraphStyle,
    ui.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    CustomPainter? customPainter,
  }) {
    //
    if (details != null) {
      //
      error ??= details.exception;
    }

    // Default
    customPainter ??= _ErrorSymbol();

    //
    const double WIDTH = 30;

    return ErrorRenderObjectWidget(
      key: key,
      message: message,
      error: error,
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor,
      child: CustomPaint(
        size: Size(WIDTH, (WIDTH * 1).toDouble()),
        painter: customPainter,
      ),
    );
  }
}

///
class ErrorRenderObjectWidget extends SingleChildRenderObjectWidget {
  ///
  const ErrorRenderObjectWidget({
    super.key,
    this.message,
    this.error,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
    super.child,
  });

  ///
  final Object? error;

  /// The message to display.
  final String? message;

  ///
  final ui.ParagraphStyle? paragraphStyle;

  ///
  final ui.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  @override
  RenderBox createRenderObject(BuildContext context) => _ErrorBox(
        message: _errorMessage(message, error),
        paragraphStyle: paragraphStyle,
        textStyle: textStyle,
        padding: padding,
        minimumWidth: minimumWidth,
        backgroundColor: backgroundColor,
      );
}

/// Compose an error message to be displayed.
/// An empty string if no message was provided.
String _errorMessage(String? message, Object? error) {
  String _message;
  if (message == null || message.isEmpty) {
    if (error == null) {
      _message = '';
    } else {
      _message = error.toString();
    }
  } else {
    _message = message;
  }
  return _message;
}

class _ErrorBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  ///
  /// A message can optionally be provided. If a message is provided, an attempt
  /// will be made to render the message when the box paints.
  _ErrorBox({
    this.message = '',
    ui.ParagraphStyle? paragraphStyle,
    ui.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    //
    if (paragraphStyle != null) {
      _paragraphStyle = paragraphStyle;
    }
    _textStyle = textStyle ?? _initTextStyle();
    if (padding != null) {
      _padding = padding;
    }
    if (minimumWidth != null) {
      _minimumWidth = minimumWidth;
    }
    _backgroundColor = backgroundColor ?? _initBackgroundColor();
    final _message = message == null || message!.isEmpty
        ? 'Unknown Error!'
        : message!.trim();
    try {
      ///
      /// Generally, the much better way to draw text in a RenderObject is to
      /// use the TextPainter class. If you're looking for code to crib from,
      /// see the paragraph.dart file and the RenderParagraph class.
      final builder = ui.ParagraphBuilder(_paragraphStyle)
        ..pushStyle(_textStyle)
        ..addText(_message);
      _paragraph = builder.build();
    } catch (error) {
      // Intentionally left empty.
    }
  }

  /// The message to attempt to display at paint time.
  final String? message;

  ui.Paragraph? _paragraph;

  @override
  double computeMaxIntrinsicWidth(double height) {
    return 100000;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return 100000;
  }

  @override
  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void performResize() {
    size = constraints.constrain(const Size(100000, 100000));
  }

  /// The distance to place around the text.
  ///
  /// This is intended to ensure that if the [RenderBox] is placed at the top left
  /// of the screen, under the system's status bar, the error text is still visible in
  /// the area below the status bar.
  ///
  /// The padding is ignored if the error box is smaller than the padding.
  ///
  /// See also:
  ///
  ///  * [_minimumWidth], which controls how wide the box must be before the
  //     horizontal padding is applied.
  EdgeInsets _padding = const EdgeInsets.fromLTRB(34, 96, 34, 12);

  /// The width below which the horizontal padding is not applied.
  ///
  /// If the left and right padding would reduce the available width to less than
  /// this value, then the text is rendered flush with the left edge.
  double _minimumWidth = 200;

  /// The color to use when painting the background of [RenderBox] objects.
  /// a red from a light gray.
  late Color _backgroundColor;

  /// Light gray in production; Red in development.
  Color _initBackgroundColor() {
    var result = const Color(0xF0C0C0C0);
    assert(() {
      result = const Color(0xF0900000);
      return true;
    }());
    return result;
  }

  /// The text style to use when painting [RenderBox] objects.
  /// a dark gray sans-serif font.
  late ui.TextStyle _textStyle;

  /// Black text in production; Yellow in development.
  ui.TextStyle _initTextStyle() {
    var result = ui.TextStyle(
      color: const Color(0xFF303030),
      fontFamily: 'sans-serif',
      fontSize: 18,
    );
    assert(() {
      result = ui.TextStyle(
        color: const Color(0xFFFFFF66),
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
      return true;
    }());
    return result;
  }

  /// The paragraph style to use when painting [RenderBox] objects.
  ui.ParagraphStyle _paragraphStyle = ui.ParagraphStyle(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
  );

  @override
  void paint(PaintingContext context, Offset offset) {
    try {
      context.canvas.drawRect(offset & size, Paint()..color = _backgroundColor);
      if (_paragraph != null) {
        var width = size.width;
        var left = 0.0;
        var top = 0.0;
        if (width > _padding.left + _minimumWidth + _padding.right) {
          width -= _padding.left + _padding.right;
          left += _padding.left;
        }
        _paragraph!.layout(ui.ParagraphConstraints(width: width));
        if (size.height > _padding.top + _paragraph!.height + _padding.bottom) {
          top += _padding.top;
        }
        context.canvas.drawParagraph(_paragraph!, offset + Offset(left, top));
      }
    } catch (ex) {
      // Intentionally left empty.
    }
  }
}

/// The Error symbol programmatically displayed.
class _ErrorSymbol extends CustomPainter {
  ///
  // ignore: non_constant_identifier_names
  final NaN = double.nan;

  //
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 4.414063, size.height * 9.287109);
    path_0.cubicTo(
        size.width * 2.734375,
        size.height * 9.044922,
        size.width * 1.376953,
        size.height * 7.898438,
        size.width * 0.8710938,
        size.height * 6.291016);
    path_0.cubicTo(
        size.width * 0.7382813,
        size.height * 5.873047,
        size.width * 0.6835938,
        size.height * 5.494141,
        size.width * 0.6835938,
        size.height * 5.000000);
    path_0.cubicTo(
        size.width * 0.6835938,
        size.height * 4.400391,
        size.width * 0.7714844,
        size.height * 3.921875,
        size.width * 0.9785156,
        size.height * 3.404297);
    path_0.cubicTo(
        size.width * 1.037109,
        size.height * 3.255859,
        size.width * 1.035156,
        size.height * 3.187500,
        size.width * 0.9687500,
        size.height * 3.150391);
    path_0.cubicTo(
        size.width * 0.9453125,
        size.height * 3.136719,
        size.width * 0.9570313,
        size.height * 3.103516,
        size.width * 1.031250,
        size.height * 2.958984);
    path_0.cubicTo(
        size.width * 1.119141,
        size.height * 2.792969,
        size.width * 1.126953,
        size.height * 2.783203,
        size.width * 1.181641,
        size.height * 2.789063);
    path_0.cubicTo(
        size.width * 1.259766,
        size.height * 2.796875,
        size.width * 1.283203,
        size.height * 2.775391,
        size.width * 1.423828,
        size.height * 2.564453);
    path_0.cubicTo(
        size.width * 2.054688,
        size.height * 1.615234,
        size.width * 3.083984,
        size.height * 0.9492188,
        size.width * 4.248047,
        size.height * 0.7363281);
    path_0.cubicTo(
        size.width * 4.451172,
        size.height * 0.6992188,
        size.width * 4.205078,
        size.height * 1.488281,
        size.width * 4.205078,
        size.height * 1.294922);
    path_0.cubicTo(
        size.width * 4.207031,
        size.height * 1.964844,
        size.width * 4.218750,
        size.height * 2.400391,
        size.width * 4.332031,
        size.height * 2.220703);
    path_0.cubicTo(
        size.width * 4.570313,
        size.height * 4.015625,
        size.width * 5.158203,
        size.height * 4.582031,
        size.width * 5.923828,
        size.height * 2.623047);
    path_0.cubicTo(
        size.width * 6.468750,
        size.height * 3.283203,
        size.width * 7.064453,
        size.height * 4.458984,
        size.width * 6.001953,
        size.height * 3.023438);
    path_0.cubicTo(
        size.width * 6.070313,
        size.height * 4.304688,
        size.width * 5.988281,
        size.height * 4.609375,
        size.width * 5.992188,
        size.height * 3.056641);
    path_0.cubicTo(
        size.width * 5.994141,
        size.height * 3.115234,
        size.width * 6.041016,
        size.height * 3.158203,
        size.width * NaN,
        size.height * NaN);
    path_0.lineTo(size.width * NaN, size.height * NaN);
    path_0.lineTo(size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_0.close();
    path_0.moveTo(size.width * 5.314453, size.height * 8.359375);
    path_0.cubicTo(
        size.width * 6.480469,
        size.height * 8.240234,
        size.width * 7.494141,
        size.height * 7.550781,
        size.width * 3.478516,
        size.height * 9.015625);
    path_0.cubicTo(
        size.width * 2.166016,
        size.height * 9.423828,
        size.width * 0.6035156,
        size.height * 8.390625,
        size.width * -0.4277344,
        size.height * 7.759766);
    path_0.cubicTo(
        size.width * -1.683594,
        size.height * 4.501953,
        size.width * -1.750000,
        size.height * 3.150391,
        size.width * -0.5800781,
        size.height * 7.453125);
    path_0.cubicTo(
        size.width * -1.173828,
        size.height * 8.089844,
        size.width * -1.361328,
        size.height * 8.464844,
        size.width * -1.066406,
        size.height * 8.425781);
    path_0.cubicTo(
        size.width * -1.552734,
        size.height * 10.50000,
        size.width * -1.066406,
        size.height * 11.47266,
        size.width * -0.4511719,
        size.height * 9.652344);
    path_0.cubicTo(
        size.width * 1.513672,
        size.height * 11.62500,
        size.width * 2.871094,
        size.height * 11.48828,
        size.width * NaN,
        size.height * NaN);
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);

    final Path path_1 = Path();
    path_1.moveTo(size.width * 3.199219, size.height * 6.802734);
    path_1.cubicTo(
        size.width * 2.884766,
        size.height * 6.488281,
        size.width * 2.832031,
        size.height * 6.427734,
        size.width * 2.832031,
        size.height * 6.376953);
    path_1.cubicTo(
        size.width * 2.832031,
        size.height * 6.326172,
        size.width * 2.916016,
        size.height * 6.234375,
        size.width * 3.490234,
        size.height * 5.660156);
    path_1.lineTo(size.width * 4.150391, size.height * 5.000000);
    path_1.lineTo(size.width * 3.490234, size.height * 4.339844);
    path_1.cubicTo(
        size.width * 2.921875,
        size.height * 3.771484,
        size.width * 2.832031,
        size.height * 3.673828,
        size.width * 2.832031,
        size.height * 3.623047);
    path_1.cubicTo(
        size.width * 2.832031,
        size.height * 3.574219,
        size.width * 2.888672,
        size.height * 3.509766,
        size.width * 3.199219,
        size.height * 3.199219);
    path_1.cubicTo(
        size.width * 2.867188,
        size.height * 3.572266,
        size.width * 2.832031,
        size.height * 3.630859,
        size.width * 2.832031,
        size.height * 3.259766);
    path_1.cubicTo(
        size.width * 2.832031,
        size.height * 3.380859,
        size.width * 2.886719,
        size.height * 3.982422,
        size.width * 3.486328,
        size.height * NaN);
    path_1.lineTo(size.width * 4.140625, size.height * NaN);
    path_1.lineTo(size.width * 4.796875, size.height * NaN);
    path_1.cubicTo(
        size.width * 5.361328,
        size.height * NaN,
        size.width * 4.142578,
        size.height * NaN,
        size.width * 4.142578,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 4.142578,
        size.height * NaN,
        size.width * 4.199219,
        size.height * NaN,
        size.width * 4.509766,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 4.843750,
        size.height * NaN,
        size.width * 4.882813,
        size.height * NaN,
        size.width * 4.943359,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 5.005859,
        size.height * NaN,
        size.width * 5.056641,
        size.height * NaN,
        size.width * 5.654297,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 6.007813,
        size.height * NaN,
        size.width * 6.302734,
        size.height * NaN,
        size.width * 6.310547,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 6.318359,
        size.height * NaN,
        size.width * 6.615234,
        size.height * NaN,
        size.width * 6.968750,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 7.562500,
        size.height * NaN,
        size.width * 7.615234,
        size.height * NaN,
        size.width * 6.968750,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 6.935547,
        size.height * NaN,
        size.width * 6.601563,
        size.height * NaN,
        size.width * 6.658203,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 6.283203,
        size.height * NaN,
        size.width * 6.234375,
        size.height * NaN,
        size.width * 6.607422,
        size.height * NaN);
    path_1.cubicTo(
        size.width * 6.458984,
        size.height * NaN,
        size.width * 5.892578,
        size.height * NaN,
        size.width * NaN,
        size.height * NaN);
    path_1.lineTo(size.width * NaN, size.height * NaN);
    path_1.lineTo(size.width * NaN, size.height * NaN);
    path_1.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_1.cubicTo(size.width * NaN, size.height * NaN, size.width * NaN,
        size.height * NaN, size.width * NaN, size.height * NaN);
    path_1.close();

    final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff000000).withOpacity(1);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
