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
import 'package:ffi/ffi.dart';

import 'libraw_bindings_generated.dart';
import 'src/idata.dart';
import 'src/libraw_data.dart';
import 'src/libraw_exception.dart';

const String _libName = 'libraw';
String libraryPath = 'bin';

/// The dynamic library in which the symbols for [FfigenAppBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open(
        '$libraryPath${Platform.pathSeparator}$_libName.dylib');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open(
        '$libraryPath${Platform.pathSeparator}$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open(
        '$libraryPath${Platform.pathSeparator}$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final FlutterLibRawBindings _bindings = FlutterLibRawBindings(_dylib);

class RawFile implements Finalizable {
  //static final _finalizer = NativeFinalizer(_bindings.libraw_close());
  final Pointer<libraw_data_t> _librawData;
  final File file;
  late LibRawData data;

  RawFile._(this._librawData, this.file);

  static Future<RawFile> open(File rawFile) async {
    Pointer<libraw_data_t> ptr = _bindings.libraw_init(0);
    RawFile file = RawFile._(ptr, rawFile);
    int result = _bindings.libraw_open_file(
        ptr, rawFile.absolute.path.toNativeUtf8().cast());
    if (result != 0) {
      LibRawException('Failed to open file $result');
    }
    await file._loadAllData();
    return file;
  }

  void close() {
    _bindings.libraw_close(_librawData);
  }

  Future<void> _loadAllData() async {
    IData iData = await _loadIData();
    data = LibRawData(idata: iData);
  }

  Future<IData> _loadIData() async {
    return IData(
        cdesc: _convertToString(_librawData.ref.idata.cdesc),
        colors: _librawData.ref.idata.colors,
        dngVersion: _librawData.ref.idata.dng_version,
        filters: _librawData.ref.idata.filters,
        isFoveon: _librawData.ref.idata.is_foveon,
        make: _convertToString(_librawData.ref.idata.make),
        makerIndex: _librawData.ref.idata.maker_index,
        model: _convertToString(_librawData.ref.idata.model),
        normalizedMake: _convertToString(_librawData.ref.idata.normalized_make),
        normalizedModel:
            _convertToString(_librawData.ref.idata.normalized_model),
        rawCount: _librawData.ref.idata.raw_count,
        software: _convertToString(_librawData.ref.idata.software));
  }

  String _convertToString(Array<Uint8> arr) {
    final dartString = <int>[];
    for (var i = 0; i < 256; i++) {
      final char = arr[i];
      if (char == 0) break;
      dartString.add(char);
    }
    return String.fromCharCodes(dartString);
  }
}
