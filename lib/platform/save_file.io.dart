import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../bgmd.dart';

Future<String?> saveFile(String fileName, Uint8List bytes, {FileType fileType = FileType.any}) async {
  final v = await FilePicker.platform.saveFile(
    bytes: bytes,
    fileName: fileName,
    type: fileType,
  );
  if (isMobile) {
    return v;
  }
  if (v != null) {
    await File(v).writeAsBytes(bytes);
  }
  return v;
}
