///
import 'dart:ui' as ui show TextHeightBehavior;

///
import '/controller.dart';

///
import '/view.dart';

///
abstract class RadioButtons<T> extends StatefulWidget {
  ///
  const RadioButtons({
    super.key,
    required this.controller,
    this.inChanged,
  });

  /// The controller that
  final RadioButtonsController<T> controller;

  /// Optional method called when radio button is changed
  final void Function(T v)? inChanged;

  /// Compose the radio widgets in this function.
  Widget radioButtons(BuildContext context);

  /// Optional function called when radio button is changed
  void onChanged(T v) {}

  @override
  State createState() => _RadioButtonsState<T>();
}

///
class _RadioButtonsState<T> extends StateX<RadioButtons<T>> {
  @override
  void initState() {
    add(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.radioButtons(context);
}

/// Returns the 'Radio' widgets
List<Widget> radioButtonsBuilder(
  // Radio
  List<String> items,
  RadioButtonsController<dynamic> controller, {
  double? space,
  MouseCursor? mouseCursor,
  bool? toggleable,
  Color? activeColor,
  WidgetStateProperty<Color?>? fillColor,
  MaterialTapTargetSize? materialTapTargetSize,
  VisualDensity? visualDensity,
  Color? focusColor,
  Color? hoverColor,
  WidgetStateProperty<Color?>? overlayColor,
  double? splashRadius,
  FocusNode? focusNode,
  bool? autofocus,
  bool? useCupertinoCheckmarkStyle,
  // Text
  TextStyle? style,
  StrutStyle? strutStyle,
  TextAlign? textAlign,
  TextDirection? textDirection,
  Locale? locale,
  bool? softWrap,
  TextOverflow? overflow,
  TextScaler? textScaler,
  int? maxLines,
  String? semanticsLabel,
  TextWidthBasis? textWidthBasis,
  ui.TextHeightBehavior? textHeightBehavior,
  Color? selectionColor,
  // Flexible
  int? flex,
  FlexFit? fit,
  // Flex
  Axis? direction, // Axis.vertical or Axis.horizontal
  MainAxisAlignment? mainAxisAlignment,
  MainAxisSize? mainAxisSize,
  CrossAxisAlignment? crossAxisAlignment,
  VerticalDirection? verticalDirection,
  TextBaseline? textBaseline,
  Clip? clipBehavior,
}) {
  //
  Widget Function(String i) buildRadioButton;

  if (useCupertinoCheckmarkStyle == null) {
    //
    buildRadioButton = (String i) => Radio<String>(
          value: i,
          groupValue: controller.groupValue,
          onChanged: controller.disabled ? null : controller.onChanged,
          mouseCursor: mouseCursor,
          toggleable: toggleable ?? false,
          activeColor: activeColor,
          fillColor: fillColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          overlayColor: overlayColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
        );
  } else {
    //
    buildRadioButton = (String i) => Radio<String>.adaptive(
          value: i,
          groupValue: controller.groupValue,
          onChanged: controller.disabled ? null : controller.onChanged,
          mouseCursor: mouseCursor,
          toggleable: toggleable ?? false,
          activeColor: activeColor,
          fillColor: fillColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          overlayColor: overlayColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          useCupertinoCheckmarkStyle: useCupertinoCheckmarkStyle,
        );
  }
  final List<Widget> radioButtons = [];

  final radioItems = items
      .map((String i) => <Widget>[
            Flexible(
              child: buildRadioButton(i),
            ),
            Flexible(
              flex: flex ?? 1,
              fit: fit ?? FlexFit.loose,
              child: Text(
                i,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textDirection: textDirection,
                locale: locale,
                softWrap: softWrap,
                overflow: overflow,
                textScaler: textScaler,
                maxLines: maxLines,
                semanticsLabel: semanticsLabel,
                textWidthBasis: textWidthBasis,
                textHeightBehavior: textHeightBehavior,
                selectionColor: selectionColor,
              ),
            ),
          ])
      .toList();
  //
  space ??= 0;

  for (final widget in radioItems) {
    //
    if (direction == null) {
      //
      radioButtons.add(widget[0]);

      if (space > 0) {
        radioButtons.add(SizedBox(width: space));
      }
      radioButtons.add(widget[1]);
    } else {
      //
      radioButtons.add(
        Flex(
          direction: direction,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          textDirection: textDirection,
          verticalDirection: verticalDirection ?? VerticalDirection.down,
          textBaseline: textBaseline,
          clipBehavior: clipBehavior ?? Clip.none,
          children: widget,
        ),
      );
    }
  }
  return radioButtons;
}

///
class RadioButtonsController<T> extends StateXController {
  /// Supply the initial value of the Radio buttons
  RadioButtonsController({this.initialValue, bool? disabled}) {
    this.disabled = disabled ?? false;
    groupValue = initialValue;
  }

  /// The radio button initial selected
  final T? initialValue;

  /// If the radio buttons are disabled or not
  bool disabled = false;

  /// The current value
  T? groupValue;

  /// Determine if changed from the initial value
  bool get isChanged => groupValue != initialValue;

  @override
  void initState() {
    super.initState();
    final widget = state?.widget;
    if (widget != null && widget is RadioButtons<T>) {
      statefulWidget = widget;
    }
  }

  /// The StatefulWidget used.
  RadioButtons<T>? statefulWidget;

  /// Called when a button is changed.
  @mustCallSuper
  void onChanged(T? v) {
    if (v != null) {
      groupValue = v;
      statefulWidget?.inChanged?.call(v);
      statefulWidget?.onChanged(v);
      state?.setState(() {});
    }
  }
}
