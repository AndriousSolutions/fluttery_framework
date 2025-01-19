// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  25 Dec 2018
//
//

// Material
export 'package:flutter/material.dart' hide runApp;

// Cupertino
export 'package:flutter/cupertino.dart' hide RefreshCallback, runApp;

// Assets
export 'model/assets.dart';

// file utils              // Can't do this. Allow even if kIsWeb
export 'model/files.dart'; // if (dart.library.html) 'model/assets.dart';

// Install file                   // Can't do this. Allow even if kIsWeb
export 'model/installfile.dart'; // if (dart.library.html) 'model/assets.dart';

// Hash codes
export 'model/hash.dart';

// Preferences
export 'package:prefs/prefs.dart' show Prefs;
