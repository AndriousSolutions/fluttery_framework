//
import 'package:fluttery_framework_example/src/controller.dart';

import 'package:fluttery_framework_example/src/model.dart';

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import 'package:fluttery_framework_example/src/view.dart';

class WordPairsController extends StateXController {
  factory WordPairsController([StateX? state]) =>
      _this ??= WordPairsController._(state);
  WordPairsController._(StateX? state)
      : timer = WordPairsTimer(seconds: 2),
        model = WordPairsModel(),
        super(state);
  static WordPairsController? _this;
  final WordPairsTimer timer;
  final WordPairsModel model;

  @override
  void initState() {
    super.initState();
    model.addState(state);
  }

  /// Start up the timer.
  void initTimer() => timer.initTimer();

  /// Cancel the timer
  void cancelTimer() => timer.timer?.cancel();

  Widget get wordPair => timer.wordPair;

  void build(int i) => model.build(i);

  String get data => model.data;

  Widget get trailing => model.trailing;

  void onTap(int i) => model.onTap(i);

  Iterable<Widget> tiles() => model.tiles();
}
