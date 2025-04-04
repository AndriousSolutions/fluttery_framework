// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.

import 'package:flutter/material.dart';

/// Exports that will be likely required by the subclass.
export 'package:flutter/material.dart'
    show
        BuildContext,
        BorderRadius,
        BoxConstraints,
        Color,
        Colors,
        EdgeInsets,
        EdgeInsetsGeometry,
        Key,
        Offset,
        PopupMenuButton,
        PopupMenuCanceled,
        PopupMenuDivider,
        PopupMenuEntry,
        PopupMenuItem,
        PopupMenuItemBuilder,
        PopupMenuItemSelected,
        PopupMenuPosition,
        RoundedRectangleBorder,
        Scaffold,
        ShapeBorder,
        SnackBar,
        Text,
        Widget;

/// A popupmenu that takes in String menu options.
/// Imposes rounded corners and the 'under' position
///
/// dartdoc:
/// {@category Get started}
class AppPopupMenu extends PopupMenuWidget<String> {
  ///
  AppPopupMenu({
    super.key,
    super.controller,
    super.items,
    super.menuEntries,
    super.itemBuilder,
    super.initialValue,
    super.inOpened,
    super.inSelected,
    super.inCanceled,
    super.tooltip,
    super.elevation,
    super.padding,
    super.child,
    super.splashRadius,
    super.icon,
    super.iconSize,
    super.offset,
    super.enabled,
    ShapeBorder? shape,
    super.color,
    super.enableFeedback,
    super.constraints,
    PopupMenuPosition? position,
    super.clipBehavior,
    super.inTooltip,
    super.inElevation,
    super.inPadding,
    super.inSplashRadius,
    super.inChild,
    super.inIcon,
    super.inIconSize,
    super.inOffset,
    super.inEnabled,
    super.inShape,
    super.inColor,
    super.inEnableFeedback,
    super.inConstraints,
    super.inPosition,
    super.inClipBehavior,
  }) : super(
          shape: shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          position: position ?? PopupMenuPosition.under,
        );
}

/// Create a customized [PopupMenuButton].
///
/// dartdoc:
/// {@category Get started}
class PopupMenuWidget<T> extends StatefulWidget
    with PopupMenuFunctionsMixin<T> {
  /// A controller takes precedence over the supplied properties and functions
  PopupMenuWidget({
    super.key,
    PopupMenuControllerMixin<T>? controller,
    this.items,
    this.menuEntries,
    this.itemBuilder,
    this.initialValue,
    this.inOpened,
    this.inSelected,
    this.inCanceled,
    this.tooltip,
    this.elevation,
    this.padding,
    this.child,
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset,
    this.enabled,
    this.shape,
    this.color,
    this.enableFeedback,
    this.constraints,
    this.position,
    this.clipBehavior,
    this.inTooltip,
    this.inElevation,
    this.inPadding,
    this.inSplashRadius,
    this.inChild,
    this.inIcon,
    this.inIconSize,
    this.inOffset,
    this.inEnabled,
    this.inShape,
    this.inColor,
    this.inEnableFeedback,
    this.inConstraints,
    this.inPosition,
    this.inClipBehavior,
  }) : _con = controller ?? _PopupMenuController<T>();
  // Supplies the controller
  final PopupMenuControllerMixin<T> _con;

  /// Optional list of menu items to appear in the popup menu.
  final List<T>? items;

  /// Optional list of PopupMenuEntries to appear in the popup menu.
  final List<PopupMenuEntry<T>>? menuEntries;

  /// The item builder if no List is available.
  final PopupMenuItemBuilder<T>? itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the popup menu is shown.
  final VoidCallback? inOpened;

  /// Called when a menu item is selected.
  final PopupMenuItemSelected<T>? inSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  final PopupMenuCanceled? inCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  final double? elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry? padding;

  /// The splash radius.If null, default splash radius of [InkWell] or [IconButton] is used.
  final double? splashRadius;

  /// If provided, [child] is the widget used for this button
  final Widget? child;

  /// If provided, the [icon] is used for this button
  final Widget? icon;

  /// The offset applied to the Popup Menu Button.
  /// When not set, the Popup Menu Button will be positioned directly next to
  /// the button that was used to create it.
  final Offset? offset;

  /// Whether this popup menu button is interactive.
  final bool? enabled;

  /// If provided, the shape used for the menu.
  final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  final Color? color;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool? enableFeedback;

  /// If provided, the size of the [Icon].
  final double? iconSize;

  /// Optional size constraints for the menu.
  final BoxConstraints? constraints;

  /// Whether the popup menu is positioned over or under the popup menu button.
  /// Either PopupMenuPosition.over or PopupMenuPosition.under
  final PopupMenuPosition? position;

  /// The clip shape of the menu.
  final Clip? clipBehavior;

  /// BuildContext property
  BuildContext? get context => _con._popupWidgetState?.mounted ?? false
      ? _con._popupWidgetState?.context
      : null;

  /// Refresh the popup menu
  @override
  void setMenu() => _con.setMenu();

  /// Show the popup menu
  @override
  void showButtonMenu() => _con.showButtonMenu();

  /// List of menu items of type T to appear in the popup menu.
  @override
  List<T>? onItems() => [];

  /// List of menuentry items to appear in the popup menu.
  @override
  List<PopupMenuEntry<T>>? onMenuEntries() => [];

  /// Explicitly pass a BuildContext: List\<PopupMenuEntry\<T>> Function(BuildContext context);
  @override
  PopupMenuItemBuilder<T>? onItemBuilder() => null;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  @override
  T? onInitialValue() => null;

  /// Called when the user selects a value from the popup menu created by this button.
  @override
  void onSelected(T value) {}

  /// Called when the user dismisses the popup menu without selecting an item.
  @override
  void onCanceled() {}

  /// Text that describes the action that will occur when the button is pressed.
  @override
  String? onTooltip() => inTooltip == null ? null : inTooltip!();

  /// 'in Parameters' function
  final String? Function()? inTooltip;

  /// This controls the size of the shadow below the menu.
  @override
  double? onElevation() => inElevation == null ? null : inElevation!();

  /// 'in Parameters' function
  final double? Function()? inElevation;

  /// In some cases, it's useful to be able to set the padding to zero.
  @override
  EdgeInsetsGeometry? onPadding() => inPadding == null ? null : inPadding!();

  /// 'in Parameters' function
  final EdgeInsetsGeometry? Function()? inPadding;

  /// The splash radius. If null, default splash radius of [InkWell] or [IconButton] is used.
  @override
  double? onSplashRadius() => inSplashRadius == null ? null : inSplashRadius!();

  /// 'in Parameters' function
  final double? Function()? inSplashRadius;

  /// The widget used for this button
  @override
  Widget? onChild() => inChild == null ? null : inChild!();

  /// 'in Parameters' function
  final Widget? Function()? inChild;

  /// The icon is used for this button
  @override
  Widget? onIcon() => inIcon == null ? null : inIcon!();

  /// 'in Parameters' function
  final Widget? Function()? inIcon;

  /// the size of the [Icon].
  @override
  double? onIconSize() => inIconSize == null ? null : inIconSize!();

  /// 'in Parameters' function
  final double? Function()? inIconSize;

  /// The offset is applied relative to the initial position
  @override
  Offset? onOffset() => inOffset == null ? null : inOffset!();

  /// 'in Parameters' function
  final Offset? Function()? inOffset;

  /// Whether this popup menu button is interactive
  @override
  bool? onEnabled() => inEnabled == null ? true : inEnabled!();

  /// 'in Parameters' function
  final bool? Function()? inEnabled;

  /// The shape used for the menu
  @override
  ShapeBorder? onShape() => inShape == null ? null : inShape!();

  /// 'in Parameters' function
  final ShapeBorder? Function()? inShape;

  /// The background color used for the menu
  @override
  Color? onColor() => inColor == null ? null : inColor!();

  /// 'in Parameters' function
  final Color? Function()? inColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback
  @override
  bool? onEnableFeedback() =>
      inEnableFeedback == null ? null : inEnableFeedback!();

  /// 'in Parameters' function
  final bool? Function()? inEnableFeedback;

  /// Make the menu wider than the default maximum width
  @override
  BoxConstraints? onConstraints() =>
      inConstraints == null ? null : inConstraints!();

  /// 'in Parameters' function
  final BoxConstraints? Function()? inConstraints;

  /// Whether the menu is positioned over or under the popup menu button
  /// PopupMenuPosition.over or PopupMenuPosition.under
  @override
  PopupMenuPosition? onPosition() => inPosition == null ? null : inPosition!();

  /// 'in Parameters' function
  final PopupMenuPosition? Function()? inPosition;

  @override
  Clip? onClipBehavior() => inClipBehavior == null ? null : inClipBehavior!();

  /// 'in Parameters' function
  final Clip? Function()? inClipBehavior;

  ///
  @override
  State createState() => _PopupMenuWidgetState<T>();
}

/// Create a customized [PopupMenuButton].
class _PopupMenuWidgetState<T> extends State<PopupMenuWidget<T>> {
  ///
  @override
  void initState() {
    super.initState();
    // Important to assign this State object
    widget._con._popupWidgetState = this;
    //
    hasMaterial = context.widget is! Material &&
        context.findAncestorWidgetOfExactType<Material>() == null;
    //
    popupKey = _PopupMenuButtonKey<PopupMenuButtonState<T>>(this);
  }

  // Use the Material widget if not running under the MaterialApp widget.
  late bool hasMaterial;

  late GlobalKey<PopupMenuButtonState<T>> popupKey;

  /// Popup menu's State object
  PopupMenuButtonState<T>? get popupMenuState => popupKey.currentState;

  ///
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Important to clear memory
    oldWidget._con._popupWidgetState = null;
    widget._con._popupWidgetState = this;
  }

  @override
  Widget build(BuildContext context) {
    //
    final widget = this.widget;

    final con = widget._con;

    // Could be changed in the function, onItemBuilder
    var enabled =
        con.onEnabled() ?? widget.enabled ?? widget.onEnabled() ?? true;

    var icon = con.onIcon() ?? widget.icon ?? widget.onIcon();

    var child = con.onChild() ?? widget.child ?? widget.onChild();

    final iconSize = con.onIconSize() ?? widget.iconSize ?? widget.onIconSize();

    // One or the other, but not both.
    if (child != null && icon != null) {
      if (iconSize != null) {
        child = null;
      } else {
        icon = null;
      }
      // Default to child
    } else if (child == null) {
      // Supply the icon instead
      if (icon != null) {
        // May be changed in onItemBuilder() function
        child = icon;
        icon = null;
      } else {
        // Supply the three dots
        // May be changed in onItemBuilder() function
        child = Icon(Icons.adaptive.more);
        child = Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
            widthFactor: 1,
            heightFactor: 1,
            child: child,
          ),
        );
      }
    }

    List<PopupMenuEntry<T>> menuOptions;
    // A flag if an error occurs
    var itemError = false;

    try {
      // Determine first if there is any menu options
      menuOptions = onItemBuilder(context);
    } catch (e) {
      itemError = true;
      menuOptions = <PopupMenuEntry<T>>[];
    }

    // Don't display the menu popup if there's nothing to display
    // If errors, possibly will not error when the user opens the menu
    if (!enabled || (menuOptions.isEmpty && !itemError)) {
      enabled = false;
      child = const SizedBox();
    }

    Widget popupMenu = PopupMenuButton<T>(
      key: popupKey,
      itemBuilder: onItemBuilder,
      initialValue: con.onInitialValue() ??
          widget.initialValue ??
          widget.onInitialValue(),
      onOpened: () {
        // The controller's function is always called.
        con.onOpened();

        widget.onOpened();

        if (widget.inOpened != null) {
          widget.inOpened!();
        }
      },
      onSelected: (T value) {
        // The controller's function is always called.
        con.onSelected(value);

        widget.onSelected(value);

        if (widget.inSelected != null) {
          widget.inSelected!(value);
        }
      },
      onCanceled: () {
        // The controller's function is always called.
        con.onCanceled();

        widget.onCanceled();

        if (widget.inCanceled != null) {
          widget.inCanceled!();
        }
      },
      tooltip: con.onTooltip() ?? widget.tooltip ?? widget.onTooltip(),
      elevation: con.onElevation() ?? widget.elevation ?? widget.onElevation(),
      padding: con.onPadding() ??
          widget.padding ??
          widget.onPadding() ??
          const EdgeInsets.all(8),
      splashRadius: con.onSplashRadius() ??
          widget.splashRadius ??
          widget.onSplashRadius(),
      icon: icon,
      iconSize: iconSize,
      offset:
          con.onOffset() ?? widget.offset ?? widget.onOffset() ?? Offset.zero,
      enabled: enabled,
      shape: con.onShape() ?? widget.shape ?? widget.onShape(),
      color: con.onColor() ?? widget.color ?? widget.onColor(),
      enableFeedback: con.onEnableFeedback() ??
          widget.enableFeedback ??
          widget.onEnableFeedback(),
      constraints:
          con.onConstraints() ?? widget.constraints ?? widget.onConstraints(),
      position: con.onPosition() ??
          widget.position ??
          widget.onPosition() ??
          PopupMenuPosition.over,
      clipBehavior: con.onClipBehavior() ??
          widget.clipBehavior ??
          widget.onClipBehavior() ??
          Clip.none,
      child: child,
    );

    // If not running under the MaterialApp widget.
    if (hasMaterial) {
      popupMenu = Material(child: popupMenu);
    }
    return popupMenu;
  }

  ///
  List<PopupMenuEntry<T>> onItemBuilder(BuildContext context) {
    //
    List<PopupMenuEntry<T>>? menuOptions;

    final widget = this.widget;

    final con = widget._con;

    // items or onItems()
    final List<T>? options = con.onItems() ?? widget.items ?? widget.onItems();
    if (options != null && options.isNotEmpty) {
      menuOptions = onItems(options).call(context);
    }

    // menuEntries
    if (menuOptions == null) {
      var entries = con.onMenuEntries();
      if (entries != null && entries.isNotEmpty) {
        menuOptions = entries;
      }
      if (menuOptions == null) {
        entries = widget.menuEntries;
        if (entries != null && entries.isNotEmpty) {
          menuOptions = entries;
        }
      }
      if (menuOptions == null) {
        entries = widget.onMenuEntries();
        if (entries != null && entries.isNotEmpty) {
          menuOptions = entries;
        }
      }
    }

    // itemBuilder()
    if (menuOptions == null) {
      final func = con.onItemBuilder();
      if (func != null) {
        final entries = func(context);
        if (entries.isNotEmpty) {
          menuOptions = entries;
        }
      }
      menuOptions ??=
          widget.itemBuilder == null ? null : widget.itemBuilder!(context);
    }

    return menuOptions ??= <PopupMenuEntry<T>>[];
  }

  /// Produce the menu items for a List of items of type T.
  PopupMenuItemBuilder<T> onItems(List<T> menuItems) {
    //
    final popupMenuItems = menuItems
        .map((T? item) =>
            PopupMenuItem<T>(value: item, child: Text(item.toString())))
        .toList();

    return (BuildContext context) => <PopupMenuEntry<T>>[...popupMenuItems];
  }
}

// This is the GlobalKey that identifies the PopupMenuButton's State object
class _PopupMenuButtonKey<T extends State<StatefulWidget>>
    extends GlobalObjectKey<T> {
  const _PopupMenuButtonKey(super.value);
}

// Used by the widget if a Controller is not explicitly provided
class _PopupMenuController<T> with PopupMenuControllerMixin<T> {}

/// Uses the String type as menu options
class AppPopupMenuController with PopupMenuControllerMixin<String> {}

/// A class version of the mixin below
mixin PopupMenuControllerMixin<T> implements PopupMenuFunctionsMixin<T> {
  // The link to the App menu's State object
  _PopupMenuWidgetState<T>? _popupWidgetState;

  @override
  void setMenu() {
    if (_popupWidgetState?.mounted ?? false) {
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      _popupWidgetState?.setState(() {});
    }
  }

  @override
  void showButtonMenu() => _popupWidgetState?.popupMenuState?.showButtonMenu();

  @override
  List<T>? onItems() => null;

  @override
  List<PopupMenuEntry<T>>? onMenuEntries() => null;

  @override
  PopupMenuItemBuilder<T>? onItemBuilder() => null;

  @override
  void onOpened() {}

  @override
  void onSelected(T value) {}

  @override
  void onCanceled() {}

  @override
  T? onInitialValue() => null;

  @override
  String? onTooltip() => null;

  @override
  double? onElevation() => null;

  @override
  EdgeInsetsGeometry? onPadding() => null;

  @override
  double? onSplashRadius() => null;

  @override
  Widget? onChild() => null;

  @override
  Widget? onIcon() => null;

  @override
  double? onIconSize() => null;

  @override
  Offset? onOffset() => null;

  @override
  bool? onEnabled() => null;

  @override
  ShapeBorder? onShape() => null;

  @override
  Color? onColor() => null;

  @override
  bool? onEnableFeedback() => null;

  @override
  BoxConstraints? onConstraints() => null;

  @override
  PopupMenuPosition? onPosition() => null;

  @override
  Clip? onClipBehavior() => null;
}

/// Supply the useful popup menu functions
mixin PopupMenuFunctionsMixin<T> {
  /// Like setState() but for the popup menu
  void setMenu() {}

  /// Show the popup menu
  void showButtonMenu() {}

  /// List of menu items to appear in the popup menu.
  List<T>? onItems() => null;

  /// List of menu entry items of type T to appear in the popup menu.
  List<PopupMenuEntry<T>>? onMenuEntries() => null;

  /// Explicitly pass a BuildContext: List\<PopupMenuEntry\<T>> Function(BuildContext context);
  PopupMenuItemBuilder<T>? onItemBuilder() => null;

  /// Called when the popup menu is shown.
  void onOpened() {}

  /// Called when the user selects a value from the popup menu created by this button.
  void onSelected(T value) {}

  /// Called when the user dismisses the popup menu without selecting an item.
  void onCanceled() {}

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  T? onInitialValue() => null;

  /// Text that describes the action that will occur when the button is pressed.
  String? onTooltip() => null;

  /// This controls the size of the shadow below the menu.
  double? onElevation() => null;

  /// In some cases, it's useful to be able to set the padding to zero.
  EdgeInsetsGeometry? onPadding() => null;

  /// The splash radius. If null, default splash radius of [InkWell] or [IconButton] is used.
  double? onSplashRadius() => null;

  /// The widget used for this button
  Widget? onChild() => null;

  /// The icon is used for this button
  Widget? onIcon() => null;

  /// the size of the [Icon].
  double? onIconSize() => null;

  /// The offset is applied relative to the initial position
  Offset? onOffset() => null;

  /// Whether this popup menu button is interactive
  bool? onEnabled() => null;

  /// The shape used for the menu
  ShapeBorder? onShape() => null;

  /// The background color used for the menu
  Color? onColor() => null;

  /// Whether detected gestures should provide acoustic and/or haptic feedback
  bool? onEnableFeedback() => null;

  /// Make the menu wider than the default maximum width
  BoxConstraints? onConstraints() => null;

  /// Whether the menu is positioned over or under the popup menu button
  PopupMenuPosition? onPosition() => null;

  /// The clip shape of the menu.
  Clip? onClipBehavior() => null;
}
