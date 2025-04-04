library;

//
import '/src/controller.dart';

/// This SOC is associated with the Bird images and works with
/// InheritBird StatefulWidget and the InheritedWidget, _BirdInherited
class BirdController extends InheritController {
  ///
  factory BirdController() => _this ??= BirdController._();
  BirdController._();
  static BirdController? _this;

  /// Unnecessary override, but here for demonstration purposes
  @override
  bool dependOnInheritedWidget(BuildContext? context) =>
      super.dependOnInheritedWidget(context);

  /// Unnecessary override, but here for demonstration purposes
  @override
  void newAnimals() => super.newAnimals();
}
