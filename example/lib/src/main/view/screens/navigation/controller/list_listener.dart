//
import '/src/controller.dart';

import '/src/view.dart';


///
class ListListener {
  ///
  ListListener({double? offset, this.callback}) {
    //
    _scrollController = ScrollController(
      initialScrollOffset: offset ?? 0,
      onAttach: onAttach,
      onDetach: onDetach,
    );
  }

  ///
  ScrollController? get scrollController => _scrollController;
  ScrollController? _scrollController;

  /// Supply the means to record current offset
  final void Function(double offSet)? callback;

  //
  ScrollPosition? _listPosition;

  ///
  void onAttach(ScrollPosition position) {
    _listPosition = position;
    _listPosition?.addListener(listListener);
  }

  ///
  void onDetach(ScrollPosition position) {
    _listPosition?.removeListener(listListener);
    _scrollController?.dispose();
    _listPosition = null;
    _scrollController = null;
  }

  ///
  void listListener() => callback?.call(_listPosition?.pixels ?? 0);
}