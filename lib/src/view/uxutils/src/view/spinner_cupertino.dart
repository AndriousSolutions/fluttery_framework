/// Copyright 2024 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
import '/view.dart';

import 'package:flutter/gestures.dart' show PointerDeviceKind;

/// A Spinner using the Cupertino style spin picker
/// By design, gestures are turned off on browser screens
class SpinnerCupertino<T> extends StatefulWidget {
  /// Supply the values and Item Changed Routine.
  /// The datatype of those values is determined, and if not determined,
  /// will rely on the passed itemBuilder to produce the List of spinner items.
  SpinnerCupertino({
    super.key,
    required this.initValue,
    required this.values,
    this.itemBuilder,
    this.onSelectedItemChanged,
  }) : assert(
          values.isNotEmpty ||
              values.where((T item) {
                    return item == initValue;
                  }).length ==
                  1,
          'There should be exactly one item listed with the value: '
          '$initValue. \n'
          'Either zero or 2 or more values were detected '
          'with the same value',
        );

  /// The 'current' value.
  final T initValue;

  /// The List of values.
  final List<T> values;

  /// Optionally supply a builder
  final NullableIndexedWidgetBuilder? itemBuilder;

  /// The selected value
  T? get value => _selected.isNotEmpty ? _selected.first : null;
  final List<T?> _selected = [null];

  /// The routine called when a new Locale is selected.
  final void Function(int index)? onSelectedItemChanged;

  @override
  State createState() => _SpinnerCupertinoState<T>();
}

class _SpinnerCupertinoState<T> extends State<SpinnerCupertino<T>> {
  @override
  void initState() {
    super.initState();

    values = widget.values;

    //
    final item = widget.initValue;

    if (item is String) {
      type = 'String';
    } else if (item is num) {
      type = 'num';
    } else if (item is bool) {
      type = 'bool';
    } else if (item is Widget) {
      type = 'Widget';
    } else if (item is Object) {
      type = 'Object';
    } else {
      type = '';
    }

    index = values.indexOf(widget.initValue);

    if (index == null || index! < 0) {
      index = 0;
    }

    itemBuilder = widget.itemBuilder;

    assert(
        (itemBuilder == null && type.isNotEmpty && type != 'Object') ||
            (itemBuilder != null && (type.isEmpty || type == 'Object')),
        "There should be an 'itemBuilder' if the 'List of values is \r\n ${type.isNotEmpty ? 'of type Object.' : 'undetermined.'}");
  }

  /// The List of values.
  late List<T> values;
  late String type;
  int? index;
  NullableIndexedWidgetBuilder? itemBuilder;

  @override
  void didUpdateWidget(oldWidget) {
    widget._selected[0] = oldWidget._selected.first;
    oldWidget._selected.clear();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget widget = CupertinoPicker.builder(
      itemExtent: 25, //height of each item
      childCount: values.length,
      scrollController: FixedExtentScrollController(initialItem: index!),
      onSelectedItemChanged: (index) {
        T? value;
        if (index > 0 && index < values.length) {
          value = values[index];
        }
        this.widget._selected[0] = value;
        // If an 'onChange' routine was passed.
        this.widget.onSelectedItemChanged?.call(index);
      },
      itemBuilder: (BuildContext context, int index) {
        Widget widget;
        try {
          widget = _itemBuilder(context, index);
        } catch (e) {
          widget = const SizedBox();
        }
        return widget;
      },
    );

    // By design, gestures are turned off on browser screens
    if (UniversalPlatform.isWeb && !App.inSmallScreen) {
      //
      widget = ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: widget,
      );
    }

    return SizedBox(
      height: 100,
      child: widget,
    );
  }

  /// Supply a widget for the picker
  Widget _itemBuilder(BuildContext context, int index) {
    //
    Widget? widget = itemBuilder?.call(context, index);

    if (widget == null) {
      //
      final dynamic item = values[index];

      switch (type) {
        case 'String':
          widget = Text(item.trim(), style: const TextStyle(fontSize: 20));
          break;
        case 'num':
          widget = Text('$item', style: const TextStyle(fontSize: 20));
          break;
        case 'bool':
          widget = Text(
            item ? 'true' : 'false',
            style: const TextStyle(fontSize: 20),
          );
          break;
        case 'Widget':
          widget = item;
          break;
        case 'Object':
        default:
          widget = const SizedBox();
      }
    }
    return widget!;
  }
}
