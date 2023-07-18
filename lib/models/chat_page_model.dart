import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPageModel extends ChangeNotifier {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();

  bool isRecording = false;
  bool isPlaying = false;

  String recordTxt = "00:00";
  String playTxt = "00:00";

  double sliderValue = 0;
  double maxSliderValue = 1;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  StreamSubscription? recorderSub;
  StreamSubscription? playerSub;

  ChatPageModel() {
    init();
  }

  Future<void> init() async {
    await _initPlayer();
    await _initRecorder();
  }

  Future<void> _initPlayer() async {
    await player.closePlayer();
    await player.openPlayer();
    await player.setSubscriptionDuration(const Duration(milliseconds: 10));
    playerSub = player.onProgress?.listen((event) {
      position = position + const Duration(milliseconds: 10);
      playTxt =
          "${position.inMinutes < 10 ? "0${position.inMinutes}" : position.inMinutes}:${position.inSeconds % 60 < 10 ? "0${position.inSeconds % 60}" : position.inSeconds % 60}";
      sliderValue = position.inMilliseconds / duration.inMilliseconds > 1
          ? 1
          : position.inMilliseconds / duration.inMilliseconds;
      notifyListeners();
    });
  }

  Future<void> _initRecorder() async {
    await recorder.closeRecorder();
    if (await Permission.microphone.status == PermissionStatus.granted) {
      await recorder.openRecorder();
    } else if (await Permission.microphone.request() ==
        PermissionStatus.granted) {
      await recorder.openRecorder();
    } else {
      RecordingPermissionException("Permission was not granted");
    }
    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    recorderSub = recorder.onProgress?.listen((event) {
      duration = duration + const Duration(milliseconds: 10);
      recordTxt =
          "${duration.inMinutes < 10 ? "0${duration.inMinutes}" : duration.inMinutes}:${duration.inSeconds % 60 < 10 ? "0${duration.inSeconds % 60}" : duration.inSeconds % 60}";
      notifyListeners();
    });
  }

  Future<void> startRecord() async {
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/temp.pcm';
    isRecording = true;
    await recorder.startRecorder(toFile: path, codec: Codec.pcm16);
    notifyListeners();
  }

  Future<void> pauseRecord() async {
    if (!isRecording) return;
    isRecording = false;
    await recorder.pauseRecorder();
    notifyListeners();
  }

  Future<void> resumeRecord() async {
    if (isRecording) return;
    isRecording = true;
    await recorder.resumeRecorder();
    notifyListeners();
  }

  Future<void> closeRecord() async {
    recorderSub?.cancel();
    recordTxt = "00:00";
    duration = Duration.zero;
    isRecording = false;
    await _initRecorder();
    notifyListeners();
  }

  Future<void> startPlay() async {
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/temp.pcm';
    isPlaying = true;
    await player.startPlayer(
      fromURI: path,
      codec: Codec.pcm16,
      whenFinished: () {
        isPlaying = false;
        playTxt = "00:00";
        position = Duration.zero;
        sliderValue = 0;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> pausePlay() async {
    if (!isPlaying) return;
    isPlaying = false;
    await player.pausePlayer();
    notifyListeners();
  }

  Future<void> seekPlay(double value) async {
    if (!isPlaying) return;
    position =
        Duration(milliseconds: (value * duration.inMilliseconds).toInt());
    playTxt =
        "${position.inMinutes < 10 ? "0${position.inMinutes}" : position.inMinutes}:${position.inSeconds % 60 < 10 ? "0${position.inSeconds % 60}" : position.inSeconds % 60}";
    await player.seekToPlayer(position);
    notifyListeners();
  }

  Future<void> resumePlay() async {
    if (isPlaying) return;
    if (position == Duration.zero && player.isStopped) {
      await startPlay();
      return;
    }
    isPlaying = true;
    await player.resumePlayer();
  }

  Future<void> closePlay() async {
    playerSub?.cancel();
    playTxt = "00:00";
    position = Duration.zero;
    sliderValue = 0;
    isPlaying = false;
    await _initPlayer();
    notifyListeners();
  }
}
