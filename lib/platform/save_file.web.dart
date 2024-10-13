import 'dart:html' as html;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<String?> saveFile(String fileName, Uint8List bytes, {FileType fileType = FileType.any}) async {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
  anchor.remove();
  return null;
}
