import 'dart:io';
import 'package:file_picker/file_picker.dart';

class SaveHelper {
  static Future<void> save(List<int> bytes, String fileName) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();

      if (directory != null) {
        final File file = File('$directory/$fileName');
        if (file.existsSync()) {
          await file.delete();
        }
        await file.writeAsBytes(bytes);
      }
    } catch (e) {
      print(e);
    }
  }
}
