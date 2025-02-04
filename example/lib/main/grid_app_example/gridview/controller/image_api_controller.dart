library;

///
///  The 'Image' State Object Controller.
///

import 'dart:async';

import 'dart:convert' show json;

import '/src/controller.dart';

import '/src/view.dart';

import 'package:http/http.dart' as http;

/// This is the 'image API' State Object Controller.
class ImageAPIController extends StateXController  {
  /// No factory constructor and so multiple instances of this class is possible.
  ImageAPIController(InheritController controller){
    controller.addImageController(this);
  }

  /// The List of data returned by the API.
  List<String> _data = [];

  /// The resulting image from the API.
  Image? image;

  ///
  void onTap() {
    _runInitAsync = true;
    state?.setState(() {});
  }

  /// The number of images loading using this class.
  static int imageCount = 0;

  /// The number of images currently loading
  static int loadingCount = 0;

  /// Contains all the asynchronous operations that must complete before proceeding.
  @override
  Future<bool> initAsync() async {
    bool init;
    try {
      init = await _loadImage();
    } catch (e) {
      init = false;
    }
    return init;
  }

  /// Load the image to
  Future<bool> _loadImage() async {
    // Call the API
    _data = await _getURIData();

    if (_data.isNotEmpty) {
      image = Image.network(_data[0]);
      final imageStream = image!.image.resolve(const ImageConfiguration());
      final completer = Completer<void>();
      imageCount++;
      loadingCount++;
      final listener = ImageStreamListener((ImageInfo info, bool syncCall) {
        // Error if called again and so test if completed.
        if (!completer.isCompleted) {
          completer.complete();
          loadingCount--;
          if (loadingCount == 0) {
            /// All the image(s) have completed loading.
          }
        }
      });
      imageStream.addListener(listener);
      await completer.future;
      // No need anymore. Best to remove in case triggered again.
      imageStream.removeListener(listener);
    }
    return _data.isNotEmpty;
  }

  /// Retrieve the data
  Future<List<String>> _getURIData() async {
    //
    final List<String> data = [];

    // Cast to the abstract class with the two properties.
    final api = state as ImageAPIState;

    final message = api.message;

    final uri = api.uri;

    if (uri != null) {
      //
      final http.Response response = await http.get(uri);

      final jsonResponse = json.decode(response.body);

      dynamic dataItem;

      if (jsonResponse is List) {
        int index;
        if (message == null ||
            message.isEmpty ||
            double.tryParse(message) == null) {
          index = 0;
        } else {
          index = int.parse(message);
          if (index < 0 || index >= jsonResponse.length) {
            index = 0;
          }
        }
        dataItem = jsonResponse[index];
      } else {
        if (message == null || message.isEmpty) {
          dataItem = jsonResponse.entries.first;
        } else {
          dataItem = jsonResponse[message];
        }
      }

      switch (dataItem.runtimeType) {
        // ignore: type_literal_in_constant_pattern
        case List:
          dataItem.forEach(data.add);
          break;
        // ignore: type_literal_in_constant_pattern
        case String:
          data.add(dataItem);
          break;
      }
    }
    return data;
  }

  /// Call initAsync() all the time if returns true.
  /// Conditional calls initAsync() creating a Future with every rebuild
  bool runInitAsync() {
    final run = _runInitAsync;
    _runInitAsync = false;
    return run;
  }

  ///
  bool get runAsyncAgain => _runInitAsync;
  set runAsyncAgain(bool? run){
    if(run != null && run){
      _runInitAsync = run;
    }
  }
  bool _runInitAsync = true;

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  @override
  void onAsyncError(FlutterErrorDetails details) {
    super.onAsyncError(details);
  }
}
