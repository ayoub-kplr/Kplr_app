import 'package:flutter/material.dart';

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
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // File Input 1
            ElevatedButton(
              onPressed: () {
                // Implement file input functionality
              },
              child: Text('Choose File 1'),
            ),

            // File Input 2
            ElevatedButton(
              onPressed: () {
                // Implement file input functionality
              },
              child: Text('Choose File 2'),
            ),

            // File Input 3
            ElevatedButton(
              onPressed: () {
                // Implement file input functionality
              },
              child: Text('Choose File 3'),
            ),

            SizedBox(height: 20),

            // Text Input 1
            TextField(
              controller: textController1,
              decoration: InputDecoration(labelText: 'Text Input 1'),
            ),

            SizedBox(height: 10),

            // Text Input 2
            TextField(
              controller: textController2,
              decoration: InputDecoration(labelText: 'Text Input 2'),
            ),

            SizedBox(height: 20),

            // Button 1
            ElevatedButton(
              onPressed: () {
                // Implement functionality for Button 1
              },
              child: Text('Button 1'),
            ),

            SizedBox(height: 10),

            // Button 2
            ElevatedButton(
              onPressed: () {
                // Implement functionality for Button 2
              },
              child: Text('Button 2'),
            ),

            SizedBox(height: 10),

            // Button 3
            ElevatedButton(
              onPressed: () {
                // Implement functionality for Button 3
              },
              child: Text('Button 3'),
            ),
          ],
        ),
      ),
    );
  }
}
