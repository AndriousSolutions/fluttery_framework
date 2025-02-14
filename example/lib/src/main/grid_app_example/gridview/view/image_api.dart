library;

///
///  Manages the API request for specifically 'image' public API's
///

import '/src/controller.dart';

import '/src/view.dart';

/// The State object allows for a web service to be called.
class ImageAPIStateX<T extends StatefulWidget> extends StateX<T>
    implements ImageAPIState {
  ///
  ImageAPIStateX({
    required this.uri,
    this.message,
    required super.controller,
  }) : super(runAsync: true) {
    // run initAsync() every time!
    //
    final id = add(ImageAPIController(controller as InheritController));
    // Retrieves the Controller by its unique id.
    _con = controllerById(id) as ImageAPIController;
  }

  ///
  @override
  final Uri? uri;

  ///
  @override
  final String? message;

  late ImageAPIController _con;

  /// Place a breakpoint and see the process
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  Widget buildAndroid(context) {
    controller?.dependOnInheritedWidget(context);
    return GestureDetector(
      onTap: _con.onTap,
      onDoubleTap: _con.onTap,
      child: Card(child: _con.image ?? const SizedBox()),
    );
  }

  /// Currently not providing an 'iOS' version of the interface.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);

  /// Call initAsync() all the time if returns true.
  /// Conditional calls initAsync() creating a Future with every rebuild
  @override
  bool runInitAsync() => _con.runInitAsync();

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  @override
  bool onAsyncError(FlutterErrorDetails details) => false;
}

///
abstract class ImageAPIState {
  ///
  ImageAPIState({required this.uri, required this.message});

  ///
  final Uri? uri;

  ///
  final String? message;
}
