/// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// (the "License") that can be found in the LICENSE file.

import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:fluttery_framework/view.dart';

import 'package:url_launcher/url_launcher.dart';

// I'd prefer you use a subclass
//class WebPage extends WebWrapper {
//   WebPage({
//     super.key,
//     this.title,
//     super.child,
//     PreferredSizeWidget? appBar,
//     super.body,
//     super.screenOverlay,
//     super.addFooter,
//     super.floatingActionButton,
//     super.floatingActionButtonLocation,
//     super.floatingActionButtonAnimator,
//     super.persistentFooterButtons,
//     super.persistentFooterAlignment,
//     super.drawer,
//     super.onDrawerChanged,
//     super.endDrawer,
//     super.onEndDrawerChanged,
//     super.bottomNavigationBar,
//     super.bottomSheet,
//     super.backgroundColor,
//     super.resizeToAvoidBottomInset,
//     super.primary,
//     super.drawerDragStartBehavior,
//     super.extendBody,
//     super.extendBodyBehindAppBar,
//     super.drawerScrimColor,
//     super.drawerEdgeDragWidth,
//     super.drawerEnableOpenDragGesture,
//     super.endDrawerEnableOpenDragGesture,
//     super.restorationId,
//     super.scrollDirection,
//     super.reverse,
//     super.padding,
//     super.scrollPrimary,
//     super.physics,
//     super.scrollController,
//     super.dragStartBehavior,
//     super.clipBehavior,
//     super.keyboardDismissBehavior,
//   }) : super(
//           appBar: title != null ? AppBar(title: Text(title)) : appBar,
//         );
//
//   final String? title;
//
//   @override
//   Widget? footer(BuildContext context) {
//
//   }
// }

/// class WebPageWrapper
class WebPageWrapper extends StatefulWidget {
  ///
  WebPageWrapper({
    super.key,
    this.child,
    this.appBar,
    this.body,
    this.screenOverlay,
    this.addFooter,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary,
    this.drawerDragStartBehavior,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture,
    this.endDrawerEnableOpenDragGesture,
    this.restorationId,
    this.scrollDirection,
    this.reverse,
    this.padding,
    this.scrollPrimary,
    this.physics,
    this.scrollController,
    this.dragStartBehavior,
    this.clipBehavior,
    this.keyboardDismissBehavior,
  });

  @override
  State<StatefulWidget> createState() => _WebPageWrapperState();

  /// Provide its State object
  _WebPageWrapperState? get state => _state.isNotEmpty ? _state.single : null;
  // ignore: avoid_field_initializers_in_const_classes
  final _state = <_WebPageWrapperState>[];

  /// Rebuild State Object
  //ignore: invalid_use_of_protected_member
  void setState(VoidCallback fn) => state?.setState(fn);

  /// Provide its Context
  BuildContext get context => state!.context;

  /// Current scroll position.
  double? get offset => state!.offset;

  /// Its opacity
  double get opacity => state!.opacity;

  /// Scrolling up
  bool get scrollUp {
    if (state == null) {
      return false;
    }
    return state!.offset < state!.lastOffset;
  }

  /// Scrolling down
  bool get scrollDown => !scrollUp;

  /// Screen size
  Size get screenSize => state!.context.screenSize;

  /// Running in small screen
  bool get inSmallScreen => state!.context.inSmallScreen;

  /// Called in State object
  void initState() {}

  /// Called in State object
  void dispose() {}

  /// The title bar of the webpage
  PreferredSizeWidget? onAppBar() => null;

  /// Optional child builder routine. Only call once.
  Widget? builder(BuildContext context) => null;

  /// The optional child widget
  Widget? onChild(BuildContext context) => null;

  /// The optional body of the webpage
  Widget? onBody() => null;

  ///
  Widget? footer(BuildContext context) => null;

  ///
  Widget? onDrawer() => null;

  ///
  //ignore: avoid_positional_boolean_parameters
  Widget? drawerChanged(bool isOpened) => null;

  ///
  Widget? onEndDrawer() => null;

  ///
  //ignore: avoid_positional_boolean_parameters
  Widget? endDrawerChanged(bool isOpened) => null;

  ///
  Widget? onBottomNavigationBar() => null;

  ///
  Widget? onBottomSheet() => null;

  ///
  Color? onBackgroundColor() => null;

  /// The optional widget passed into this wrapper
  final Widget? child;

  /// An bar to display at the top of the webpage.
  final PreferredSizeWidget? appBar;

  /// The body of the web page.
  final Widget? body;

  /// An Screen Overlay Widget
  final ScreenOverlayWidget? screenOverlay;

  /// Is a footer displayed
  final bool? addFooter;

  /// A button displayed floating above [body], in the bottom right corner.
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the [floatingActionButton] to a new [floatingActionButtonLocation].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A set of buttons that are displayed at the bottom of the webpage.
  final List<Widget>? persistentFooterButtons;

  /// The alignment of the [persistentFooterButtons] inside the [OverflowBar].
  final AlignmentDirectional? persistentFooterAlignment;

  /// A panel displayed to the side of the [body], often hidden
  final Widget? drawer;

  /// Optional callback that is called when the [Scaffold.drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the side of the [body]. Swipes in from right-to-left
  final Widget? endDrawer;

  /// Optional callback that is called when the [Scaffold.endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  final Color? drawerScrimColor;

  /// Whether this scaffold is being displayed at the top of the screen.
  final bool? primary;

  ///
  final DragStartBehavior? drawerDragStartBehavior;

  ///
  final Widget? bottomNavigationBar;

  /// The persistent bottom sheet to display.
  final Widget? bottomSheet;

  /// The color of the [Material] widget that underlies the entire Scaffold.
  final Color? backgroundColor;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard
  final bool? resizeToAvoidBottomInset;

  /// if true then the [body] extends to the bottom of the Scaffold,
  final bool? extendBody;

  /// If true, and an [appBar] is specified, then the height of the [body] is
  /// extended to include the height of the app bar and the top of the body
  /// is aligned with the top of the app bar.
  final bool? extendBodyBehindAppBar;

  /// The width of the area within which a horizontal swipe will open the
  /// drawer.
  final double? drawerEdgeDragWidth;

  /// Determines if the [Scaffold.drawer] can be opened with a drag
  /// gesture on mobile.
  final bool? drawerEnableOpenDragGesture;

  /// Determines if the [Scaffold.endDrawer] can be opened with a
  /// gesture on mobile.
  final bool? endDrawerEnableOpenDragGesture;

  /// Restoration ID to save and restore the state of the [Scaffold].
  final String? restorationId;

  /// The axis along which the scroll view scrolls.
  final Axis? scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  final bool? reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// Whether this scaffold is being displayed at the top of the screen.
  final bool? scrollPrimary;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// The Controller for any scrolling
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior? dragStartBehavior;

  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// How should a on-screen keyboard dismiss .
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
}

// Its State
class _WebPageWrapperState extends State<WebPageWrapper> {
  //
  @override
  void initState() {
    super.initState();
    _widget = widget;
    _widget._state.add(this);
    _widget.initState();
  }

  // Reduce using the getter.
  late WebPageWrapper _widget;

  // The StatefulWidget will change
  @override
  void didUpdateWidget(covariant WebPageWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget._state.clear();
    _widget = widget;
    // Supply the new widget its State object
    _widget._state.add(this);
  }

  // Stores the child widget generated
  Widget? child;

  // Clean up after itself
  @override
  void dispose() {
    child = null;
    _widget._state.clear();
    _widget.dispose();
    super.dispose();
  }

  ///
  double offset = 0;

  //
  double lastOffset = 0;

  ///
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    //
    final screenSize = context.screenSize;

    opacity = offset < screenSize.height * 0.40
        ? offset / (screenSize.height * 0.40)
        : 1;

    Widget _child;

    try {
      /// Retrieve the main content if any.
      _child = Scaffold(
        appBar: _widget.appBar ?? _widget.onAppBar(),
        body: _widget.body ?? _widget.onBody() ?? _body(context),
        floatingActionButton: _widget.floatingActionButton,
        floatingActionButtonLocation: _widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: _widget.floatingActionButtonAnimator,
        persistentFooterButtons: _widget.persistentFooterButtons,
        persistentFooterAlignment:
            _widget.persistentFooterAlignment ?? AlignmentDirectional.centerEnd,
        drawer: _widget.drawer ?? _widget.onDrawer(),
        onDrawerChanged: _widget.onDrawerChanged ?? _widget.drawerChanged,
        endDrawer: _widget.endDrawer ?? _widget.onEndDrawer(),
        onEndDrawerChanged:
            _widget.onEndDrawerChanged ?? _widget.endDrawerChanged,
        bottomNavigationBar:
            _widget.bottomNavigationBar ?? _widget.onBottomNavigationBar(),
        bottomSheet: _widget.bottomSheet ?? _widget.onBottomSheet(),
        backgroundColor: _widget.backgroundColor ?? _widget.onBackgroundColor(),
        resizeToAvoidBottomInset: _widget.resizeToAvoidBottomInset,
        primary: _widget.primary ?? true,
        drawerDragStartBehavior:
            _widget.drawerDragStartBehavior ?? DragStartBehavior.start,
        extendBody: _widget.extendBody ?? false,
        extendBodyBehindAppBar: _widget.extendBodyBehindAppBar ?? false,
        drawerScrimColor: _widget.drawerScrimColor,
        drawerEdgeDragWidth: _widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture:
            _widget.drawerEnableOpenDragGesture ?? true,
        endDrawerEnableOpenDragGesture:
            _widget.endDrawerEnableOpenDragGesture ?? true,
        restorationId: _widget.restorationId,
      );
    } catch (ex, stack) {
      _child = const SizedBox();
      FlutterError.reportError(FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: 'webpage_wrapper.dart',
        context: ErrorDescription('class WebPageWrapper failed'),
      ));
      // Make the error known if under development.
      if (App.inDebugMode) {
        rethrow;
      }
    }
    return _child;
  }

  /// Provide the body of the webpage
  Widget _body(BuildContext context) {
    //
    var _scrollController = _widget.scrollController;

    // If no controller or no 'child' widget set.
    final addListener = _scrollController == null || child == null;

    _scrollController ??= ScrollController();

    if (addListener) {
      /// Record the offset with every scroll.
      _scrollController.addListener(() {
        lastOffset = offset;
        offset = _scrollController!.offset;
      });
    }

    // Set the 'child' widget if one was explicitly passed or there's a builder
    child ??= _widget.child ?? _widget.builder(context);

    // Determine the webpage content
    var content = child ?? _widget.onChild(context) ?? const SizedBox();

    // Possibly add a 'footer' to the webpage content
    if (_widget.addFooter ?? true) {
      //
      final footer = _widget.footer(context);

      if (footer != null) {
        //
        final List<Widget> list = [];

        list.add(content);

        list.add(SizedBox(height: context.screenSize.height / 10));

        list.add(footer);

        content = Column(children: list);
      }
    }

    Widget _child = SingleChildScrollView(
      scrollDirection: _widget.scrollDirection ?? Axis.vertical,
      reverse: _widget.reverse ?? false,
      padding: _widget.padding,
      primary: _widget.scrollPrimary ?? false,
      physics: _widget.physics ?? const ClampingScrollPhysics(),
      controller: _scrollController,
      dragStartBehavior: _widget.dragStartBehavior ?? DragStartBehavior.start,
      clipBehavior: _widget.clipBehavior ?? Clip.hardEdge,
      keyboardDismissBehavior: _widget.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      // onChild() will be executed again.
      child: content,
    );

    final _overlay = _widget.screenOverlay;

    ///
    if (_overlay != null && _overlay.showOverlay) {
      //
      _child = Stack(
        alignment: _overlay.alignment ?? AlignmentDirectional.topStart,
        textDirection: _overlay.textDirection,
        fit: _overlay.fit ?? StackFit.loose,
        clipBehavior: _overlay.clipBehavior ?? Clip.hardEdge,
        children: [
          _child,
          _overlay,
        ],
      );
    }
    return _child;
  }
}

/// Display an external webpage.
Future<bool> uriBrowse(
  String? uri, {
  String? webOnlyWindowName,
}) async {
  //
  bool browse;

  if (uri == null) {
    browse = false;
  } else {
    try {
      await launchUrl(
        Uri.parse(uri),
        webOnlyWindowName: webOnlyWindowName,
      );
      browse = true;
    } catch (e) {
      browse = false;
    }
  }
  return browse;
}

/// Supply an overlay for the screen.
abstract class ScreenOverlayWidget extends StatefulWidget {
  /// All are optional except the child widget.
  ScreenOverlayWidget({
    super.key,
    this.show,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
  }) : state = _ScreenOverlayState() {
    state.showOverlay = show ?? true;
  }

  ///
  final bool? show;

  ///
  final AlignmentGeometry? alignment;

  ///
  final TextDirection? textDirection;

  ///
  final StackFit? fit;

  ///
  final Clip? clipBehavior;

  /// A reference of the State object.
  final _ScreenOverlayState state;

  /// supply your overlay
  Widget build(BuildContext context);

  /// Rebuild State object
  //ignore: invalid_use_of_protected_member
  void setState(VoidCallback fn) => state.setState(fn);

  /// Show the overlay? Test this in the parent widget calling this.
  bool get showOverlay => state.showOverlay;

  /// Set the State object's boolean flag.
  set showOverlay(bool? show) {
    if (show != null) {
      state.showOverlay = show;
    }
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => state;
}

class _ScreenOverlayState extends State<ScreenOverlayWidget> {
  bool showOverlay = true;

  @override
  void didUpdateWidget(covariant ScreenOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) =>
      showOverlay ? widget.build(context) : const SizedBox();
}

/// An extension on BuildContext
extension WebContextExtension on BuildContext {
  ///
  Size get screenSize => MediaQuery.of(this).size;

  /// Return the bool value indicating if running in a small screen or not.
  bool get inSmallScreen => screenSize.width < 800;

  /// Set whether the app is to use a 'small screen' or not.
  /// Determine if running on a desktop or on a phone or tablet
  bool get asSmallScreen => App.inDebugMode && false;
}
