/// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// found in the LICENSE file.

import 'package:fluttery_framework/view.dart';

import 'package:url_launcher/url_launcher.dart';

/// A widget that displays a hyperlink
class Hyperlink extends StatelessWidget {
  /// Must supply a child widget and a url string.
  const Hyperlink(this.child, this.url, {Key? key}) : super(key: key);

  ///
  final Widget? child;

  ///
  final String? url;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          Uri uri;
          if (url != null && url!.isNotEmpty) {
            uri = Uri.parse(url!);
            final launching = await canLaunchUrl(uri);
            if (launching) {
              try {
                await launchUrl(uri);
              } catch (ex) {/* */}
            }
          }
        },
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: child ?? const Text('   '),
        ),
      );
}
