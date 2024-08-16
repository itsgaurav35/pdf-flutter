import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  final File file;
  const PDFViewer({super.key, required this.file});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveFile() async {
    try {
      if (_pdfViewerController.pageCount > 0) {
        List<int> bytes = await _pdfViewerController.saveDocument();

        final directory =
            await getExternalStorageDirectory(); // Get the app-specific directory
        final filePath = '${directory!.path}/${DateTime.now()}_invoice.pdf';
        final file = File(filePath);

        await file.writeAsBytes(bytes);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Saved")));
        print("File saved at $filePath");
      } else {
        print("No pages to save");
      }
    } catch (e) {
      print("Error saving file: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error saving file")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer'), centerTitle: false, actions: [
        IconButton(onPressed: _saveFile, icon: const Icon(Icons.save)),
        // IconButton(
        //     icon: Icon(Icons.download),
        //     onPressed: () async {
        //       try {
        //         final bytes = await widget.file.readAsBytes();
        //         final directory = await getApplicationDocumentsDirectory();
        //         final file = File(directory.path + '/downloaded_pdf.pdf');
        //         await file.writeAsBytes(bytes);
        //         showDialog(
        //           context: context,
        //           builder: (context) => AlertDialog(
        //             title: Text('PDF Downloaded'),
        //             content:
        //                 Text('The PDF has been downloaded to your device.'),
        //           ),

        //         );
        //       } catch (error) {
        //         showDialog(
        //           context: context,
        //           builder: (context) => AlertDialog(
        //             title: Text('Error'),
        //             content: Text('Failed to download the PDF: $error'),
        //           ),
        //         );
        //       }
        //     }),
        //for printing the pdf ans saving the PDF
        //     IconButton(
        //         icon: Icon(Icons.print),
        //         onPressed: () async {
        //           try {
        //             final bytes = await widget.file.readAsBytes();
        //             await  (bytes);
        //           } catch (error) {
        //             showDialog(
        //                 context: context,
        //                 builder: (context) => AlertDialog(
        //                   title: Text('Error'),
        //                   content: Text('Failed to print the PDF: $error'),
        //                 ));
        //           }
        //         }),
      ]),
      body: SfPdfViewer.file(
        widget.file,
        controller: _pdfViewerController,
      ),
    );
  }
}
