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
  String title = '';

  ///
  String routekey = '';

  /// The index in the List of Routes
  int index = -1;

  ///
  Widget canPopWidget() => RouteButton(
        key: Key('canPopWidget$title'),
        onPressed: () => _con.canPop(),
        child: const Text('canPop'),
      );

  ///
  Widget finalizeRouteWidget() => RouteButton(
        key: Key('finalizeRouteWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.finalizeRoute();
          }
        },
        child: const Text('finalizeRoute'),
      );

  ///
  Widget maybePopWidget() => RouteButton(
        key: Key('maybePopWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.maybePop<bool>(true);
          }
        },
        child: const Text('maybePop'),
      );

  ///
  Widget popWidget() => RouteButton(
        key: Key('popWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.pop<bool>(true);
          }
        },
        child: const Text('pop'),
      );

  ///
  Widget popAndPushNamedWidget() => RouteButton(
        key: Key('popAndPushNamedWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.popAndPushNamed();
          }
        },
        child: const Text('popAndPushNamed'),
      );

  ///
  Widget popUntilWidget() => RouteButton(
        key: Key('popUntilWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.popUntil();
          }
        },
        child: const Text('popUntil'),
      );

  ///
  Widget pushWidget() => RouteButton(
        key: Key('pushWidget$title'),
        onPressed: () {
          final enabled = _con.lastRoute;
          if (enabled) {
            _con.push();
          }
        },
        child: const Text('push'),
      );

  ///
  Widget pushAndRemoveUntilWidget() => RouteButton(
        key: Key('pushAndRemoveUntilWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.pushAndRemoveUntil();
          }
        },
        child: const Text('pushAndRemoveUntil'),
      );

  ///
  Widget pushNamedWidget() => RouteButton(
        key: Key('pushNamedWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.pushNamed();
          }
        },
        child: const Text('pushNamed'),
      );

  ///
  Widget pushNamedAndRemoveUntilWidget() => RouteButton(
        key: Key('pushNamedAndRemoveUntilWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.pushNamedAndRemoveUntil();
          }
        },
        child: const Text('pushNamedAndRemoveUntil'),
      );

  ///
  Widget pushReplacementWidget() => RouteButton(
        key: Key('pushReplacementWidget$title'),
        onPressed: () => _con.pushReplacement(),
        child: const Text('pushReplacement'),
      );

  ///
  Widget pushReplacementNamedWidget() => RouteButton(
        key: Key('pushReplacementNamedWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.pushReplacement();
          }
        },
        child: const Text('pushReplacementNamed'),
      );

  ///
  Widget removeRouteWidget() => RouteButton(
        key: Key('removeRouteWidget$title'),
        onPressed: _con.canPopRoute ? () => _con.removeRoute() : null,
        child: const Text('removeRoute'),
      );

  ///
  Widget removeRouteBelowWidget() => RouteButton(
        key: Key('removeRouteBelowWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.removeRouteBelow();
          }
        },
        child: const Text('removeRouteBelow'),
      );

  ///
  Widget replaceWidget() => RouteButton(
        key: Key('replaceWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.replace();
          }
        },
        child: const Text('replace'),
      );

  ///
  Widget replaceRouteBelowWidget() => RouteButton(
        key: Key('replaceRouteBelowWidget$title'),
        onPressed: () {
          final last = _con.lastRoute;
          if (!last) {
            _con.replaceRouteBelow();
          }
        },
        child: const Text('replaceRouteBelow'),
      );

  ///
  Widget restorablePopAndPushNamedWidget() => RouteButton(
        key: Key('restorablePopAndPushNamedWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePopAndPushNamed();
          }
        },
        child: const Text('restorablePopAndPushNamed'),
      );

  ///
  Widget restorablePushWidget() => RouteButton(
        key: Key('restorablePushWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePush();
          }
        },
        child: const Text('restorablePush'),
      );

  ///
  Widget restorablePushAndRemoveUntilWidget() => RouteButton(
        key: Key('restorablePushAndRemoveUntilWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePushAndRemoveUntil();
          }
        },
        child: const Text('restorablePushAndRemoveUntil'),
      );

  ///
  Widget restorablePushNamedWidget() => RouteButton(
        key: Key('restorablePushNamedWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePushNamed();
          }
        },
        child: const Text('restorablePushNamed'),
      );

  ///
  Widget restorablePushNamedAndRemoveUntilWidget() => RouteButton(
        key: Key('restorablePushNamedAndRemoveUntilWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePushNamedAndRemoveUntil();
          }
        },
        child: const Text('restorablePushNamedAndRemoveUntil'),
      );

  ///
  Widget restorablePushReplacementWidget() => RouteButton(
        key: Key('restorablePushReplacementWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePushReplacement();
          }
        },
        child: const Text('restorablePushReplacement'),
      );

  ///
  Widget restorablePushReplacementNamedWidget() => RouteButton(
        key: Key('restorablePushReplacementNamedWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorablePushReplacementNamed();
          }
        },
        child: const Text('restorablePushReplacementNamed'),
      );

  ///
  Widget restorableReplaceWidget() => RouteButton(
        key: Key('restorableReplaceWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorableReplace();
          }
        },
        child: const Text('restorableReplace'),
      );

  ///
  Widget restorableReplaceRouteBelowWidget() => RouteButton(
        key: Key('restorableReplaceRouteBelowWidget$title'),
        onPressed: () {
          final enabled = _con.canPopRoute;
          if (enabled) {
            _con.restorableReplaceRouteBelow();
          }
        },
        child: const Text('restorableReplaceRouteBelow'),
      );
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
      text = NavController.text;
      // Nullify theses properties now
      con.key = NavController.text = null;
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

    final buttonKey = Key('${(key as ValueKey).value}Button');

    return Row(
      children: [
        Align(
          alignment: alignment ?? Alignment.centerLeft,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: ElevatedButton(
            key: buttonKey,
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
