// ignore_for_file: dead_code
//
import 'package:fluttery_framework/view/utils/radiobutton_widget.dart';

import '/src/controller.dart';

import '/src/view.dart';

///
class MaterialVersionRadioButtons extends RadioButtons<bool> {
  ///
  MaterialVersionRadioButtons({
    super.key,
    super.inChanged,
  }) : super(controller: MaterialController());

  @override
  Widget radioButtons(BuildContext context) {
    final radios = radioButtonsBuilder<bool>(
      {'3': true, '2': false},
      controller,
      mainAxisSize: MainAxisSize.min,
    );
    final List<Widget> widgets = [Text('Material Ver.'.tr)];
    widgets.addAll(radios);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
    return Row(
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
}

/// Supplies the initial value and callbacks when a new selection
class MaterialController extends RadioButtonsController<bool> {
  ///
  factory MaterialController() => _this ??= MaterialController._();
  MaterialController._();
  static MaterialController? _this;

  ///
  static ThemeData? get theme03Data => _theme03Data;
  static ThemeData? _theme03Data; // Material3

  ///
  static ThemeData? get theme02Data => _theme02Data;
  static ThemeData? _theme02Data; // Material2

  //
  @override
  Future<bool> initAsync() async {
    App.themeData ??=
        ThemeData.fallback();
    //    ThemeData.fallback(useMaterial3: Prefs.getBool('material3', false));
    return true;
  }

  //
  @override
  void initState() {
    super.initState();

    var initUseMaterial3 = Prefs.getBool('material3', false);

    final useMaterial3 = App.themeData?.useMaterial3 ?? false;

    if (useMaterial3) {
      // Record the 'Material3' version
      _theme03Data ??= App.themeData;

      _theme02Data ??= ThemeData.fallback(useMaterial3: false);

      if (!initUseMaterial3) {
        // Set Material3 setting to true
        initUseMaterial3 = true;
        Prefs.setBool('material3', true);
      }
    } else {
      // Record the 'Material2' version
      _theme02Data ??= App.themeData;

      _theme03Data ??= ThemeData.fallback(useMaterial3: true);

      if (initUseMaterial3) {
        // Set Material3 setting to false
        initUseMaterial3 = false;
        Prefs.setBool('material3', false);
      }
    }
    // The radio buttons group value
    groupValue = initUseMaterial3;
  }

  @override
  void onChanged(bool? v) {
  super.onChanged(v);
    //
    final value = groupValue ?? false;

    Prefs.setBool('material3', value);

    if (!value) {
      App.themeData = theme02Data;
    } else {
      // Turn off any custom color setting
      Prefs.setInt('primaryIndex', -1);
      // Record the 'Material3' version
      if (theme03Data != null) {
        App.themeData = theme03Data;
      } else {
        App.themeData = ThemeData.light(useMaterial3: true);
      }
    }
    App.setState(() {}); // Update app
  }
}
