
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'libraw_bindings_generated.dart';

const String _libName = 'libraw';
String libraryPath = 'bin';

/// The dynamic library in which the symbols for [FfigenAppBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$libraryPath${Platform.pathSeparator}$_libName.a');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('$libraryPath${Platform.pathSeparator}$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$libraryPath${Platform.pathSeparator}$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final FlutterLibRawBindings _bindings = FlutterLibRawBindings(_dylib);

class RawFile implements Finalizable {

  //static final _finalizer = NativeFinalizer(_bindings.libraw_close());
  late Pointer<libraw_data_t> _librawData;

  final File file;

  RawFile._(this._librawData, this.file);

  factory RawFile.open(File rawFile) {
    Pointer<libraw_data_t> ptr = _bindings.libraw_init(0);
    RawFile file = RawFile._(ptr, rawFile);
    _bindings.libraw_open_file(ptr, rawFile.path.toNativeUtf8().cast());
    return file;
  }

}