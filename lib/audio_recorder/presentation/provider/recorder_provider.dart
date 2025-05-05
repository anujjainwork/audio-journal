import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class RecorderProvider extends ChangeNotifier {
  final RecorderController controller = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4;
  final PlayerController playerController = PlayerController();

  Duration _duration = Duration.zero;
  Duration _playbackPosition = Duration.zero;
  Duration _playbackDuration = Duration.zero;

  String? _recordingPath;
  bool _makeRecorderVisible = true;
  bool _isRecording = false;
  bool _isPreparing = false;

  bool get isRecording => _isRecording;
  bool get isPreparing => _isPreparing;
  Duration get duration => _duration;
  Duration get playbackPosition => _playbackPosition;
  Duration get playbackDuration => _playbackDuration;
  String? get audioPath => _recordingPath;
  bool get makeRecorderVisible => _makeRecorderVisible;

  RecorderProvider() {
    controller.checkPermission();
    controller.onCurrentDuration.listen((d) {
      if (_isRecording) {
        _duration = d;
        notifyListeners();
      }
    });
    playerController.onCurrentDurationChanged.listen((ms) {
      _playbackPosition = Duration(milliseconds: ms);
      notifyListeners();
    });
    playerController.onCompletion.listen((_) {
      _playbackPosition = Duration.zero;
      playerController.stopPlayer();
      notifyListeners();
    });
  }

  Future<void> start() async {
    await controller.record();
    _isRecording = true;
    _makeRecorderVisible = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await controller.pause();
    _isRecording = false;
    _makeRecorderVisible = false;
    notifyListeners();
  }

  Future<String?> stop() async {
    final path = await controller.stop();
    _isRecording = false;
    _makeRecorderVisible = false;
    _recordingPath = path;
    if (path != null) {
      await _preparePlayer(path);
    }
    notifyListeners();
    return path;
  }

  Future<void> _preparePlayer(String path) async {
    _isPreparing = true;
    notifyListeners();
    try {
      await playerController.preparePlayer(
        path: path,
        shouldExtractWaveform: true,
      );
      final totalMs = await playerController.getDuration();
      _playbackDuration = Duration(milliseconds: totalMs);
    } catch (e) {
      // handle errors if needed
    } finally {
      _isPreparing = false;
      notifyListeners();
    }
  }

  Future<void> togglePlayback() async {
  if (_recordingPath == null) {
      await stop();
      await playerController.startPlayer();
      return;
    }

  final state = playerController.playerState;

  if (_playbackPosition >= _playbackDuration || state.isStopped && _playbackPosition == Duration.zero) {
    _isPreparing = true;
    notifyListeners();
    try {
      await playerController.preparePlayer(
        path: _recordingPath!,
        shouldExtractWaveform: false,
      );
    } finally {
      _isPreparing = false;
      _playbackPosition = Duration.zero;
      notifyListeners();
    }
  }

  if (state.isStopped || _playbackPosition >= _playbackDuration) {
    await playerController.startPlayer();
  } else if (state.isPlaying) {
    await playerController.pausePlayer();
  } else {
    await playerController.startPlayer();
  }

  notifyListeners();
}

  Future<void> reset() async {
    if (_isRecording) {
      await controller.stop();
    }
    controller.reset();
    controller.refresh();
    playerController.stopPlayer();

    _duration = Duration.zero;
    _playbackPosition = Duration.zero;
    _playbackDuration = Duration.zero;
    _isRecording = false;
    _recordingPath = null;
    _makeRecorderVisible = true;

    notifyListeners();
  }
}
