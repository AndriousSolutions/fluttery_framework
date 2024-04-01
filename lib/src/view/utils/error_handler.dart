// ignore_for_file: unused_element

/// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  10 Feb 2020
///
///
import 'dart:ui' as i
    show
//        Paragraph,
        ParagraphBuilder,
        ParagraphConstraints,
        ParagraphStyle,
        TextStyle;

import '/view.dart';

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

/// Define the type of function to handle isolate and run zone errors.
typedef ReportErrorHandler = Future<void> Function(
    Object exception, StackTrace stack);

/// {@category Error handling}
/// Your App's error handler.
class AppErrorHandler {
  /// Singleton Pattern with only one instance of this Error Handler.
  /// Optionally supply the Error handler, Builder, and Report routines.
  factory AppErrorHandler({
    FlutterExceptionHandler? handler,
    ErrorWidgetBuilder? screen,
    ReportErrorHandler? report,
    bool? allowNewErrorHandlers,
  }) {
    //
    _this ??= AppErrorHandler._();

    /// Allows you to set an error handler more than once.
    set(
      handler: handler,
      screen: screen,
      report: report,
      allowNewErrorHandlers: allowNewErrorHandlers,
    );

    return _this!;
  }

  AppErrorHandler._() {
    // Record the current error handler.
    _oldOnError = FlutterError.onError;

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

      // Supply an custom 'Error Widget' to display the error.
      if (_oldBuilder == null) {
        // Record the current Widget builder when a widget fails to build.
        _oldBuilder = ErrorWidget.builder;

        // Define our own 'error building widget' widget if one is not provided.
        ErrorWidget.builder =
            (FlutterErrorDetails details) => errorDisplayWidget(
                  details,
                  paragraphStyle: _paragraphStyle,
                  textStyle: _textStyle,
                  padding: _padding,
                  minimumWidth: _minimumWidth,
                  backgroundColor: _backgroundColor,
                );
      }

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

  /// Allow new handlers in the future
  static bool allowNewErrorHandlers = true;
  static bool _givenErrorHandler = false;

  // FlutterExceptionHandler get oldOnError => _oldOnError;
  static FlutterExceptionHandler? _oldOnError;
  //
  // ErrorWidgetBuilder get oldBuilder => _oldBuilder;
  static ErrorWidgetBuilder? _oldBuilder;

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
    bool? allowNewErrorHandlers,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    // Any subsequent assignments are not permitted.
    _paragraphStyle ??= paragraphStyle;

    _textStyle ??= textStyle;

    _padding ??= padding;

    _minimumWidth ??= minimumWidth;

    _backgroundColor ??= backgroundColor;

    // Once you're not allowed to set the handlers, they can't be changed.
    if (_givenErrorHandler && !AppErrorHandler.allowNewErrorHandlers) {
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
      // Record the current 'Error Widget'
      _oldBuilder ??= ErrorWidget.builder;
      // Change the widget presented when another widget fails to build.
      ErrorWidget.builder = screen;
      reset = true;
    }

    // Set only once
    if (!_givenErrorHandler && reset) {
      _givenErrorHandler = true;
    }

    /// Allow for a new Error handler in the future
    if (AppErrorHandler.allowNewErrorHandlers &&
        !(allowNewErrorHandlers ?? true)) {
      // Once set to false, it's unchangeable
      AppErrorHandler.allowNewErrorHandlers = false;
    }

    // Something was set;
    return reset;
  }

  /// The general appearance of the 'Error Widget' displayed when there's an error.
  static i.ParagraphStyle? _paragraphStyle;
  static i.TextStyle? _textStyle;
  static EdgeInsets? _padding;
  static double? _minimumWidth;
  static Color? _backgroundColor;

  /// Display the Error details in a widget.
  /// try..catch to ensure a widget is returned.
  Widget displayError(FlutterErrorDetails details) {
    Widget widget;
    try {
      widget = ErrorWidget.builder(details);
    } catch (ex) {
      // low-level primitives used to display the error
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
  static bool get inDebugMode {
    var inDebugMode = false;
    // assert is removed in production.
    assert(inDebugMode = true);
    return inDebugMode;
  }

  /// Report the error in an isolate or in a run zone.
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

  /// Supplies the error details to the designated error handler.
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

  /// This function is intentionally doing things using the low-level
  /// primitives to avoid depending on any subsystems that may have ended
  /// up in an unstable state -- after all, this class is mainly used when
  /// things have gone wrong.
  static Widget errorDisplayWidget(
    FlutterErrorDetails details, {
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
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
    return _ErrorRenderObjectWidget(
      message: message,
      error: details.exception,
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor,
    );
  }
}

/// A simply 'Widget Error' Screen if an app's widget fails to display
class AppWidgetErrorDisplayed {
  ///
  const AppWidgetErrorDisplayed({
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
    this.customPainter,
    this.stackTrace = false,
  });

  ///
  final i.ParagraphStyle? paragraphStyle;

  ///
  final i.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  ///
  final CustomPainter? customPainter;

  ///
  final bool? stackTrace;

  ///
  Widget builder(
    FlutterErrorDetails details, {
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    CustomPainter? customPainter,
  }) {
    String? message;
    try {
      //
      message = '\n\n${details.exception}\n\n';

      if (details.stack != null && stackTrace != null && stackTrace!) {
        //
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
    return _ErrorRenderObjectWidget(
      message: message,
      error: details.exception,
      paragraphStyle: paragraphStyle ?? this.paragraphStyle,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      minimumWidth: minimumWidth ?? this.minimumWidth,
      backgroundColor:
          backgroundColor ?? this.backgroundColor ?? const Color(0xFFFFFFFF),
    );
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
  final i.ParagraphStyle? paragraphStyle;

  ///
  final i.TextStyle? textStyle;

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

/// Compose an error message to be displayed.
/// An empty string if no message was provided.
String _errorMessage(String? message, Object? error) {
  String _message;

  if (message == null || message.isEmpty) {
    //
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
    String? message,
    i.ParagraphStyle? paragraphStyle,
    // ignore: avoid_unused_constructor_parameters
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    // Supply a style if not explicitly provided.
    _paragraphStyle = paragraphStyle ??
        i.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
        );

//    _textStyle = textStyle ?? _initTextStyle();  // Not used??

    _padding = padding ?? const EdgeInsets.fromLTRB(34, 96, 34, 12);

    _minimumWidth = minimumWidth ?? 200;

    _backgroundColor = backgroundColor ?? _initBackgroundColor();

    _message =
        message == null || message.isEmpty ? 'Unknown Error!' : message.trim();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    try {
      //
      context.canvas.drawRect(offset & size, Paint()..color = _backgroundColor);

      _drawWordERROR(context, 0, text: 'Oops!');

      _drawIcon(context, 50);

      _drawAppName(context, 100);

      _drawMessage(context, 150);

      _drawErrorMessage(context, 200, offset);

      // Draw a rectangle around the screen
      _drawRect(context);
//      }
    } catch (ex) {
      // If an error happens here we're in a terrible state, so we really should
      // just forget about it and let the developer deal with the already-reported
      // errors. It's unlikely that these errors are going to help with that.
    }
  }

  /// The message to attempt to display at paint time.
  late String? _message;

//  late i.Paragraph _paragraph;  // Not used??

  /// The paragraph style to use when painting [RenderBox] objects.
  late i.ParagraphStyle _paragraphStyle;

  /// The text style to use when painting [RenderBox] objects.
  /// a dark gray sans-serif font.
//  late i.TextStyle _textStyle;  // Not used??

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
  late EdgeInsets _padding;

  /// The width below which the horizontal padding is not applied.
  ///
  /// If the left and right padding would reduce the available width to less than
  /// this value, then the text is rendered flush with the left edge.
  late double _minimumWidth;

  /// The color to use when painting the background of [RenderBox] objects.
  /// a red from a light gray.
  late Color _backgroundColor;

  @override
  double computeMaxIntrinsicWidth(double height) => 100000;

  @override
  double computeMaxIntrinsicHeight(double width) => 100000;

  // 'RenderBox subclasses need to either override performLayout() to '
  // 'set a size and lay out any children, or, set sizedByParent to true '
  // 'so that performResize() sizes the render object.',
  @override
  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void performResize() {
    size = constraints.constrain(const Size(100000, 100000));
  }

  /// Light gray in production; Red in development.
  Color _initBackgroundColor() {
    var result = const Color(0xF0C0C0C0);
    assert(() {
      result = const Color(0xF0900000);
      return true;
    }());
    return result;
  }

  /// Black text in production; Yellow in development.
  i.TextStyle _initTextStyle() {
    var result = i.TextStyle(
      color: const Color(0xFF303030),
      fontFamily: 'sans-serif',
      fontSize: 18,
    );
    assert(() {
      result = i.TextStyle(
        color: const Color(0xFFFFFF66),
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
      return true;
    }());
    return result;
  }

  void _drawWordERROR(PaintingContext context, double top, {String? text}) {
    text ??= 'ERROR';
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.center,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.red,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText(text);
    final paragraph = builder.build();
    paragraph.layout(i.ParagraphConstraints(width: _minimumWidth));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top, //(size.height - paragraph.height) * 0.5,
      ),
    );
  }

  void _drawIcon(PaintingContext context, double top) {
    const icon = Icons.error;
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      fontFamily: icon.fontFamily,
    ))
      ..addText(String.fromCharCode(icon.codePoint));
    final paragraph = builder.build();
    paragraph.layout(i.ParagraphConstraints(width: size.width * 0.5));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top,
      ),
    );
  }

  void _drawAppName(PaintingContext context, double top) {
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.center,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.black,
        fontSize: 18,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText('${App.appName}\n${App.version}');
    final paragraph = builder.build();
    paragraph.layout(
        i.ParagraphConstraints(width: (size.width - paragraph.width) * 0.5));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top,
      ),
    );
  }

  void _drawMessage(PaintingContext context, double top) {
    const text = 'An error has occurred in this app.\n';
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.black,
        fontSize: 24,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText(text);
    final paragraph = builder.build();
    paragraph
        .layout(i.ParagraphConstraints(width: size.width - _padding.right));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        _padding.left,
        _padding.top + top,
      ),
    );
  }

  void _drawErrorMessage(PaintingContext context, double top, Offset offset) {
    //
    final builder = i.ParagraphBuilder(_paragraphStyle)
      ..pushStyle(i.TextStyle(color: Colors.black, fontSize: 18))
      ..addText(_message!);

    final paragraph = builder.build();

    //
    var _width = size.width;
    if (_width > _padding.left + _minimumWidth + _padding.right) {
      _width -= _padding.left + _padding.right;
    }

    paragraph.layout(i.ParagraphConstraints(width: _width));

    context.canvas.drawParagraph(
        paragraph, offset + Offset(_padding.left, _padding.top + top));
  }

  // Draw a rectangle around the screen
  void _drawRect(PaintingContext context) {
    final right = size.width - _padding.right / 2;
    final bottom = size.height - _padding.bottom;
    final rect =
        Rect.fromLTRB(_padding.left / 2, _padding.top / 2, right, bottom);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    context.canvas.drawRect(rect, paint);
  }
}
