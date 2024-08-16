import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    print("Working");
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    print(file);
    await file.writeAsBytes(bytes);
    print("Done");

    return file;
  }
  

  // static Future openFile(File file) async {
  //   final path = file.path;
  //   print("Attempting to open file at: $path");

  //   if (await file.exists()) {
  //     print("File exists.");
  //     await OpenFile.open(path);
  //   } else {
  //     print("File does not exist.");
  //   }
  // }
}
