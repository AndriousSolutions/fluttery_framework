library;

///
///  This widget works with the free Fox API.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomFox extends StatefulWidget {
  ///
  const RandomFox({super.key});
  @override
  State<StatefulWidget> createState() => _RandomFoxState();
}

class _RandomFoxState extends ImageAPIStateX<RandomFox> {
  _RandomFoxState()
      : super(
          controller: FoxController(),
          uri: Uri(
            scheme: 'https',
            host: 'randomfox.ca',
            path: 'floof',
          ),
          message: 'image',
        );

  /// Place a breakpoint and see the process
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);
}
