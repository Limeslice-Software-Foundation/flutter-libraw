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

import 'package:flutter_libraw/flutter_libraw.dart';
import 'package:test/test.dart';

void main() {
  bool loaded = false;
  late Pointer<libraw_data_t> ptr;

  setUpAll(() async {
    String fileName = determineLibraryName();
    File libFile = File('libraw/$fileName');
    loaded = await loadLibRaw(libFile);
  });

  setUp(() {
    ptr = flutterLibRawBindings.libraw_init(0);
  });

  tearDown(() {
    flutterLibRawBindings.libraw_close(ptr);
  });

  Future<void> loadFileAndCheck(
      File rawFile,
      String make,
      String model,
      String normalizedMake,
      String normalizedModel,
      int makerIndex,
      String software,
      int rawCount,
      int isFoveon,
      int dngVersion,
      int colors,
      String cdesc) async {
    if (loaded) {
      int result = flutterLibRawBindings.libraw_open_file(
          ptr, rawFile.absolute.path.toNativeUtf8().cast());
      if (result != 0) {
        print('Failed to open raw file: $rawFile');
      } else {
        expect(arrayToString(ptr.ref.idata.make), equals(make));
        expect(arrayToString(ptr.ref.idata.model), equals(model));
        expect(arrayToString(ptr.ref.idata.normalized_make),
            equals(normalizedMake));
        expect(arrayToString(ptr.ref.idata.normalized_model),
            equals(normalizedModel));
        expect(ptr.ref.idata.maker_index, equals(makerIndex));
        expect(arrayToString(ptr.ref.idata.software), equals(software));
        expect(ptr.ref.idata.raw_count, equals(rawCount));
        expect(ptr.ref.idata.is_foveon, equals(isFoveon));
        expect(ptr.ref.idata.dng_version, equals(dngVersion));
        expect(ptr.ref.idata.colors, equals(colors));
        expect(arrayToString(ptr.ref.idata.cdesc), equals(cdesc));
      }
    } else {
      print('Failed to load libraw library');
    }
  }

  test('Test Canon 5D raw file', () async {
    await loadFileAndCheck(File("test/samples/RAW_CANON_5D_ARGB.CR2"), "Canon",
        "EOS 5D", "Canon", "EOS 5D", 8, "", 1, 0, 0, 3, "RGBG");
  });

  test('Test Fuji raw file', () async {
    await loadFileAndCheck(
        File("test/samples/RAW_FUJI_S5600S5200.RAF"),
        "Fujifilm",
        "S5600",
        "Fujifilm",
        "S5200",
        18,
        "Digital Camera FinePix S5600   Ver1.00",
        1,
        0,
        0,
        3,
        "RGBG");
  });

  test('Test Nikon D5000 raw file', () async {
    await loadFileAndCheck(
        File("test/samples/RAW_NIKON_D5000.NEF"),
        "Nikon",
        "D5000",
        "Nikon",
        "D5000",
        43,
        "Nikon Transfer 1.4 W",
        1,
        0,
        0,
        3,
        "RGBG");
  });

  test('Test Olympus EM10 raw file', () async {
    await loadFileAndCheck(
        File("test/samples/RAW_OLYMPUS_E-M10MARKII.ORF"),
        "Olympus",
        "E-M10MarkII",
        "Olympus",
        "E-M10 Mark II",
        45,
        "Version 1.0                    ",
        1,
        0,
        0,
        3,
        "RGBG");
  });

  test('Test Sony raw file', () async {
    await loadFileAndCheck(
        File("test/samples/RAW_SONY_RX100.ARW"),
        "Sony",
        "DSC-RX100",
        "Sony",
        "DSC-RX100",
        63,
        "DSC-RX100 v1.00",
        1,
        0,
        0,
        3,
        "RGBG");
  });
}
