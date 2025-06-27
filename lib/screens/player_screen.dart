import 'package:flutter/material.dart';
import '../services/audio_service.dart' as my_audio;

class PlayerScreen extends StatefulWidget {
  final String wavFilePath;
  const PlayerScreen({required this.wavFilePath, Key? key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _speed = 1.0;
  @override
  void initState() {
    super.initState();
    my_audio.AudioService.init(widget.wavFilePath);
  }

  @override
  void dispose() {
    my_audio.AudioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مشغل الصوت')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<bool>(
            stream: my_audio.AudioService.isPlayingStream,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 48,
                ),
                onPressed: () => my_audio.AudioService.togglePlayPause(),
              );
            },
          ),
          StreamBuilder<Duration>(
            stream: my_audio.AudioService.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return Slider(
                value: position.inSeconds.toDouble(),
                min: 0,
                max: my_audio.AudioService.duration?.inSeconds.toDouble() ?? 1,
                onChanged: (v) =>
                    my_audio.AudioService.seek(Duration(seconds: v.toInt())),
              );
            },
          ),
          DropdownButton<double>(
            value: _speed,
            items: <double>[0.25, 0.5, 1.0, 1.5, 2.0]
                .map((double s) =>
                    DropdownMenuItem<double>(value: s, child: Text('x$s')))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => _speed = v);
                my_audio.AudioService.setSpeed(v);
              }
            },
          ),
        ],
      ),
    );
  }
}
