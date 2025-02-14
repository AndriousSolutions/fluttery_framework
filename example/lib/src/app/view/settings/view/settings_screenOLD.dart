//
import 'package:flutter/gestures.dart' show PointerDeviceKind;

import '/src/view.dart';

/// The Settings page
class SettingsPage extends StatefulWidget {
  ///
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class _SettingsPageState extends StateX<SettingsPage> {
  @override
  void initState() {
    super.initState();
    _data = generateItems(8);
  }

  late List<Item> _data;

  List<Item> generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      return Item(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index',
      );
    });
  }

  @override
  Widget buildAndroid(BuildContext context) {
    return Center(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: ListTile(
                title: Text(item.expandedValue),
                subtitle:
                    const Text('To delete this panel, tap the trash can icon'),
                trailing: const Icon(Icons.delete),
                onTap: () {
                  setState(() {
                    _data
                        .removeWhere((Item currentItem) => item == currentItem);
                  });
                }),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget buildiOS(BuildContext context) {
    return CupertinoListSection(
      header: Text('Settings'.tr),
      children: <CupertinoListTile>[
        CupertinoListTile(
          title: Text('App Settings'.tr),
          // additionalInfo: Text('Not available'),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) =>
                  BackButtonCupertinoPageScaffold(
                      title: 'App Settings'.tr, child: AppSettingsDrawer()),
            ),
          ),
        ),
        CupertinoListTile(
          title: Text('Development Tools'.tr),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) =>
                  BackButtonCupertinoPageScaffold(
                      title: 'Development Tools'.tr, child: AppDrawer()),
            ),
          ),
        ),
        CupertinoListTile(
          title: Text('View last commit'.tr),
          additionalInfo: const Text('12 days ago'),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) {
                return const _SecondPage(text: 'Last commit');
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(text),
      ),
    );
  }
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
    final isPortrait = context.isPortrait;

    Widget widget = child ??
        CupertinoButton(
          child: const Text('Press me'),
          onPressed: () => Navigator.of(context).maybePop(),
        );

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
    if (UniversalPlatform.isApple) {
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
        appBar: AppBar(
          leading: leading,
          title: Text(title ?? ''),
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
