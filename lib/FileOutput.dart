import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:html' as html;
import '/globals.dart' as globals;

class FileOutput extends LogOutput {
  FileOutput();

  // late File file;

  File? logger_file;
  // final directory;

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   print(directory.path);

  //   return directory.path;
  // }

  @override
  void init() async {
    super.init();

    // /Users/BIC/development/ldp/lib
    // logger_file = new File(_localPath.toString() + "/ldpf.log");

    globals.logger_file = new File("/ldpf.log");

    //   if (kIsWeb) {
    //   final ImagePicker _picker = ImagePicker();
    //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //   if (image != null) {
    //     var f = await image.readAsBytes();
    //     setState(() {
    //       _file = File("a");
    //       webImage = f;
    //     });
    //   } else {
    //     showToast("No file selected");
    //   }
    // } else {
    //   showToast("Permission not granted");
    // }

    // var completePath = "/dev/dart/work/hello/app.dart";
    // var fileName = (completePath.split('/').last);
    // var filePath = completePath.replaceAll("/$fileName", '');
    // print(fileName);
    // print(filePath);

    // final result = await FilePicker.platform
    //     .pickFiles(type: FileType.any, allowMultiple: false);

    // if (result?.files.first != null) {
    //   var fileBytes = result?.files.first.bytes;
    //   var fileName = result?.files.first.name;
    //   print(String.fromCharCodes(fileBytes!));
    // }

    // https://stackoverflow.com/questions/54122850/how-to-read-and-write-a-text-file-in-flutter
  }

  // @override
  //     void initState() {
  //       super.initState();
  //       _initUser().whenComplete((){
  //         setState(() {});
  //      });
  //     }

  @override
  void output(OutputEvent event) async {
    globals.logger = globals.logger + "\n" + event.lines.toString();

    // if (globals.logger_file != null) {
    //   for (var line in event.lines) {
    //     // await logger_file?.writeAsString("${line.toString()}\n",
    //     //     mode: FileMode.writeOnlyAppend);

    //     await globals.logger_file?.writeAsString(event.lines.toString() + "\n",
    //         mode: FileMode.writeOnlyAppend);
    //   }
    // } else {
    //   for (var line in event.lines) {
    //     print(line);
    //   }
    // }

    // try {
    //   await logger_file?.writeAsString(globals.logger);
    // } on Exception catch (_) {
    //   print(Exception);
    // }

    // print(globals.logger);
    // print(logger_file);

    // if (globals.logger_file != null) {
    //   print("logger_file ok...");
    //   for (var line in event.lines) {
    //     await globals.logger_file?.writeAsString("${line.toString()}\n",
    //         mode: FileMode.writeOnlyAppend);
    //   }
    // } else {
    //   print("logger_file blanck...");
    //   for (var line in event.lines) {
    //     print(line);

    //     await globals.logger_file
    //         ?.writeAsString("${line.toString()}\n", mode: FileMode.write);
    //   }
    // }

    // if (kIsWeb) {
    //  var blob = html.Blob(["data"], 'text/plain', 'native');

    //  var anchorElement = html.AnchorElement(
    //     href: html.Url.createObjectUrlFromBlob(blob).toString(),
    //  )..setAttribute("download", "my_file.txt")..click();

    //   html.AnchorElement(
    //       href: "data:text/plain;charset=utf-8," + globals.logger)
    //     ..setAttribute("download", "logger.txt")
    //     ..click();
    // } else {
    //   final Directory directory = await getApplicationDocumentsDirectory();
    //   final File file = File('${directory.path}/my_file.txt');
    //   // file = new File("../lib/demo.txt");
    //   print("File Path : " + file.path);
    // }
  }
}
