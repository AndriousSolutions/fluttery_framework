//
import '/src/controller.dart';

import '/src/view.dart';

///
class NavState<T extends NavWidget> extends StateX<T> {
  ///
  NavState({
    super.runAsync,
    super.useInherited,
    // Highlight the call of event functions
  }) : super(controller: NavController(), printEvents: true) {
    _con = controller as NavController;
  }
  late NavController _con;

  ///
  Widget? prevWidget, nextWidget;

  @override
  void dispose() {
    prevWidget = null;
    nextWidget = null;
    super.dispose();
  }

  ///
  late AppStateX appState;

  ///
  String title = '';

  ///
  String routekey = '';

  /// The index in the List of Routes
  int index = -1;

  ///
  Widget canPopWidget() {
    return RouteButton(
      key: Key('canPopWidget$title'),
      onPressed: () => _con.canPop(),
      child: const Text('canPop'),
    );
  }

  ///
  Widget finalizeRouteWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('finalizeRouteWidget$title'),
      onPressed: enabled ? () => _con.finalizeRoute() : null,
      child: const Text('finalizeRoute'),
    );
  }

  ///
  Widget maybePopWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('maybePopWidget$title'),
      onPressed: enabled ? () => _con.maybePop() : null,
      child: const Text('maybePop'),
    );
  }

  ///
  Widget popWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('popWidget$title'),
      onPressed: enabled ? () => _con.pop() : null,
      child: const Text('pop'),
    );
  }

  ///
  Widget popAndPushNamedWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('popAndPushNamedWidget$title'),
      onPressed: enabled ? () => _con.popAndPushNamed() : null,
      child: const Text('popAndPushNamed'),
    );
  }

  ///
  Widget popUntilWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('popUntilWidget$title'),
      onPressed: enabled ? () => _con.popUntil() : null,
      child: const Text('popUntil'),
    );
  }

  ///
  Widget pushWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushWidget$title'),
      onPressed: enabled ? () => _con.push() : null,
      child: const Text('push'),
    );
  }

  ///
  Widget pushAndRemoveUntilWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushAndRemoveUntilWidget$title'),
      onPressed: enabled ? () => _con.pushAndRemoveUntil() : null,
      child: const Text('pushAndRemoveUntil'),
    );
  }

  ///
  Widget pushNamedWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushNamedWidget$title'),
      onPressed: enabled ? () => _con.pushNamed() : null,
      child: const Text('pushNamed'),
    );
  }

  ///
  Widget pushNamedAndRemoveUntilWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushNamedAndRemoveUntilWidget$title'),
      onPressed: enabled ? () => _con.pushNamedAndRemoveUntil() : null,
      child: const Text('pushNamedAndRemoveUntil'),
    );
  }

  ///
  Widget pushReplacementWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushReplacementWidget$title'),
      onPressed: enabled ? () => _con.pushReplacement() : null,
      child: const Text('pushReplacement'),
    );
  }

  ///
  Widget pushReplacementNamedWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('pushReplacementNamedWidget$title'),
      onPressed: enabled ? () => _con.pushReplacement() : null,
      child: const Text('pushReplacementNamed'),
    );
  }

  ///
  Widget removeRouteWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('removeRouteWidget$title'),
      onPressed: enabled ? () => _con.removeRoute() : null,
      child: const Text('removeRoute'),
    );
  }

  ///
  Widget removeRouteBelowWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('removeRouteBelowWidget$title'),
      onPressed: enabled ? () => _con.removeRouteBelow() : null,
      child: const Text('removeRouteBelow'),
    );
  }

  ///
  Widget replaceWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('replaceWidget$title'),
      onPressed: enabled ? () => _con.replace() : null,
      child: const Text('replace'),
    );
  }

  ///
  Widget replaceRouteBelowWidget() {
    final enabled = _con.lastRoute;
    return RouteButton(
      key: Key('replaceRouteBelowWidget$title'),
      onPressed: enabled ? () => _con.replaceRouteBelow() : null,
      child: const Text('replaceRouteBelow'),
    );
  }

  ///
  Widget restorablePopAndPushNamedWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePopAndPushNamedWidget$title'),
      onPressed: enabled ? () => _con.restorablePopAndPushNamed() : null,
      child: const Text('restorablePopAndPushNamed'),
    );
  }

  ///
  Widget restorablePushWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushWidget$title'),
      onPressed: enabled ? () => _con.restorablePush() : null,
      child: const Text('restorablePush'),
    );
  }

  ///
  Widget restorablePushAndRemoveUntilWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushAndRemoveUntilWidget$title'),
      onPressed: enabled ? () => _con.restorablePushAndRemoveUntil() : null,
      child: const Text('restorablePushAndRemoveUntil'),
    );
  }

  ///
  Widget restorablePushNamedWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushNamedWidget$title'),
      onPressed: enabled ? () => _con.restorablePushNamed() : null,
      child: const Text('restorablePushNamed'),
    );
  }

  ///
  Widget restorablePushNamedAndRemoveUntilWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushNamedAndRemoveUntilWidget$title'),
      onPressed:
          enabled ? () => _con.restorablePushNamedAndRemoveUntil() : null,
      child: const Text('restorablePushNamedAndRemoveUntil'),
    );
  }

  ///
  Widget restorablePushReplacementWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushReplacementWidget$title'),
      onPressed: enabled ? () => _con.restorablePushReplacement() : null,
      child: const Text('restorablePushReplacement'),
    );
  }

  ///
  Widget restorablePushReplacementNamedWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorablePushReplacementNamedWidget$title'),
      onPressed: enabled ? () => _con.restorablePushReplacementNamed() : null,
      child: const Text('restorablePushReplacementNamed'),
    );
  }

  ///
  Widget restorableReplaceWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorableReplaceWidget$title'),
      onPressed: enabled ? () => _con.restorableReplace() : null,
      child: const Text('restorableReplace'),
    );
  }

  ///
  Widget restorableReplaceRouteBelowWidget() {
    final enabled = _con.canPopRoute;
    return RouteButton(
      key: Key('restorableReplaceRouteBelowWidget$title'),
      onPressed: enabled ? () => _con.restorableReplaceRouteBelow() : null,
      child: const Text('restorableReplaceRouteBelow'),
    );
  }
}

///
class RouteButton extends StatelessWidget {
  ///
  const RouteButton({
    super.key,
    this.alignment,
    this.widthFactor,
    this.heightFactor,
    this.controller,
    this.onPressed,
    required this.child,
  });

  ///
  final AlignmentGeometry? alignment;

  ///
  final VoidCallback? onPressed;

  ///
  final Widget child;

  ///
  final double? widthFactor, heightFactor;

  ///
  final WidgetStatesController? controller;

  @override
  Widget build(BuildContext context) {
    //
    final con = NavController();
    //
    String? text;

    if (key == con.key) {
      text = con.text;
      // Nullify theses properties now
      con.key = con.text = null;
    }
    //
    VoidCallback? onPressed;

    // If null, the button is disabled
    if (this.onPressed != null) {
      onPressed = () {
        // Record its Key
        con.key = key;
        this.onPressed?.call();
      };
    }

    final textKey = Key('${(key as ValueKey).value}Text');

    return Row(
      children: [
        Align(
          alignment: alignment ?? Alignment.centerLeft,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor:
                  Theme.of(context).buttonTheme.colorScheme?.secondaryFixedDim,
              disabledForegroundColor: Colors.white70,
            ),
            onPressed: onPressed,
            statesController: controller,
            child: child,
          ),
        ),
        Flexible(child: Text(text ?? '', key: textKey)),
      ],
    );
  }
}

// /// A Flexible Row widget
// class _Row extends StatelessWidget {
//   const _Row({
//     super.key,
//     this.mainAxisAlignment,
//     this.mainAxisSize,
//     this.crossAxisAlignment,
//     this.textDirection,
//     this.verticalDirection,
//     this.textBaseline,
//     required this.children,
//   });
//
//   final MainAxisAlignment? mainAxisAlignment;
//   final MainAxisSize? mainAxisSize;
//   final CrossAxisAlignment? crossAxisAlignment;
//   final TextDirection? textDirection;
//   final VerticalDirection? verticalDirection;
//   final TextBaseline? textBaseline;
//   final List<Widget> children;
//
//   @override
//   Widget build(_) => Row(
//         mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
//         mainAxisSize: mainAxisSize ?? MainAxisSize.max,
//         crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
//         textDirection: textDirection,
//         verticalDirection: verticalDirection ?? VerticalDirection.down,
//         textBaseline: textBaseline,
//         children: children,
//       );
// }
