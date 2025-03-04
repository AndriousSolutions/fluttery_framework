library;
// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

/// Standard Counter Screen
///
class BuildPage extends StatelessWidget {
  ///
  const BuildPage({
    super.key,
    required this.label,
    required this.count,
    required this.counter,
    this.column,
    required this.row,
    this.persistentFooterButtons,
  });

  ///
  final String label;

  ///
  final int count;

  ///
  final void Function() counter;

  ///
  final List<Widget> Function(BuildContext context)? column;

  ///
  final List<Widget> Function(BuildContext context) row;

  ///
  final List<Widget>? persistentFooterButtons;

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (App.useMaterial) {
      //
      widget = Scaffold(
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButton: FloatingActionButton(
          key: const Key('+'),
          onPressed: counter,
          child: const Icon(Icons.add),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text("You're on page:".tr),
            ),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(fontSize: 48),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'You have pushed the button this many times:'.tr,
                ),
              ),
            ),
            Flexible(
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: row(context),
              ),
            ),
            if (column == null)
              const Flexible(child: SizedBox())
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: column!(context),
              ),
          ],
        ),
      );
    } else {
      //
      widget = CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text("You're on page:".tr),
                    ),
                    Flexible(
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'You have pushed the button this many times:'.tr,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '$count',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: row(context),
                      ),
                    ),
                    if (column == null)
                      const Flexible(child: SizedBox())
                    else
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: column!(context),
                      ),
                  ],
                ),
              ),
              if (persistentFooterButtons != null)
                // Container(
                //   decoration: const BoxDecoration(
                //     border: Border(
                //       top: BorderSide(
                //         color: Color(0xFFBCBBC1),
                //         // width: 0,
                //       ),
                //     ),
                //   ),
                //   // child: SizedBox(
                //   //   height: 44,
                //   //   child: Row(
                //   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   //     children: persistentFooterButtons!,
                //   //   ),
                //   // ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: persistentFooterButtons!,
                //   ),
                // )
                Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: persistentFooterButtons!,
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return widget;
  }
}

///
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
