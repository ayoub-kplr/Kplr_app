import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String _filePath = '';
  TextEditingController _textController1 = TextEditingController();
  TextEditingController _textController2 = TextEditingController();

  void _pickFile() async {
    String? filePath = await FilePicker.platform.pickFiles().then((value) {
      if (value != null && value.files.isNotEmpty) {
        return value.files.first.path;
      } else {
        return null;
      }
    });

    if (filePath != null) {
      setState(() {
        _filePath = filePath;
      });
    }
  }

  void _submit() {
    // Implement your logic for handling the form submission
    print('File: $_filePath');
    print('Text 1: ${_textController1.text}');
    print('Text 2: ${_textController2.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File and Text Inputs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick a File'),
            ),
            SizedBox(height: 16.0),
            Text('Selected File: $_filePath'),
            SizedBox(height: 16.0),
            TextField(
              controller: _textController1,
              decoration: InputDecoration(labelText: 'Text Input 1'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _textController2,
              decoration: InputDecoration(labelText: 'Text Input 2'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic for the second button
                  },
                  child: Text('Button 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic for the third button
                  },
                  child: Text('Button 3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
