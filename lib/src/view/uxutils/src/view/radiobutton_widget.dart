import 'package:fluttery_framework/controller.dart';

///
import 'package:fluttery_framework/view.dart';

///
abstract class RadioButtons<T> extends StatefulWidget {
  ///
  const RadioButtons({super.key, required this.controller, this.inChanged});

  /// The controller that
  final RadioButtonsController<T> controller;

  /// Optional method called when radio button is changed
  final void Function(T v)? inChanged;

  /// Compose the radio widgets in this function.
  Widget radioButtons(BuildContext context);

  /// Optional function called when radio button is changed
  void onChanged(T v) {}

  @override
  State createState() => _RadioButtonsState<T>();
}

///
class _RadioButtonsState<T> extends StateX<RadioButtons<T>> {
  @override
  void initState() {
    add(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.radioButtons(context);
}

///
class RadioButtonsController<T> extends StateXController {
  /// Supply the initial value of the Radio buttons
  RadioButtonsController({this.initialValue}) {
    groupValue = initialValue;
  }

  /// The radio button initial selected
  final T? initialValue;

  ///
  T? groupValue;

  /// Determine if changed from the initial value
  bool get isChanged => groupValue != initialValue;

  @override
  void initState() {
    super.initState();
    final widget = state?.widget;
    if (widget != null && widget is RadioButtons<T>) {
      statefulWidget = widget;
    }
  }

  /// The StatefulWidget used.
  RadioButtons<T>? statefulWidget;

  /// Called when a button is changed.
  @mustCallSuper
  void onChanged(T? v) {
    if (v != null) {
      groupValue = v;
      statefulWidget?.inChanged?.call(v);
      statefulWidget?.onChanged(v);
      state?.setState(() {});
    }
  }
}
