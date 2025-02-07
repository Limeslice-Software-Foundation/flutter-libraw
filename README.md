# Flutter LibRaw

The Flutter LibRaw package aims to provide the ability to read camera RAW files to Dart/Flutter applications. 

This package is a wrapper around the C/C++ [LibRaw](https://www.libraw.org/) library using [Dart FFI](https://dart.dev/interop/c-interop).

Note that this project is still in its early stages and so may not yet provide complete/full functionality. We will be building up functionality over the next few months through numerous small iterative releases.

## Table of Contents
- [Flutter LibRaw](#flutter-libraw)
  - [Table of Contents](#table-of-contents)
  - [About The Project](#about-the-project)
    - [Features](#features)
  - [Getting Started](#getting-started)
    - [Installation](#installation)
    - [Import Package](#import-package)
    - [Basic Usage](#basic-usage)
  - [Usage](#usage)
  - [Roadmap](#roadmap)
  - [Contributing](#contributing)
  - [License](#license)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)
  - [Limitation of Liability](#limitation-of-liability)

## About The Project

The Flutter LibRaw library provides a simple and unified interface for extracting the following out of RAW files generated by digital photo cameras:
- RAW data (pixel values)
- Metadata necessary for processing RAW (geometry, CFA / Bayer pattern, black level, white balance, etc.)
- Embedded preview / thumbnail.

The library is intended for use with programs that work with RAW files, such as:
- RAW viewers
- RAW converters
- RAW data analyzers

Using the Flutter LibRaw library allows one to focus on the substantive part of processing the data contained in RAW files, without getting distracted by the wide variety of RAW file and metadata formats, compression algorithms, etc.

### Features
- Support for RAW files from a wide variety of cameras.

## Getting Started

Add the package as a dependency.

### Installation
Add the package to your dependencies.

```
pub add flutter_libraw
```

### Import Package

Import the library in your code.

```Dart
import 'package:flutter_libraw/flutter_libraw.dart';
```

### Basic Usage

1. Load the library.
```Dart
String fileName = determineLibraryName();
File libFile = File('libraw/$fileName');
bool loaded = await loadLibRaw(libFile);
```

2. Initialise libraw.
```Dart
Pointer<libraw_data_t> ptr = flutterLibRawBindings.libraw_init(0);
```

3. Open RAW file
```Dart
File rawFile = File('test/samples/RAW_CANON_5D_ARGB.CR2');
int result = flutterLibRawBindings.libraw_open_file(
        ptr, rawFile.absolute.path.toNativeUtf8().cast());
```

4. Check result
```Dart
if (result != 0) {
  print('Failed to open raw file: $rawFile');
} else {
  // Access image data here...
}
```

5. Access image meta data
```Dart
print(arrayToString(ptr.ref.idata.make));
print(arrayToString(ptr.ref.idata.model));
```

6. Unpack the thumbnail image
```Dart
File thumbnailFile = File('thumbnail.jpg');
flutterLibRawBindings.libraw_unpack_thumb(ptr);
await thumbnailFile.writeAsBytes(pointerToUint8List(
    ptr.ref.thumbnail.thumb, ptr.ref.thumbnail.tlength));
```

7. Finally close the pointer - this releases resources and frees memory, failure to do this will result in memory leaks in your application.
```Dart
flutterLibRawBindings.libraw_close(ptr);
```

## Usage
See the [User Guide](doc/user-guide.md) for detailed information.

## Roadmap

See the [open issues](https://github.com/Limeslice-Software-Foundation/flutter-libraw/issues) for a full list of proposed features (and known issues).

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Limeslice Software Foundation [https://limeslice.org](https://limeslice.org)


## Acknowledgments

We would like to thank the authors of the LibRaw package which provided the basis for this package. 

The LibRaw package is copyright (C) 2008-2024 LibRaw LLC

LibRaw uses code from Dave Coffin’s dcraw.c utility (without RESTRICTED/GPL2 code):

Copyright 1997-2018 by Dave Coffin, dcoffin a cybercom o net
LibRaw uses DCB demosaic code by Jaceck Gozdz distributed under BSD license:

Copyright (C) 2010, Jacek Gozdz (cuniek@kft.umcs.lublin.pl)
LibRaw uses Roland Karlsson’s X3F tools source code, licensed under BSD license:

Copyright (c) 2010, Roland Karlsson (roland@proxel.se)

## Limitation of Liability

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.