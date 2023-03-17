/// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  11 Dec 2021
///
///

import 'package:fluttery_framework/controller.dart';
import 'package:fluttery_framework/view.dart';

// ignore: avoid_classes_with_only_static_members
/// Builds a [InheritedWidget].
///
/// It's instantiated in a standalone widget
/// so its setState() call will **only** rebuild
/// [InheritedWidget] and consequently any of its dependents,
/// instead of rebuilding the app's entire widget tree.
class InheritedStates {
  //
  static final Map<Type, _InheritedStateWidget> _states = {};

  /// Returns an Object containing InheritedWidget and its build function
  static InheritedStateWidget add(InheritedWidget? Function() func,
          {Key? key}) =>
      InheritedStateWidget(func, key: key);

  /// Link a widget to an InheritedWidget of type T
  static bool inheritWidget<T extends InheritedWidget>(BuildContext context,
          {Object? aspect}) =>
      context.dependOnInheritedWidgetOfExactType<T>(aspect: aspect) != null;

  /// If the widget has been mounted with its State object
  static bool has<T extends InheritedWidget>() => _states.containsKey(T);

  /// Calls the build() function in this Widget's State object.
  static void rebuild<T extends InheritedWidget>() {
    //
    final inheritedWidget = _states[_type<T>()];

    inheritedWidget?.setState(() {});
  }
}

/// Explicitly returns a Type
Type _type<U>() => U;

/// Provides the build() function to be rebuilt
class InheritedStateWidget extends StatefulWidget {
  /// Supply a Callback function returning an InheritedWidget
  InheritedStateWidget(this._func, {Key? key}) : super(key: key);
  final InheritedWidget? Function() _func;

  // Retains a reference to its State object
  final Set<_InheritedStateWidget> _state = {_InheritedStateWidget()};

  @override
  //ignore: no_logic_in_create_state
  State createState() => _state.first;

  /// Calls the build() function in this Widget's State object.
  void rebuild() => _state.first.setState(() {});
}

class _InheritedStateWidget extends State<InheritedStateWidget> {
  @override
  void initState() {
    super.initState();
    // Record this State object for later reference.
    final InheritedWidget? inheritedWidget = widget._func();
    if (inheritedWidget != null) {
      _type = inheritedWidget.runtimeType;
      InheritedStates._states[_type] = this;
    }
  }

  /// Record the runtimeType of the InheritedWidget
  late Type _type;

  /// Supply a reference to this State object back to its Widget
  @override
  void didChangeDependencies() {
    widget._state.add(this);
    super.didChangeDependencies();
  }

  /// Remove the reference
  @override
  void dispose() {
    // Any reference to this State object should be removed.
    InheritedStates._states.remove(_type);
    widget._state.clear();
    super.dispose();
  }

  /// If its widget is re-created update the its State Set.
  @override
  void didUpdateWidget(covariant InheritedStateWidget oldWidget) {
    // Don't want a memory leak
    oldWidget._state.clear();

    widget._state.add(this);

    super.didUpdateWidget(oldWidget);
  }

  /// Don't if the widget is not in the widget tree.
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) => widget._func() ?? const SizedBox();
}
