import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

class Unified extends StatefulWidget {
  final String title;
  final String api;
  const Unified({Key? key, required this.title, required this.api})
      : super(key: key);
  @override
  _UnifiedState createState() => _UnifiedState();
}

class _UnifiedState extends State<Unified> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.api),
      );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermissions();
      anrdoidFileChooser();
    });
  }

  void anrdoidFileChooser() async {
    if (Platform.isAndroid) {
      final _controller = (controller.platform
          as webview_flutter_android.AndroidWebViewController);
      await _controller.setOnShowFileSelector(_androidFilePicker);
    }
  }

  void requestPermissions() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // You can request multiple permissions at once.
      await Permission.storage.request();
      await Permission.camera.request();
      await Permission.photos.request();
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.storage,
      //   Permission.camera,
      // ].request();
      print(await Permission.manageExternalStorage
          .status); // it should print PermissionStatus.granted
      print("Executed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }

  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return [file.uri.toString()];
    }
    return [];
  }
}
