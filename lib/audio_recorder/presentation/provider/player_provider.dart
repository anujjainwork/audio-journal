import 'dart:io';
import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/data/repositories/audio_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AudioPlayerProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  AudioTag? _tag;

  AudioPlayerProvider() {
    nameController.text = "Name your clip";
    nameController.addListener(() {
      notifyListeners();
    });
  }

  String get clipName => nameController.text;
  AudioTag? get tag => _tag;

  void setAudioTag(AudioTag tagger) {
    _tag = tagger;
    notifyListeners();
  }

  void reset(){
    nameController.text = "Name your clip";
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> saveRecordedAudio(String audioPath) async {
    try {
      const uuid = Uuid();
      final audioId = uuid.v4();
      final audioFile = AudioModel(
          clipName: clipName,
          audioId: audioId,
          audioPath: audioPath,
          createdTime: DateTime.now(),
          tag: tag ?? AudioTag.day_planning);
      final audioRepo = AudioRepository();
      await audioRepo.insertAudio(audioFile);
    } catch (e) {
      throw (Exception(e));
    }
  }
}
