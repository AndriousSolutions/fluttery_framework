library;
//
import 'package:flutter/gestures.dart' show PointerDeviceKind;

// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

///
class TwoTabCupertinoPageScaffold extends StatelessWidget {
  ///
  const TwoTabCupertinoPageScaffold({
    super.key,
    required this.tab01,
    required this.tab02,
    this.navigationBar,
  });

  ///
  final Widget tab01;

  ///
  final Widget tab02;

  ///
  final CupertinoNavigationBar? navigationBar;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: navigationBar,
        child: SafeArea(
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.home), label: 'Home'.tr),
                BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.settings),
                    label: 'Settings'.tr),
              ],
            ),
            tabBuilder: (context, index) => CupertinoTabView(
              builder: (context) {
                Widget widget;
                switch (index) {
                  case 0:
                    widget = tab01;
                    break;
                  case 1:
                    widget = tab02;
                    break;
                  default:
                    widget = const SizedBox.shrink();
                }
                return widget;
              },
            ),
          ),
        ),
      );
}

///
class BackButtonCupertinoPageScaffold extends StatelessWidget {
  ///
  const BackButtonCupertinoPageScaffold({super.key, this.title, this.child});

  /// Title page
  final String? title;

  /// Displayed widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    //
    Widget widget = child ??
        CupertinoButton(
          child: const Text('Press me'),
          onPressed: () => Navigator.of(context).maybePop(),
        );

    if( kIsWeb || UniversalPlatform.isWindows){
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        middle: Text(title ?? ''),
      ),
      child: SafeArea(
        child: widget,
      ),
    );
  }
}
