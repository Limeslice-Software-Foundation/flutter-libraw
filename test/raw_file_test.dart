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

import 'dart:convert';
import 'dart:io';

import 'package:flutter_libraw/flutter_libraw.dart';
import 'package:test/test.dart';

void main() {
  late RawFile rawFile;

  setUpAll(() {
    libraryPath = './bin';
  });

  group('Test load raw data', () {
    Future<void> performTest(String filename) async {
      File file = File('test/samples/$filename');
      File jsonFile = File('test/data/$filename.json');
      LibRawData expected =
          LibRawData.fromJson(jsonDecode(jsonFile.readAsStringSync()));

      rawFile = await RawFile.open(file);
      LibRawData actual = rawFile.data;

      expect(expected, equals(actual));
    }

    test('canon file', () async {
      await performTest('RAW_CANON_5D_ARGB.CR2');
    });

    test('fuji file', () async {
      await performTest('RAW_FUJI_S5600S5200.RAF');
    });

    test('nikon file', () async {
      await performTest('RAW_NIKON_D5000.NEF');
    });

    test('olympus file', () async {
      await performTest('RAW_OLYMPUS_E-M10MARKII.ORF');
    });

    test('sony file', () async {
      await performTest('RAW_SONY_RX100.ARW');
    });
  });
}
