import 'package:flutter/material.dart';
import '../widgets/ksf_file_picker.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? wavFilePath;

  void _onFileProcessed(String path) {
    setState(() => wavFilePath = path);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlayerScreen(wavFilePath: path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KSF Player iOS')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [KSFFilePicker(onFileProcessed: _onFileProcessed)],
          ),
        ),
      ),
    );
  }
}
