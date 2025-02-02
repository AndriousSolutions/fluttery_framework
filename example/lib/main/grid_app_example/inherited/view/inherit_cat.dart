library;

///
///  Stores the InheritedWidget used to update the Cat images.
///

import '/src/controller.dart';

import '/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritCat extends StatefulWidget {
  ///
  const InheritCat({super.key, required this.child});

  ///
  final Widget? child;
  @override
  State<StatefulWidget> createState() => _InheritCatState();
}

/// Supply an InheritedWidget to a StateX object: InheritedStateX
class _InheritCatState extends StateX<InheritCat> {
  _InheritCatState() : super(controller: CatController(), useInherited: true);

  /// Use buildIn() or builder() instead of build() to call the built-in InheritedWidget
  @override
  Widget builder(BuildContext context) => widget.child!;
}
