import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioService {
  static final _player = AudioPlayer();
  static Duration? get duration => _player.duration;
  static Stream<Duration> get positionStream => _player.positionStream;
  static Stream<bool> get isPlayingStream => _player.playingStream;

  static Future<void> init(String wavPath) async {
    await _player.setFilePath(wavPath);
  }

  static void togglePlayPause() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  static void seek(Duration position) => _player.seek(position);
  static void setSpeed(double speed) => _player.setSpeed(speed);
  static void dispose() => _player.dispose();
}
