//
import 'package:fluttery_framework/view.dart' as v;

import '/src/view.dart';

/// The App's Drawer
class AppDrawer extends v.AppDrawer {
  ///
  AppDrawer({super.key}) {
    //
    if (App.appState?.routesGenerated ?? false) {
      add(ListTile(
        key: const Key('Navigation'),
        subtitle: const Text('App Navigation'),
        onTap: () async {
          await App.pushNamed('/Page01');
        },
      ));
    }
  }
}
