//
import 'package:fluttery_framework/view.dart' as v;

import '/src/view.dart';

class AppDrawer extends v.AppDrawer {
  factory AppDrawer({Key? key}) => _this ??= AppDrawer._(key);
  static AppDrawer? _this;

  AppDrawer._(Key? key) : super(key: key) {
    //
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
    ]);
  }
}
