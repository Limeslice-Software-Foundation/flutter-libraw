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
import 'dart:typed_data';

/// Convenience method to convert an int array to a Dart String.
String arrayToString(Array<Uint8> arr) {
  final dartString = <int>[];
  for (var i = 0; i < 256; i++) {
    final char = arr[i];
    if (char == 0) break;
    dartString.add(char);
  }
  return String.fromCharCodes(dartString);
}

/// Convenience method to convert a int pointer to a Uint8List. You need to
/// know the length of the data and pass that in as a parameter.
Uint8List pointerToUint8List(Pointer<Uint8> data, int length) {
  return data.asTypedList(length);
}
