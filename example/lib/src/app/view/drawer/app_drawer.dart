//
import 'package:fluttery_framework/view.dart' as v;

import '/src/view.dart';

/// The App's Drawer
class AppDrawer extends v.AppDrawer {
  ///
  AppDrawer({super.key}) : _dev = DevToolsSettings() {
    //
    // Don't offer these development tools if testing the app
    if (!App.inFlutterTest) {
      addAll(_dev.devSettings);
    }

    addAll([
      ListTile(
        key: const Key('Show Box'),
        subtitle: const Text('Show Box'),
        onTap: () async {
          await showBox(
            context: App.context!,
            useMaterial: App.useMaterial,
            content: const Text('This is the showBox()'),
          );
        },
      ),
      ListTile(
        key: const Key('Dialog Box'),
        subtitle: const Text('Dialog Window'),
        onTap: () => dialogBox(
          App.context!,
          title: 'This is a dialog box.',
        ),
      ),
      ListTile(
          key: const Key('Message Box'),
          subtitle: const Text('Message Box'),
          onTap: () {
            MsgBox(
              context: App.context!,
              title: 'Message Box',
              msg: 'This is a Message Box.',
            ).show();
          }),
      ListTile(
        key: const Key('Navigation'),
        subtitle: const Text('App Navigation'),
        onTap: () async {
          await App.pushNamed('/Page01');
        },
      ),
    ]);
  }
  //
  final DevToolsSettings _dev;
}
