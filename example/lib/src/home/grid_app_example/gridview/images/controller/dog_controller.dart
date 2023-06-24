///
///
///

//
import 'package:fluttery_framework_example/src/controller.dart';

///
class DogController extends InheritController {
  ///
  factory DogController() => _this ??= DogController._();
  DogController._();
  static DogController? _this;

  /// Unnecessary override, but here for demonstration purposes
  @override
  bool dependOnInheritedWidget(BuildContext? context) =>
      super.dependOnInheritedWidget(context);

  /// Unnecessary override, but here for demonstration purposes
  @override
  void newAnimals() => super.newAnimals();
}
