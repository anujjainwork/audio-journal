import 'package:flutter/material.dart';

class WeeklyPagerProvider extends ChangeNotifier {
  static const int bufferWeeks = 20;

  final DateTime _today = DateTime.now();
  late final DateTime _weekStart;
  DateTime _selectedDate = DateTime.now();

  WeeklyPagerProvider() {
    _weekStart = getStartOfWeek(_today);
  }

  DateTime get today => _today;
  DateTime get weekStart => _weekStart;
  DateTime get selectedDate => _selectedDate;

  int get currentWeekPageIndex {
    final diffDays = _selectedDate.difference(
      _weekStart.subtract(const Duration(days: bufferWeeks * 7)),
    ).inDays;
    return diffDays ~/ 7;
  }

  /// Returns the Sunday of the week the given [date] is in
  DateTime getStartOfWeek(DateTime date) {
    final daysToSubtract = date.weekday % 7;
    return DateTime(date.year, date.month, date.day).subtract(Duration(days: daysToSubtract));
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
