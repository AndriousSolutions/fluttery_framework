//
import 'package:fluttery_framework_example/src/view.dart';

import 'package:fluttery_framework_example/src/controller.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key, this.title = 'Contacts App'}) : super(key: key);
  final String title;
  @override
  State createState() => _ContactListState();
}

class _ContactListState extends StateX<ContactsList> {
  _ContactListState() : super(controller: ContactsController()) {
    con = controller as ContactsController;
  }
  late ContactsController con;

  @override
  void initState() {
    super.initState();
    _title = App.title!;
    appCon = TemplateController();
  }

  String? _title;
  late TemplateController appCon;

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildAndroid(BuildContext context) => _buildAndroid(this);

  /// Depending on the platform, run an 'Android' or 'iOS' style of Widget.
  @override
  Widget buildiOS(BuildContext context) => _buildiOS(this);

  // Merely for demonstration purposes. Erase if not using.
  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  //ignore: unnecessary_overrides
  void activate() {
    super.activate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method when this [State] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Calls setState((){});
  void refresh() {
    super.setState(() {});
  }

  // Merely for demonstration purposes. Erase if not using.
  /// An 'error handler' routine to fire when an error occurs.
  /// Allows the user to define their own with each State.
  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);
  }

  // Merely for demonstration purposes. Erase if not using.
  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when a dependency of this [State] object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    super.reassemble();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  /// Observers are notified in registration order until one returns
  /// true. If none return true, the application quits.
  @override
  Future<bool> didPopRoute() async {
    return super.didPopRoute();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification. Observers are notified in registration
  /// order until one returns true.
  ///
  /// This method exposes the `pushRoute` notification from
  // ignore: comment_references
  @override
  Future<bool> didPushRoute(String route) async {
    return super.didPushRoute(route);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.suspending (Android only)
    super.didChangeAppLifecycleState(state);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }
}

Widget _buildAndroid(_ContactListState state) {
  //
  final con = state.con;
  return Scaffold(
    key: const Key('Scaffold'),
    appBar: AppBar(
      title: Text(state._title ?? state.widget.title),
      actions: [
        TextButton(
          onPressed: () {
            con.sort();
          },
          child: Icon(con.sortedAlpha ? Icons.sort : Icons.sort_by_alpha,
              color: Colors.white),
        ),
        AppMenu().popupMenuButton,
//        appCon.menu,
      ],
    ),
    drawer: AppDrawer(key: const Key('AppDrawer')),
    body: SafeArea(
      child: con.items == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: con.items?.length ?? 0,
              itemBuilder: (_, int index) {
                final contact = con.itemAt(index);
                return contact!.displayName.onDismissible(
                  background: Container(
                    color: Colors.red,
                    child: const ListTile(
                      leading:
                          Icon(Icons.delete, color: Colors.white, size: 36),
                      trailing:
                          Icon(Icons.delete, color: Colors.white, size: 36),
                    ),
                  ),
                  dismissed: (DismissDirection direction) {
                    con.deleteItem(index);
                    final action = (direction == DismissDirection.endToStart)
                        ? 'deleted'
                        : 'archived';
                    App.snackBar(
                      duration: const Duration(milliseconds: 8000),
                      content: Text('You $action an item.'.tr),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            contact.undelete();
                            state.setState(() {});
                          }),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(),
                    ),
                    child: ListTile(
                      onTap: () async {
                        final widget = ContactDetails(contact: contact);
                        PageRoute<void> route;
                        if (App.useMaterial) {
                          route = MaterialPageRoute<void>(
                              builder: (BuildContext context) => widget);
                        } else {
                          route = CupertinoPageRoute<void>(
                              builder: (BuildContext context) => widget);
                        }
                        await Navigator.of(state.context).push(route);
                        await con.getContacts();
                        con.state!.setState(() {});
                      },
                      leading: contact.displayName.circleAvatar,
                      title: contact.displayName.text,
                    ),
                  ),
                );
              },
            ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final context = con.state!.context;
        final useRouter = App.appState!.useRouterConfig!;
        if (useRouter) {
          await context.push<void>('/add');
        } else {
          // Of course, this is for demo purposes. This is what's done without the Router Configuration.
          await Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => const AddContact(),
          ));
        }
        // Refresh to relieve any changes made.
        con.refresh();
      },
      child: const Icon(Icons.add),
    ),
  );
}

Widget _buildiOS(_ContactListState state) {
  //
  final con = state.con;
  final widget = state.widget;
  final theme = App.themeData;
  return CupertinoPageScaffold(
    child: CustomScrollView(
      semanticChildCount: 5,
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(state._title ?? widget.title),
          leading: Material(
            child: IconButton(
              icon: Icon(con.sortedAlpha ? Icons.sort : Icons.sort_by_alpha),
              onPressed: () {
                con.sort();
              },
            ),
          ),
          middle: Material(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(con.state!.context)
                    .push(MaterialPageRoute<void>(
                  builder: (_) => const AddContact(),
                ));
                con.refresh();
              },
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppMenu().popupMenuButton,
            ],
          ),
        ),
        if (con.items == null)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                final contact = con.itemAt(index);
                return contact?.displayName.onDismissible(
                  background: Material(
                    child: Container(
                      color: Colors.red,
                      child: const ListTile(
                        leading:
                            Icon(Icons.delete, color: Colors.white, size: 40),
                        trailing:
                            Icon(Icons.delete, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                  dismissed: (DismissDirection direction) {
                    con.deleteItem(index);
                    final action = (direction == DismissDirection.endToStart)
                        ? 'deleted'
                        : 'archived';
                    App.snackBar(
                      duration: const Duration(milliseconds: 8000),
                      content: Text('You $action an item.'),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            contact.undelete();
                            state.setState(() {});
                          }),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme?.canvasColor,
                      border: Border(
                        bottom: BorderSide(color: theme!.dividerColor),
                      ),
                    ),
                    child: CupertinoListTile(
                      leading: contact.displayName.circleAvatar,
                      title: contact.displayName.text,
                      onTap: () async {
                        await Navigator.of(con.state!.context)
                            .push(MaterialPageRoute<void>(
                          builder: (_) => ContactDetails(contact: contact),
                        ));
                        await con.getContacts();
                        con.state!.setState(() {});
                      },
                    ),
                  ),
                );
              },
              childCount: con.items?.length,
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
            ),
          ),
      ],
    ),
  );
}
