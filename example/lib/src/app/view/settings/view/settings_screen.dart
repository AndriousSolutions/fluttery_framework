//
import 'package:flutter/gestures.dart' show PointerDeviceKind;

import '/src/view.dart';

/// The Settings
class SettingsPage extends StatelessWidget {
  ///
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: AppSettingsDrawer(key: const Key('AppSettingsDrawer'))),
          Flexible(
              child: DevSettingsDrawer(key: const Key('DevSettingsDrawer'))),
        ],
      );
}

/// The Settings
class SettingsScreen extends StatelessWidget {
  ///
  const SettingsScreen({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.child,
  });

  ///
  final Widget? leading;

  ///
  final String? title;

  ///
  final Widget? trailing;

  /// Displayed widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    //
    // final isPortrait = context.isPortrait;

    Widget widget = child ?? const Text('-- Empty Content --');

    if (kIsWeb || UniversalPlatform.isWindows) {
      //
      widget = ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: widget,
      );
    }
    //
    if (App.useCupertino) {
      //
      widget = CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: leading,
          middle: Text(title ?? ''),
          trailing: trailing,
        ),
        child: SafeArea(
          child: widget,
        ),
      );
    } else {
      //
      widget = Scaffold(
        primary: false,
        appBar: AppBar(
          leading: leading ?? const Text(''),
          title: Text(title ?? ''),
          centerTitle: true,
          actions: trailing == null ? null : [trailing!],
        ),
        body: SafeArea(
          child: widget,
        ),
      );
    }
    return widget;
  }
}

/// Supply the appropriate ListTile widget
Widget listTile({
  Key? key,
  Widget? leading,
  Widget? title,
  GestureTapCallback? onTap,
  String? tip,
  required bool value,
  ValueChanged<bool>? onChanged,
}) =>
    ListTile(
      key: key,
      leading: leading,
      title: title,
      onTap: onTap,
      trailing: Tooltip(
        message: tip ?? '',
        preferBelow: false,
        verticalOffset: 20,
        height: 24,
        child: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
