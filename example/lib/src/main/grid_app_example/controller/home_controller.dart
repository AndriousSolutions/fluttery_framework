library;

///
///  The Controller for this app's Home Page StatefulWidget.
///

import '/src/controller.dart';

import '/src/view.dart';

///
class HomeController extends StateXController {
  ///
  factory HomeController() => _this ??= HomeController._();
  HomeController._() : super();
  static HomeController? _this;

  /// The List of Widgets
  List<Widget> get children => _imageList();

  List<Widget> _imageList() {
    // Default number is assigned if one is not provided.
    final List<Widget> images = [];
    final animals = [1, 2, 3, 4];

    int cnt = 0;
    int dog = 0;
    int cat = 0;
    int fox = 0;
    int bird = 0;

    const number = 12;
    const limit = 3;

    while (cnt < number) {
      // Shuffle the elements
      animals.shuffle();
      switch (animals[0]) {
        case 1:
          if (dog == limit) {
            // try again.
            continue;
          } else {
            dog++;
            images.add(RandomDog(key: Key('dog$dog')));
          }
          break;
        case 2:
          if (cat == limit) {
            // try again.
            continue;
          } else {
            cat++;
            images.add(RandomCat(key: Key('cat$cat')));
          }
          break;
        case 3:
          if (fox == limit) {
            // try again.
            continue;
          } else {
            fox++;
            images.add(RandomFox(key: Key('fox$fox')));
          }
          break;
        case 4:
          if (bird == limit) {
            // try again.
            continue;
          } else {
            bird++;
            images.add(RandomBird(key: Key('bird$bird')));
          }
          break;
      }
      cnt++;
    }
    return images;
  }

  ///
  void newBirds() => BirdController().newAnimals();

  ///
  void newCats() => CatController().newAnimals();

  ///
  void newDogs() => DogController().newAnimals();

  ///
  void newFoxes() => FoxController().newAnimals();
}
