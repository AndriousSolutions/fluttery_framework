library;

///
///  This widget works with the free Bird API.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomBird extends StatefulWidget {
  ///
  const RandomBird({super.key});
  @override
  State<StatefulWidget> createState() => _RandomBirdState();
}

class _RandomBirdState extends ImageAPIStateX<RandomBird> {
  _RandomBirdState()
      : super(
          controller: BirdController(),
          message: 'message',
          uri: Uri(
            scheme: 'https',
            host: 'api.sefinek.net',
            path: 'api/v2/random/animal/bird',
          ),
        );
}
