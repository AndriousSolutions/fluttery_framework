// ignore_for_file: unused_element

// Copyright 2020 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  10 Feb 2020
//
//
import 'dart:ui' as i
    show ParagraphBuilder, ParagraphConstraints, ParagraphStyle, TextStyle;

import '/controller.dart'
    show
        CupertinoPageRoute,
        HandleError,
        MaterialPageRoute,
        Route,
        RouteSettings;

import '/view.dart'
    show
        App,
        AppStateExtension,
        BuildContext,
        Color,
        Colors,
        CustomPainter,
        DiagnosticPropertiesBuilder,
        DiagnosticsNode,
        DiagnosticsTreeStyle,
        EdgeInsets,
        ErrorSummary,
        ErrorWidget,
        ErrorWidgetBuilder,
        FlutterError,
        FlutterErrorDetails,
        FlutterExceptionHandler,
        FontWeight,
        Icons,
        InformationCollector,
        LeafRenderObjectWidget,
        Offset,
        Paint,
        PaintingContext,
        PaintingStyle,
        Rect,
        StateXonErrorMixin,
        TextBaseline,
        TextDirection,
        Widget;

import 'package:flutter/rendering.dart'
    show
        Color,
        DiagnosticPropertiesBuilder,
        EdgeInsets,
        ErrorDescription,
        FlutterError,
        Key,
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
class AppErrorHandler with HandleError, StateXonErrorMixin {
  /// Singleton Pattern with only one instance of this Error Handler.
  /// Optionally supply the Error handler, Builder, and Report routines.
  factory AppErrorHandler({
    FlutterExceptionHandler? handler,
    ErrorWidgetBuilder? screen,
    ReportErrorHandler? report,
    bool? presentError, //  Present error to user or not
    bool? allowNewErrorHandlers,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    //
    _this ??= AppErrorHandler._();

    /// Allows you to set an error handler more than once.
    set(
      handler: handler,
      screen: screen,
      report: report,
      presentError: presentError,
      allowNewErrorHandlers: allowNewErrorHandlers,
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor,
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
        if (_errorHandler != null && _oldOnError != null) {
          _errorHandler = null;
          try {
            _oldOnError!(details);
          } catch (ex) {
            // Intentionally blank
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
            (FlutterErrorDetails details) => displayErrorWidget(
                  details,
                  paragraphStyle: _paragraphStyle,
                  textStyle: _textStyle,
                  padding: _padding,
                  minimumWidth: _minimumWidth,
                  backgroundColor: _backgroundColor,
                );
      }

      final handler = _errorHandler ?? _oldOnError;

      if (handler != null) {
        handler(details);
        _inHandler = false;
      }
    };
    // Record the 'current' error handler.
    _flutteryExceptionHandler = FlutterError.onError;
    _flutteryErrorWidgetBuilder = ErrorWidget.builder;
  }
  static AppErrorHandler? _this;

  /// Explicitly call the assigned Error routine.
  @override
  void onError(FlutterErrorDetails details) =>
      flutteryExceptionHandler?.call(details);

  /// Allow new handlers in the future or not
  static bool get allowNewErrorHandlers => _allowNewErrorHandlers;

  /// Lets you to disallow but then never allows you again
  static set allowNewErrorHandlers(bool? allow) {
    // Once set false, that's it.
    if (_allowNewErrorHandlers) {
      if (allow != null) {
        _allowNewErrorHandlers = allow;
      }
    }
  }

  //
  static bool _allowNewErrorHandlers = true;

  static bool _givenErrorHandler = false;

  /// The original Error Handler at start up.
  FlutterExceptionHandler? get oldOnError => _oldOnError;
  FlutterExceptionHandler? _oldOnError;

  /// The original Displayed Error Widget at start up.
  ErrorWidgetBuilder? get oldBuilder => _oldBuilder;
  static ErrorWidgetBuilder? _oldBuilder;

  static ReportErrorHandler? _errorReport;

  bool _inHandler = false;

  /// Flag indicating the App has already executed.
  @Deprecated('A mutable static property is discouraged.')
  // Not certain why this is here in the first place.
  static bool ranApp = false;

  /// Return the App's Error Handler'
  FlutterExceptionHandler? get flutteryExceptionHandler =>
      _flutteryExceptionHandler;
  FlutterExceptionHandler? _flutteryExceptionHandler;

  /// the App's ErrorWidget.builder;
  ErrorWidgetBuilder? _flutteryErrorWidgetBuilder;

  /// The current Error Handler. Used in app_state.dart
  @Deprecated('Use flutteryExceptionHandler instead.')
  FlutterExceptionHandler? get errorHandler => _errorHandler;
  static FlutterExceptionHandler? _errorHandler;

  /// Return the Error Handling
  void activate() {
    if (_flutteryExceptionHandler != null) {
      FlutterError.onError = _flutteryExceptionHandler;
    }
    if (_flutteryErrorWidgetBuilder != null) {
      ErrorWidget.builder = _flutteryErrorWidgetBuilder!;
    }
  }

  /// Restore the error routines.
  void deactivate() => _restoreErrorHandler();

  /// Return the original handlers.
  void dispose() {
    // Ensure the handler is created all over again
    _this = null;
    // Reset allowances
    _allowNewErrorHandlers = true;
    _givenErrorHandler = false;
    // Ensure error routines are reset, but then set to null
    deactivate();
    // App's FlutterError.onError
    _flutteryExceptionHandler = null;
    // the App's ErrorWidget.builder;
    _flutteryErrorWidgetBuilder = null;
    // Keep it if testing however
    if (App.inWidgetsFlutterBinding) {
      _oldBuilder = null;
    }
    _oldOnError = null;
  }

  /// Set a handler and the report
  static bool set({
    FlutterExceptionHandler? handler,
    ErrorWidgetBuilder? screen,
    ReportErrorHandler? report,
    bool? allowNewErrorHandlers,
    bool? presentError,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    // Any subsequent assignments are not permitted.
    _presentError ??= presentError;

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
      _errorHandler = handler;
      reset = true;
    }

    if (report != null) {
      _errorReport = report;
      reset = true;
    }

    if (screen != null) {
      // Record the current 'Error Widget'
      _oldBuilder ??= ErrorWidget.builder;
      // if not already assigned
      if (ErrorWidget.builder != screen) {
        ErrorWidget.builder = screen;
      }
      reset = true;
    }

    // Flag when something was assigned
    if (!_givenErrorHandler && reset) {
      // Set only once
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

  /// Reset the Error Handler and such.
  @Deprecated('No longer publicly available.')
  bool reset() => _restoreErrorHandler();

  /// Restore the Error Handler and such.
  bool _restoreErrorHandler() {
    if (_oldBuilder != null) {
      ErrorWidget.builder = _oldBuilder!;
    }
    if (_oldOnError != null) {
      FlutterError.onError = _oldOnError;
    }
    return _oldBuilder != null && _oldOnError != null;
  }

  /// Present error to user or not
  static bool get presentError => _presentError ?? true;
  static set presentError(bool? present) {
    if (present != null) {
      _presentError = present;
    }
  }

  static bool? _presentError;

  /// The general appearance of the 'Error Widget' displayed when there's an error.
  static i.ParagraphStyle? _paragraphStyle;
  static i.TextStyle? _textStyle;
  static EdgeInsets? _padding;
  static double? _minimumWidth;
  static Color? _backgroundColor;

  /// Log the error
  @override
  void logErrorDetails(FlutterErrorDetails details) {
    // Won't log this time with this call.
    if (logError) {
      super.logErrorDetails(details);
    } else {
      logError = true; // Next time.
    }
  }

  /// Flag whether to log error details or not
  bool logError = true;

  /// Display the Error details in a widget.
  /// try..catch to ensure a widget is returned.
  Widget displayError(FlutterErrorDetails details) {
    Widget widget;
    try {
      widget = ErrorWidget.builder(details);
    } catch (ex) {
      // low-level primitives used to display the error
      widget = displayErrorWidget(details);
    }
    return widget;
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
      message ??= 'while attempting to run your app';
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
    // Record the Exception
    getError(ex);

    FlutterError.reportError(FlutterErrorDetails(
      exception: ex,
      stack: StackTrace.current,
      context: ErrorDescription('error in main()'),
      library: 'main.dart',
    ));
  }

  /// Report the error in a zone.
  void runZonedError(dynamic ex, StackTrace stack) {
    // Record the Exception
    getError(ex);

    FlutterError.reportError(FlutterErrorDetails(
      exception: ex,
      stack: stack,
      context: ErrorDescription('error in file containing main()'),
      library: 'main.dart',
    ));
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

  ///
  @Deprecated('Use displayErrorWidget instead.')
  static Widget errorDisplayWidget(
    FlutterErrorDetails details, {
    Key? key,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    bool? stackTrace,
  }) =>
      displayErrorWidget(
        details,
        key: key,
        paragraphStyle: paragraphStyle,
        textStyle: textStyle,
        padding: padding,
        minimumWidth: minimumWidth,
        backgroundColor: backgroundColor,
        stackTrace: stackTrace,
      );

  /// This function is intentionally doing things using the low-level
  /// primitives to avoid depending on any subsystems that may have ended
  /// up in an unstable state -- after all, this class is mainly used when
  /// things have gone wrong.
  static Widget displayErrorWidget(
    FlutterErrorDetails details, {
    Key? key,
    String? header,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    bool? stackTrace,
  }) {
    //
    String? message;
    //
    try {
      //
      message = '\n\n${details.exception}\n\n';

      if (details.stack != null && (stackTrace ?? true)) {
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
    //
    return _ErrorRenderObjectWidget(
      key: key,
      header: header,
      message: message,
      error: details.exception,
      paragraphStyle: paragraphStyle,
      textStyle: textStyle,
      padding: padding,
      minimumWidth: minimumWidth,
      backgroundColor: backgroundColor ?? const Color(0xFFFFFFFF),
    );
  }

  /// Using the low-level primitives to avoid an unstable state
  static Route<dynamic>? onUnknownRoute(
    RouteSettings settings, {
    FlutterErrorDetails? details,
    String? header,
    String? message,
    StackTrace? stack,
    String? library,
    String? description,
  }) {
    //
    if (details == null) {
      //
      message ??= 'Route "${settings.name}" not found!';
      description ??=
          'The onUnknownRoute callback returned this screen instead.';
      details = FlutterErrorDetails(
        exception: Exception(message),
        stack: stack,
        library: library,
        context: ErrorDescription(description),
      );
    }
    final widget = displayErrorWidget(details, header: header ?? '404');
    Route<dynamic> route;
    if (App.useMaterial) {
      route = MaterialPageRoute<dynamic>(
          builder: (_) => widget, settings: settings);
    } else {
      route = CupertinoPageRoute<dynamic>(
          builder: (_) => widget, settings: settings);
    }
    return route;
  }
}

/// A low-level widget to present instead of the failed widget.
class _ErrorRenderObjectWidget extends LeafRenderObjectWidget {
  /// Supply an error message to display and or a Error object.
  const _ErrorRenderObjectWidget({
    super.key,
    this.header,
    this.message,
    this.error,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
  });

  /// Header of the text
  final String? header;

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
        header: header,
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
      final FlutterError flutterError = error as FlutterError;
      properties.add(flutterError.toDiagnosticsNode(
          style: DiagnosticsTreeStyle.whitespace));
    }
  }
}

/// Compose an error message to be displayed.
/// An empty string if no message was provided.
String _errorMessage(String? message, Object? error) {
  String message0;

  if (message == null || message.isEmpty) {
    //
    if (error == null) {
      message0 = '';
    } else {
      message0 = error.toString();
    }
  } else {
    message0 = message;
  }
  return message0;
}

class _ErrorBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  ///
  /// A message can optionally be provided. If a message is provided, an attempt
  /// will be made to render the message when the box paints.
  _ErrorBox({
    this.header,
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

      _drawWordERROR(context, 0, text: header ?? 'Oops!');

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

  /// Header beginning the test displayed
  String? header;

  /// The message to attempt to display at paint time.
  String? _message;

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
    var width = size.width;
    if (width > _padding.left + _minimumWidth + _padding.right) {
      width -= _padding.left + _padding.right;
    }

    paragraph.layout(i.ParagraphConstraints(width: width));

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

/// A simply 'Widget Error' Screen if an app's widget fails to display
@Deprecated("Use 'AppErrorHandler.displayErrorWidget()' instead.")
class AppWidgetErrorDisplayed {
  ///
  const AppWidgetErrorDisplayed({
    this.key,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
    this.customPainter,
    this.stackTrace,
  });

  ///
  final Key? key;

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
    Key? key,
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    bool? stackTrace,
  }) =>
      AppErrorHandler.displayErrorWidget(
        key: key ?? this.key,
        details,
        paragraphStyle: paragraphStyle ?? this.paragraphStyle,
        textStyle: textStyle ?? this.textStyle,
        padding: padding ?? this.padding,
        minimumWidth: minimumWidth ?? this.minimumWidth,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        stackTrace: stackTrace ?? this.stackTrace ?? false,
      );
}
