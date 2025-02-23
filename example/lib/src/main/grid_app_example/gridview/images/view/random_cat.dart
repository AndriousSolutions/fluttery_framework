library;

///
///  This widget works with the free Cat API.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomCat extends StatefulWidget {
  ///
  const RandomCat({super.key});
  @override
  State<StatefulWidget> createState() => _RandomCatState();
}

class _RandomCatState extends ImageAPIStateX<RandomCat> {
  _RandomCatState()
      : super(
          controller: CatController(),
          message: 'message',
          uri: Uri(
            scheme: 'https',
            host: 'api.sefinek.net',
            path: 'api/v2/random/animal/cat',
          ),
        );

  /// Supply a 'splash screen' while the FutureBuilder is processing.
  @override
  Widget? onSplashScreen(BuildContext context) =>
      App.inFlutterTest ? null : const SplashScreen();
}
