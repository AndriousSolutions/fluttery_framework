//
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
                    _data.removeWhere((Item currentItem) => item == currentItem);
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
      header: const Text('Settings'),
      children: <CupertinoListTile>[
        CupertinoListTile(
          title: const Text('Development Tools'),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) =>
                  BackButtonCupertinoPageScaffold(
                      title: 'Settings', child: AppDrawer()),
            ),
          ),
        ),
        const CupertinoListTile(
          title: Text('Push to master'),
          additionalInfo: Text('Not available'),
        ),
        CupertinoListTile(
          title: const Text('View last commit'),
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
