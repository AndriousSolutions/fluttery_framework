// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  05 Feb 2019
//

import '/view.dart';

/// A high-level function
/// Displays a String passing specific one to two button options
/// and their corresponding function calls.
/// Displays a particular dialogue box depending on platform.
Future<bool> showBox({
  required BuildContext context,
  String? text,
  Option? button01,
  Option? button02,
  VoidCallback? press01,
  VoidCallback? press02,
  Widget? title,
  EdgeInsetsGeometry? titlePadding,
  TextStyle? titleTextStyle,
  Widget? content,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? contentTextStyle,
  List<Widget>? actions,
  EdgeInsetsGeometry? actionsPadding,
  MainAxisAlignment? actionsAlignment,
  VerticalDirection? actionsOverflowDirection,
  double? actionsOverflowButtonSpacing,
  EdgeInsetsGeometry? buttonPadding,
  Color? backgroundColor,
  double? elevation,
  String? semanticLabel,
  EdgeInsets? insetPadding,
  Clip? clipBehavior,
  ShapeBorder? shape,
  bool? scrollable,
  bool? barrierDismissible,
  Color? barrierColor,
  String? barrierLabel,
  bool? useSafeArea,
  bool? useRootNavigator,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TextStyle? textStyle,
}) async {
  button01 ??= OKOption();
//  button02 ??= CancelOption();
  bool? result;

  if (App.useMaterial) {
    //
    result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea ?? true,
      useRootNavigator: useRootNavigator ?? false,
      routeSettings: routeSettings,
      builder: (BuildContext context) => AlertDialog(
          title: title,
          titlePadding: titlePadding,
          titleTextStyle: titleTextStyle,
          content: content ?? Text(text ?? ' '),
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(24, 20, 24, 24),
          contentTextStyle: contentTextStyle,
          actionsPadding: actionsPadding ?? EdgeInsets.zero,
          actionsAlignment: actionsAlignment,
          actionsOverflowDirection: actionsOverflowDirection,
          actionsOverflowButtonSpacing: actionsOverflowButtonSpacing,
          buttonPadding: buttonPadding,
          backgroundColor: backgroundColor,
          elevation: elevation,
          semanticLabel: semanticLabel,
          insetPadding: insetPadding ??
              const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          clipBehavior: clipBehavior ?? Clip.none,
          shape: shape,
          scrollable: scrollable ?? false,
          actions: <Widget>[
            if (button02 != null)
              textButtonOption<bool>(
//                key: const Key('button02'),
//                context: context,
                option: button02,
                onPressed: press02,
                text: 'Cancel',
                result: false,
              ),
            // if (button02 != null)
            //   TextButton(
            //     key: const Key('button02'),
            //     onPressed: () {
            //       if (press02 != null) {
            //         press02();
            //       }
            //       if (button02.onPressed != null) {
            //         button02.onPressed!();
            //       }
            //       Navigator.pop(context, button02.result ?? false);
            //     },
            //     onLongPress: button02.onLongPress,
            //     onHover: button02.onHover,
            //     onFocusChange: button02.onFocusChange,
            //     style: button02.style,
            //     focusNode: button02.focusNode,
            //     autofocus: button02.autofocus ?? false,
            //     clipBehavior: button02.clipBehavior,
            //     statesController: button02.statesController,
            //     isSemanticButton: button02.isSemanticButton ?? true,
            //     iconAlignment: button02.iconAlignment,
            //     child: button02.child ?? Text(button02.text ?? 'Cancel'),
            //   ),
            textButtonOption<bool>(
              // key: const Key('button01'),
//              context: context,
              option: button01,
              onPressed: press01,
              text: 'OK',
              result: true,
            ),
            // TextButton(
            //   key: const Key('button01'),
            //   onPressed: () {
            //     if (press01 != null) {
            //       press01();
            //     }
            //     if (button01!.onPressed != null) {
            //       button01.onPressed!();
            //     }
            //     Navigator.pop(context, button01.result ?? true);
            //   },
            //   onLongPress: button01?.onLongPress,
            //   onHover: button01?.onHover,
            //   onFocusChange: button01?.onFocusChange,
            //   style: button01?.style,
            //   focusNode: button01?.focusNode,
            //   autofocus: button01?.autofocus ?? false,
            //   clipBehavior: button01?.clipBehavior,
            //   statesController: button01?.statesController,
            //   isSemanticButton: button01?.isSemanticButton ?? true,
            //   iconAlignment: button01?.iconAlignment ?? IconAlignment.start,
            //   child: button01?.child ?? Text(button01!.text ?? 'OK'),
            // ),
          ]),
    );
  } else {
    // Ensure there's content
    content = content ?? Text(text ?? ' ');

    result = await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator ?? false,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: title,
        content: Material(child: content),
        actions: <Widget>[
          if (button02 != null)
            CupertinoDialogAction(
              key: const Key('button02'),
              textStyle: textStyle,
              onPressed: () {
                if (press02 != null) {
                  press02();
                }
                if (button02.onPressed != null) {
                  button02.onPressed!();
                }
                Navigator.pop(context, button02.result ?? false);
              },
              child: Text(button02.text ?? 'Cancel'),
            ),
          CupertinoDialogAction(
            key: const Key('button01'),
            textStyle: textStyle,
            onPressed: () {
              if (press01 != null) {
                press01();
              }
              if (button01!.onPressed != null) {
                button01.onPressed!();
              }
              Navigator.pop(context, button01.result ?? true);
            },
            child: Text(button01!.text ?? 'OK'),
          ),
        ],
      ),
    );
  }
  return result ?? false;
}

/// Supply a TextButton from the Option object
Widget textButtonOption<T>({
//  required BuildContext context,
  required T result,
  Option? option,
  String? text,
  VoidCallback? onPressed,
}) =>
    TextButton(
      key: option?.key,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
        if (option?.onPressed != null) {
          option!.onPressed!();
        }
        var optionResult = option?.result;
        // Must be the specified Type
        if (optionResult != null && optionResult is! T) {
          optionResult = null;
        }
        Navigator.pop<T>(App.context!, optionResult ?? result);
      },
      onLongPress: option?.onLongPress,
      onHover: option?.onHover,
      onFocusChange: option?.onFocusChange,
      style: option?.style,
      focusNode: option?.focusNode,
      autofocus: option?.autofocus ?? false,
      clipBehavior: option?.clipBehavior,
      statesController: option?.statesController,
      isSemanticButton: option?.isSemanticButton ?? true,
      iconAlignment: option?.iconAlignment ?? IconAlignment.start,
      child: option?.child ?? Text(option?.text ?? text ?? ''),
    );

/// Return a value T
Future<T?> showDialogBox<T>(
  BuildContext context, {
  String? title,
  Widget? content,
  List<Widget>? actions,
  bool? barrierDismissible,
  Color? barrierColor,
  String? barrierLabel,
  bool? useSafeArea,
  bool? useRootNavigator,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  Widget? icon,
  EdgeInsetsGeometry? iconPadding,
  Color? iconColor,
  EdgeInsetsGeometry? titlePadding,
  TextStyle? titleTextStyle,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? contentTextStyle,
  EdgeInsetsGeometry? actionsPadding,
  MainAxisAlignment? actionsAlignment,
  OverflowBarAlignment? actionsOverflowAlignment,
  VerticalDirection? actionsOverflowDirection,
  double? actionsOverflowButtonSpacing,
  EdgeInsetsGeometry? buttonPadding,
  Color? backgroundColor,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  String? semanticLabel,
  EdgeInsets? insetPadding,
  Clip? clipBehavior,
  ShapeBorder? shape,
  AlignmentGeometry? alignment,
  bool? scrollable,
}) {
  //
  title ??= '';
  content ??= const Text('');
  actions ??= [
    TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: const Text('OK'),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ];
  return showDialog<T>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title!),
      content: content,
      actions: actions,
      icon: icon,
      iconPadding: iconPadding,
      iconColor: iconColor,
      titlePadding: titlePadding,
      titleTextStyle: titleTextStyle,
      contentPadding: contentPadding,
      contentTextStyle: contentTextStyle,
      actionsPadding: actionsPadding,
      actionsAlignment: actionsAlignment,
      actionsOverflowAlignment: actionsOverflowAlignment,
      actionsOverflowDirection: actionsOverflowDirection,
      actionsOverflowButtonSpacing: actionsOverflowButtonSpacing,
      buttonPadding: buttonPadding,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      insetPadding: insetPadding ??
          const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      clipBehavior: clipBehavior ?? Clip.none,
      shape: shape,
      alignment: alignment,
      scrollable: scrollable ?? false,
    ),
    barrierDismissible: barrierDismissible ?? true,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea ?? true,
    useRootNavigator: useRootNavigator ?? true,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    traversalEdgeBehavior: traversalEdgeBehavior,
  );
}

/// This dialog doesn't stop. The app continues with it displayed.
void dialogBox({
  String? title,
  Option? button01,
  Option? button02,
  VoidCallback? press01,
  VoidCallback? press02,
  bool? switchButtons,
  bool? barrierDismissible,
  Color? barrierColor,
  String? barrierLabel,
  bool? useSafeArea,
  bool? useRootNavigator,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  showDialog<bool>(
    context: App.context!,
    builder: (BuildContext context) {
      return _DialogWindow(
        title: title,
        button01: button01,
        button02: button02,
        press01: press01,
        press02: press02,
        switchButtons: switchButtons,
      ).show();
    },
    barrierDismissible: barrierDismissible ?? false,
    barrierColor: barrierColor ?? Colors.black54,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea ?? true,
    useRootNavigator: useRootNavigator ?? true,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}

class _DialogWindow with DialogOptions {
  _DialogWindow({
    this.title,
    Option? button01,
    Option? button02,
    VoidCallback? press01,
    VoidCallback? press02,
    bool? switchButtons,
  }) {
    this.button01 = button01;
    this.button02 = button02;
    this.press01 = press01;
    this.press02 = press02;
    this.switchButtons = switchButtons;
  }
  final String? title;

  SimpleDialog show() {
    return SimpleDialog(
      title: Text(title ?? ' '),
      children: [Row(children: _listOptions())],
    );
  }
}

/// A mixin to work with the class [DialogBox]
/// or can be assigned to any class involving
/// two buttons and their callback routines.
mixin DialogOptions {
  /// First button option
  Option? button01;

  /// Second button option
  Option? button02;

  /// First button's callback function
  VoidCallback? press01;

  /// Second button's callback function
  VoidCallback? press02;

  /// Boolean flag to switch display order of buttons.
  bool? switchButtons;

  List<Widget> _listOptions() {
    final opList = <Widget>[];
    Option option01, option02;

    if (button01 != null || press01 != null) {
      final child = button01?.child;
      option01 = Option(
        key: const Key('button01'),
        text: button01?.text ?? (child == null ? 'Cancel' : null),
        onPressed: press01 ?? button01!.onPressed,
        result: true,
        onLongPress: button01?.onLongPress,
        onHover: button01?.onHover,
        onFocusChange: button01?.onFocusChange,
        style: button01?.style,
        focusNode: button01?.focusNode,
        autofocus: button01?.autofocus,
        clipBehavior: button01?.clipBehavior,
        statesController: button01?.statesController,
        isSemanticButton: button01?.isSemanticButton,
        iconAlignment: button01?.iconAlignment,
        child: child,
      );
    } else {
      option01 = CancelOption(key: const Key('button01'));
    }
    if (button02 != null || press02 != null) {
      final child = button02?.child;
      option02 = Option(
        key: const Key('button02'),
        text: button02?.text ?? (child == null ? 'OK' : null),
        onPressed: press02 ?? button02!.onPressed,
        result: false,
        onLongPress: button02?.onLongPress,
        onHover: button02?.onHover,
        onFocusChange: button02?.onFocusChange,
        style: button02?.style,
        focusNode: button02?.focusNode,
        autofocus: button02?.autofocus,
        clipBehavior: button02?.clipBehavior,
        statesController: button02?.statesController,
        isSemanticButton: button02?.isSemanticButton,
        iconAlignment: button02?.iconAlignment,
        child: child,
      );
    } else {
      if (option01 is! OKOption) {
        option02 = OKOption(key: const Key('button02'));
      } else {
        option02 = CancelOption(key: const Key('button02'));
      }
    }
    if (switchButtons != null && switchButtons!) {
      // opList.add(simpleOption(option02));
      // opList.add(simpleOption(option01));
      opList.add(textButtonOption<bool>(
        option: option02,
        result: option02.result,
      ));
      opList.add(textButtonOption<bool>(
        option: option01,
        result: option01.result,
      ));
    } else {
      // opList.add(simpleOption(option01));
      // opList.add(simpleOption(option02));
      opList.add(textButtonOption<bool>(
        option: option01,
        result: option01.result,
      ));
      opList.add(textButtonOption<bool>(
        option: option02,
        result: option02.result,
      ));
    }
    return opList;
  }
}

/// Simply onPressed() and Text.
Widget simpleOption(Option option) => SimpleDialogOption(
      key: option.key,
      onPressed: () {
        if (option.onPressed != null) {
          option.onPressed!();
        }
        Navigator.pop(App.context!, option.result);
      },
      child: Text(option.text!),
    );

/// The Button Option Class
class Option extends ButtonStyleButton {
  /// Supply the button's text, callback and dynamic result value.
  const Option({
    super.key,
    this.text,
    this.result,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    WidgetStatesController? statesController,
    bool? isSemanticButton,
    Widget? child,
    IconAlignment? iconAlignment,
  })  : assert(result != null, 'Must provide a option result!'),
        super(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior,
          statesController: statesController,
          isSemanticButton: isSemanticButton,
          child: child,
          iconAlignment: iconAlignment ?? IconAlignment.start,
        );

  // /// Key used for testing
  // final Key? key;

  /// The optional Button Text label.
  final String? text;

  // /// The optional callback function
  // final VoidCallback? onPressed;

  /// The result of any type that's assigned when the button is pressed.
  final dynamic result;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) => TextButton.styleFrom();

  /// Returns the [TextButtonThemeData.style] of the closest
  /// [TextButtonTheme] ancestor.
  @override
  ButtonStyle? themeStyleOf(BuildContext context) =>
      TextButtonTheme.of(context).style;
}

/// The 'OK' Button Option
class OKOption extends Option {
  /// Supply the optionally Callback when pressed.
  /// Assigns a boolean True to the result property.
  OKOption({
    Key? key,
    VoidCallback? onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.child,
    super.iconAlignment,
  }) : super(
          key: key,
          text: 'OK',
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
          result: true,
        );
}

/// The 'Cancel' Button Option
class CancelOption extends Option {
  /// Supply the optionally Callback when pressed.
  /// Assigns a boolean False to the result property.
  CancelOption({
    Key? key,
    VoidCallback? onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.child,
    super.iconAlignment,
  }) : super(
          key: key,
          text: 'Cancel',
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
          result: false,
        );
}

/// Message Box Class
class MsgBox {
  /// Supply a Message box
  const MsgBox({
    required this.context,
    this.title,
    this.msg,
    this.body,
    this.actions,
    // showDialog
    this.barrierDismissible,
    this.barrierColor,
    this.barrierLabel,
    this.useSafeArea,
    this.useRootNavigator,
    this.routeSettings,
    this.anchorPoint,
    this.traversalEdgeBehavior,
    // AlertDialog
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticLabel,
    this.insetPadding,
    this.clipBehavior,
    this.shape,
    this.alignment,
    this.scrollable,
  });

  /// Requires a BuildContext
  final BuildContext context;

  /// Optional String to display as a title on the Message box.
  final String? title;

  /// Optional String as the primary message of the Message box.
  final String? msg;

  /// Optional List of Widgets that take precedence over [msg]
  /// and will be displayed instead.
  final List<Widget>? body;

  /// Optional set of actions that are displayed at the bottom of the
  /// Message box.
  final List<Widget>? actions;

  // showDialog
  ///
  final bool? barrierDismissible;

  ///
  final Color? barrierColor;

  ///
  final String? barrierLabel;

  ///
  final bool? useSafeArea;

  ///
  final bool? useRootNavigator;

  ///
  final RouteSettings? routeSettings;

  ///
  final Offset? anchorPoint;

  ///
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  // AlertDialog
  /// An optional icon to display at the top of the dialog.
  final Widget? icon;

  /// Color for the [Icon] in the [icon] of this [AlertDialog].
  final Color? iconColor;

  /// Padding around the [icon].
  final EdgeInsetsGeometry? iconPadding;

  /// Padding around the title.
  final EdgeInsetsGeometry? titlePadding;

  /// Style for the text in the [title] of this [AlertDialog].
  final TextStyle? titleTextStyle;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog in a lighter font.
  final Widget? content;

  /// Padding around the content.
  final EdgeInsetsGeometry? contentPadding;

  /// Style for the text in the [content] of this [AlertDialog].
  final TextStyle? contentTextStyle;

  /// Padding around the set of [actions] at the bottom of the dialog.
  final EdgeInsetsGeometry? actionsPadding;

  /// Defines the horizontal layout of the [actions] according to the same
  /// rules as for [Row.mainAxisAlignment].
  final MainAxisAlignment? actionsAlignment;

  /// The horizontal alignment of [actions] within the vertical
  /// "overflow" layout.
  final OverflowBarAlignment? actionsOverflowAlignment;

  /// The vertical direction of [actions] if the children overflow
  /// horizontally.
  final VerticalDirection? actionsOverflowDirection;

  /// The spacing between [actions] when the [OverflowBar] switches to a column
  /// layout because the actions don't fit horizontally.
  final double? actionsOverflowButtonSpacing;

  /// The padding that surrounds each button in [actions].
  final EdgeInsetsGeometry? buttonPadding;

  /// {@macro flutter.material.dialog.backgroundColor}
  final Color? backgroundColor;

  /// {@macro flutter.material.dialog.elevation}
  final double? elevation;

  /// {@macro flutter.material.dialog.shadowColor}
  final Color? shadowColor;

  /// {@macro flutter.material.dialog.surfaceTintColor}
  final Color? surfaceTintColor;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  final String? semanticLabel;

  /// {@macro flutter.material.dialog.insetPadding}
  final EdgeInsets? insetPadding;

  /// {@macro flutter.material.dialog.clipBehavior}
  final Clip? clipBehavior;

  /// {@macro flutter.material.dialog.shape}
  final ShapeBorder? shape;

  /// {@macro flutter.material.dialog.alignment}
  final AlignmentGeometry? alignment;

  /// Determines whether the [title] and [content] widgets are wrapped in a
  /// scrollable.
  final bool? scrollable;

  /// Call to display this Message box.
  Future<void> show({
    BuildContext? context,
    String? title,
    String? msg,
    List<Widget>? body,
    List<Widget>? actions,
  }) {
    context = context ?? this.context;
    title = title ?? this.title;
    msg = msg ?? this.msg;
    body = body ?? this.body;
    if (body == null) {
      if (msg == null || msg.isEmpty) {
        body = [const Text('Shall we continue?')];
      } else {
        body = [Text(msg)];
      }
    }
    actions = actions ?? this.actions;
    actions ??= <Widget>[
      TextButton(
        key: const Key('button01'),
        onPressed: () {
          Navigator.pop(context!);
        },
        child: const Text('OK'),
      ),
    ];

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea ?? true,
      useRootNavigator: useRootNavigator ?? true,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
      builder: (BuildContext context) => AlertDialog(
        icon: icon,
        iconPadding: iconPadding,
        iconColor: iconColor,
        title: Text(title ?? ''),
        titlePadding: titlePadding,
        titleTextStyle: titleTextStyle,
        content: SingleChildScrollView(
          child: ListBody(
            children: body!,
          ),
        ),
        contentPadding: contentPadding,
        contentTextStyle: contentTextStyle,
        actions: actions,
        actionsPadding: actionsPadding,
        actionsAlignment: actionsAlignment,
        actionsOverflowAlignment: actionsOverflowAlignment,
        actionsOverflowDirection: actionsOverflowDirection,
        actionsOverflowButtonSpacing: actionsOverflowButtonSpacing,
        buttonPadding: buttonPadding,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        semanticLabel: semanticLabel,
        insetPadding: insetPadding ??
            const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        clipBehavior: clipBehavior ?? Clip.none,
        shape: shape,
        alignment: alignment,
        scrollable: scrollable ?? false,
      ),
    );
  }
}

/// Display an extensive widget to a dialogue window.
///
class DialogBox with DialogOptions {
  /// Supply the Dialog window's buttons and Callback routines.
  DialogBox({
    this.title,
    Option? button01,
    Option? button02,
    VoidCallback? press01,
    VoidCallback? press02,
    bool? switchButtons,
    this.body,
    this.actions,
    this.barrierDismissible = false,
  }) {
    this.button01 = button01;
    this.button02 = button02;
    this.press01 = press01;
    this.press02 = press02;
    this.switchButtons = switchButtons;
  }

  /// The Dialog window's title.
  final String? title;

  /// The Dialog window's title.
  final List<Widget>? body;

  /// The Dialog window's title.
  final List<Widget>? actions;

  /// Whether or not the Dialog window disables the rest of the interface or not.
  final bool? barrierDismissible;

  /// Display the Dialog window.
  Future<void> show({
    String? title,
    Option? button01,
    Option? button02,
    VoidCallback? press01,
    VoidCallback? press02,
    bool? switchButtons,
    String? msg,
    List<Widget>? body,
    List<Widget>? actions,
    bool? barrierDismissible,
  }) {
    title = title ?? this.title;
    title ??= '';
    this.button01 ??= button01;
    this.button02 ??= button02;
    this.press01 ??= press01;
    this.press02 ??= press02;
    this.switchButtons ??= switchButtons;
    body = body ?? this.body;
    body ??= [const SizedBox()];
    actions ??= this.actions;
    actions ??= _listOptions();
    barrierDismissible ??= this.barrierDismissible ?? false;
    return showDialog<void>(
      context: App.context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title!),
        content: SingleChildScrollView(
          child: ListBody(
            children: body!,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
