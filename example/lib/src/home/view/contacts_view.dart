//
import 'package:fluttery_framework_example/src/view.dart';

import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/home/view/contacts/add_contact.dart'
    show AddContact;

import 'package:fluttery_framework_example/src/home/view/contacts/contact_details.dart'
    show ContactDetails;

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key, this.title = 'Contacts App'}) : super(key: key);
  final String title;
  @override
  State createState() => _ContactListState();
}

class _ContactListState extends StateX<ContactsList> {
  _ContactListState() : super(ContactsController()) {
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

  @override
  Widget build(BuildContext context) =>
      App.useMaterial ? _buildAndroid(this) : _buildiOS(this);
}

Widget _buildAndroid(_ContactListState state) {
  //
  final con = state.con;
  return Scaffold(
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
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        await Navigator.of(con.state!.context).push(MaterialPageRoute<void>(
          builder: (_) => const AddContact(),
        ));
        //     .then((_) {
        //   con.refresh();
        // });
        /// Either use the 'then' clause or the 'async await' command.
        con.refresh();
      },
      child: const Icon(Icons.add),
    ),
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
                        await Navigator.of(con.state!.context)
                            .push(MaterialPageRoute<void>(
                          builder: (_) => ContactDetails(contact: contact),
                        ));
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
  );
}

Widget _buildiOS(_ContactListState state) {
  //
  final con = state.con;
  final widget = state.widget;
  final _theme = App.themeData;
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
//              appCon.menu,
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
                      color: _theme?.canvasColor,
                      border: Border(
                        bottom: BorderSide(color: _theme!.dividerColor),
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
