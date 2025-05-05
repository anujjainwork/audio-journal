// ignore_for_file: constant_identifier_names

class AudioModel {
  final String audioId;
  final String clipName;
  final String audioPath;
  final DateTime createdTime;
  final AudioTag tag;

  AudioModel({
    required this.clipName,
    required this.audioId,
    required this.audioPath,
    required this.createdTime,
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'audioId': audioId,
      'clipName': clipName,
      'audioPath': audioPath,
      'createdTime': createdTime.toIso8601String(),
      'tag': tag.name,
    };
  }

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      audioId: map['audioId'],
      clipName: map['clipName'],
      audioPath: map['audioPath'],
      createdTime: DateTime.parse(map['createdTime']),
      tag: AudioTag.values.firstWhere(
        (e) => e.name == map['tag'],
        orElse: () => AudioTag.day_planning, // fallback
      ),
    );
  }
}

enum AudioTag {
  day_planning,
  day_reflection,
}
