# Flutter LibRaw User Guide

## About

This document describes the features of the Flutter LibRaw library; starting with the very basics and up to the more advanced topics. If you read it in a linear way, you should get a sound understanding of the provided API and classes and the possibilities they offer. But you can also skip sections and jump directly to the topics you are most interested in.

## Copyright

LibRaw library, Copyright (C) 2008-2021 LibRaw LLC (info@libraw.org)
The library includes source code from
dcraw.c, Dave Coffin's raw photo decoder
Copyright 1997-2016 by Dave Coffin, dcoffin a cybercom o net

LibRaw is distributed for free under two different licenses:
- GNU Lesser General Public License, version 2.1
- COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0

## Table of Contents

- [Flutter LibRaw User Guide](#llutter-libraw-user-guide)
  - [About](#about)
  - [Copyright](#copyright)
  - [Table of Contents](#table-of-contents)

## Basic Usage Pattern

If you are familiar with the LibRaw C/C++ library then you will be right at home with the Flutter LibRaw library. For the most part, the data structures and API are basically the same with a few exceptions as a result of differences between the C/C++ and Dart languages.

The library makes use of pointers.

### Loading the library

The package has some utility helper methods. <code>determineLibraryName()</code> will return the name of the livrary file based on the platform - <code>libraw.so</code> on Android and Linux, <code>libraw.dll</code> on Windows and <code>libraw.dylib</code> on iOS and MacOS.

Once you have a path to the libray file you can call <code>loadLibRaw()</code> which will return a bool value, <code>true</code> if the library was loaded or <code>false</code> otherwise.

```Dart
String fileName = determineLibraryName();
File libFile = File('libraw/$fileName');
bool loaded = await loadLibRaw(libFile);
```

### Initialize LibRaw

The next step is to initialize a LibRaw processor. This can be done using the <code>flutterLibRawBindings</code> global variable and calling <code>libraw_init</code>. This will return a pointer.

```Dart
Pointer<libraw_data_t> ptr = flutterLibRawBindings.libraw_init(0);
```

### Open the RAW file

You can open a file using the <code>libraw_open_file</code> method on the <code>flutterLibRawBindings</code> global instance variable. This returns an int value, 0 for success and any non 0 value if the call fails.

```Dart
File rawFile = File('test/samples/RAW_CANON_5D_ARGB.CR2');
int result = flutterLibRawBindings.libraw_open_file(
  ptr, rawFile.absolute.path.toNativeUtf8().cast());
if (result != 0) {
  print('Failed to open raw file: $rawFile');
}
```

### Read Camera Make and Model

Once you have opened a file you can use the pointer to reference data attributes like camera make and model as follows.

```Dart
print(arrayToString(ptr.ref.idata.make));
print(arrayToString(ptr.ref.idata.model));
```

### Unpack Thumbnail

In order to access the thumbnail image contained within the RAW file you first need to unpack the data using the <code>libraw_unpack_thumb</code> method.

```Dart
flutterLibRawBindings.libraw_unpack_thumb(ptr);
```

#### Write Thumbnail out to a File

Once the thumbnail data has been unpacked you can write the thumbnail out to a file if you wish to do so. The <code>pointerToUint8List</code> utility function can be used for this purpose, as follows:

```Dart
await thumbnailFile.writeAsBytes(pointerToUint8List(
  ptr.ref.thumbnail.thumb, ptr.ref.thumbnail.tlength));
```

### Close LibRaw

Finally, when you are done with the RAW file you need to close the pointer. This will release any memory used. Failure to do this may result in a memory leak in your application.

```Dart
flutterLibRawBindings.libraw_close(ptr);
```

### Using Assets in Flutter

If you have a flutter application, figuring out a way to bundle the libraw binaries with your application may prove a little tricky. One possible way to do this is to include the files in your assets and then write the library out to the file system.

Here is an example solution reading out the libraw binaries from an assets folder:

```Dart
late FlutterLibRawBindings _bindings;

  Future<bool> loadLibRaw() async {
    try {
      String libraryName = determineLibraryName();
      File file = await _extractLibFile(libraryName);
      _bindings = FlutterLibRawBindings(DynamicLibrary.open(file.path));
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<File> _extractLibFile(String assetName) async {
    Directory toDir = _ensureApplicationDirectory();
    File file = File('${toDir.path}${Platform.pathSeparator}$assetName');
    bool exists = await file.exists();
    if(!exists) {
      ByteData byteData = await rootBundle.load('libraw/$assetName');
      file.writeAsBytes(byteData.buffer.asUint8List());
    }
    return file;
  }

  Directory _ensureApplicationDirectory() {
    Directory home = _getHomeDirectory();
    Directory appDir = Directory('${home.path}${Platform.pathSeparator}$_appDirName');
    appDir.createSync();
    return appDir;
  }

  Directory _getHomeDirectory() {
    String? home = "";
    Map<String, String> envVars = Platform.environment;
    if (Platform.isMacOS) {
      home = envVars['HOME'];
    } else if (Platform.isLinux) {
      home = envVars['HOME'];
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'];
    }
    if(home==null) {

    }
    return Directory(home!);
  }
```

In your pubspec add the libraw directory as an asset folder:

```
flutter:
  uses-material-design: true
  assets:
    - libraw/
```