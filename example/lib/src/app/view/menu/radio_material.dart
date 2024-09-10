//
import 'package:fluttery_framework/view/utils/radiobutton_widget.dart';

import '/src/view.dart';

///
class MaterialVersion extends RadioButtons<bool> {
  ///
  const MaterialVersion({
    super.key,
    required super.controller,
    super.inChanged,
  });

  @override
  Widget radioButtons(BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Material Ver.'.tr),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Radio(
                  value: false,
                  groupValue: controller.groupValue,
                  onChanged: controller.onChanged,
                ),
                const Text('2'),
                Radio(
                  value: true,
                  groupValue: controller.groupValue,
                  onChanged: controller.onChanged,
                ),
                const Text('3'),
              ],
            ),
          ]);
}

/// Supplies the initial value and callbacks when a new selection
class MaterialController extends RadioButtonsController<bool> {
  factory MaterialController() => _this ??= MaterialController._();
  MaterialController._();
  static MaterialController? _this;

  //
  @override
  Future<bool> initAsync() async {
    App.themeData =
        ThemeData.fallback(useMaterial3: Prefs.getBool('material3', false));
    return true;
  }

  //
  @override
  void initState() {
    super.initState();

    initValue = Prefs.getBool('material3', false);

    final useMaterial3 = App.themeData?.useMaterial3 ?? false;

    if (useMaterial3) {
      // Record the 'Material3' version
      theme03Data ??= App.themeData;

      theme02Data ??= ThemeData.fallback(useMaterial3: false);

      if (initValue) {
        // Set Material3 setting to false
        initValue = true;
        Prefs.setBool('material3', true);
      }
    } else {
      // Record the 'Material2' version
      theme02Data ??= App.themeData;

      theme03Data ??= ThemeData.fallback(useMaterial3: true);

      if (initValue) {
        // Set Material3 setting to false
        initValue = false;
        Prefs.setBool('material3', false);
      }
    }
    // The radio buttons group value
    groupValue = initValue;
  }

  bool initValue = false;

  static ThemeData? theme03Data; // Material3
  static ThemeData? theme02Data; // Material2

  @override
  // void deactivate() {
  void onChanged(bool? v) {
    super.onChanged(v);
    //
    final value = groupValue ?? false;

    if (value != initValue) {
      //
      Prefs.setBool('material3', value);

      if (!value) {
        if (theme02Data != null) {
          App.themeData = theme02Data;
          App.setState(() {}); // Update app
        }
      } else {
        //
        final context = App.context;

        if (context != null) {
          // Turn off any custom color setting
          Prefs.setInt('primaryIndex', -1);

          // Record the 'Material3' version
          if (theme03Data != null) {
            App.themeData = theme03Data;
          } else {
            App.themeData = ThemeData.light(useMaterial3: true);
          }
          App.setState(() {}); // Update app
        }
      }
    }
  }
}
