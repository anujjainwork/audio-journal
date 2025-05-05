import 'package:arre/audio_recorder/data/db/audio_db.dart';
import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:sqflite/sqflite.dart';

class AudioRepository {
  final AudioDatabase _dbHelper = AudioDatabase();

  Future<void> insertAudio(AudioModel audio) async {
    final db = await _dbHelper.database;
    await db.insert(
      'audio',
      audio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AudioModel>> fetchAll() async {
    final db = await _dbHelper.database;
    final result = await db.query('audio', orderBy: 'createdTime DESC');
    return result.map((map) => AudioModel.fromMap(map)).toList();
  }

  Future<AudioModel?> getById(String id) async {
    final db = await _dbHelper.database;
    final result =
        await db.query('audio', where: 'audioId = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return AudioModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<AudioModel>> getByTag(AudioTag tag) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'audio',
      where: 'tag = ?',
      whereArgs: [tag.name],
    );
    return result.map((e) => AudioModel.fromMap(e)).toList();
  }

  Future<List<AudioModel>> getByDateRange(DateTime start, DateTime end) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'audio',
      where: 'createdTime >= ? AND createdTime <= ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'createdTime DESC',
    );
    return result.map((e) => AudioModel.fromMap(e)).toList();
  }

  Future<void> deleteById(String id) async {
    final db = await _dbHelper.database;
    await db.delete('audio', where: 'audioId = ?', whereArgs: [id]);
  }

  Future<void> updateAudio(AudioModel audio) async {
    final db = await _dbHelper.database;
    await db.update(
      'audio',
      audio.toMap(),
      where: 'audioId = ?',
      whereArgs: [audio.audioId],
    );
  }

  Future<AudioModel?> getByIdAndTag(String id, AudioTag tag) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'audio',
      where: 'audioId = ? AND tag = ?',
      whereArgs: [id, tag.name],
    );
    if (result.isNotEmpty) {
      return AudioModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<AudioModel>> getByDateRangeAndTag(
      DateTime start, DateTime end, AudioTag tag) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'audio',
      where: 'createdTime >= ? AND createdTime <= ? AND tag = ?',
      whereArgs: [
        start.toIso8601String(),
        end.toIso8601String(),
        tag.name,
      ],
      orderBy: 'createdTime DESC',
    );
    return result.map((e) => AudioModel.fromMap(e)).toList();
  }

  Future<List<AudioModel>> getByDateAndTag(DateTime date, AudioTag tag) async {
    final db = await _dbHelper.database;

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final result = await db.query(
      'audio',
      where: 'createdTime >= ? AND createdTime <= ? AND tag = ?',
      whereArgs: [
        startOfDay.toIso8601String(),
        endOfDay.toIso8601String(),
        tag.name,
      ],
      orderBy: 'createdTime DESC',
    );

    return result.map((e) => AudioModel.fromMap(e)).toList();
  }
}