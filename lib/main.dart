import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpdf/page/pdf_page.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await _requestPermissions();
  runApp(MyApp());
}

Future<void> _requestPermissions() async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    print("Storage permission granted");
  } else {
    print("Storage permission denied");
  }
}

class MyApp extends StatelessWidget {
  static const String title = 'Invoice';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: PdfPage(),
      );
}
