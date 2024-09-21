// Licensed to the Limeslice Software Foundation (LSF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The LSF licenses this file to You under the MIT License (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://limeslice.org/license.txt
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'dart:ffi';
import 'dart:io';
import 'package:flutter_libraw/flutter_libraw.dart';

/// The name of the library file to load.
const String _libName = 'libraw';

/// A reference to the bindings.
late FlutterLibRawBindings flutterLibRawBindings;

/// Determine the library name based on the current platform.
String determineLibraryName() {
  if (Platform.isMacOS || Platform.isIOS) {
    return '$_libName.dylib';
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return '$_libName.so';
  }
  if (Platform.isWindows) {
    return '$_libName.dll';
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}

/// Load the dynamic library from the given file. Returns true if successful,
/// false otherwise
Future<bool> loadLibRaw(File file) async {
  try {
    flutterLibRawBindings =
        FlutterLibRawBindings(DynamicLibrary.open(file.path));
    return true;
  } catch (err) {
    return false;
  }
}
