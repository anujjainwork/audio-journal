import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/data/repositories/audio_repository.dart';
import 'package:flutter/material.dart';

class HomeAudioProvider extends ChangeNotifier{
  List<AudioModel> _currentAudios = [];
  List<AudioModel> get currentAudios => _currentAudios;

  setCurrentAudios(List<AudioModel> audios){
    _currentAudios = audios;
    notifyListeners();
  }

  Future<void> getAudiosForDayAndTag(DateTime date, AudioTag tag) async {
    try{
      final audioRepo = AudioRepository();
      final audios = await audioRepo.getByDateAndTag(date, tag);
      _currentAudios = audios;
      notifyListeners();
    } catch(e){
      throw(Exception(e));
    }
  }

  Future<void> deleteAudio(AudioModel audio) async {
    try{
      final audioRepo = AudioRepository();
      await audioRepo.deleteById(audio.audioId);
      getAudiosForDayAndTag(audio.createdTime, audio.tag);
    }
    catch(e){
      throw(Exception(e));
    }
  }
}