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
import 'package:ffi/ffi.dart';
import 'package:flutter_libraw/flutter_libraw.dart';
import 'dart:io';

void main() async {
  File rawFile = File('test/samples/RAW_CANON_5D_ARGB.CR2');
  File thumbnailFile = File('thumbnail.jpg');
  String fileName = determineLibraryName();
  File libFile = File('libraw/$fileName');
  bool loaded = await loadLibRaw(libFile);

  if (loaded) {
    Pointer<libraw_data_t> ptr = flutterLibRawBindings.libraw_init(0);
    int result = flutterLibRawBindings.libraw_open_file(
        ptr, rawFile.absolute.path.toNativeUtf8().cast());
    if (result != 0) {
      print('Failed to open raw file: $rawFile');
    } else {
      print(arrayToString(ptr.ref.idata.make));
      print(arrayToString(ptr.ref.idata.model));

      flutterLibRawBindings.libraw_unpack_thumb(ptr);
      await thumbnailFile.writeAsBytes(pointerToUint8List(
          ptr.ref.thumbnail.thumb, ptr.ref.thumbnail.tlength));

      flutterLibRawBindings.libraw_close(ptr);
    }
  } else {
    print('Failed to load libraw library');
  }
}
