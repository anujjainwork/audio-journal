import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/presentation/provider/player_provider.dart';
import 'package:arre/audio_recorder/presentation/provider/recorder_provider.dart';
import 'package:arre/audio_recorder/presentation/widgets/player_widget.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/provider/home_audio_provider.dart';
import 'package:arre/home/presentation/provider/weekly_pager_provider.dart';
import 'package:arre/home/presentation/widget/end_day_card.dart';
import 'package:arre/home/presentation/widget/start_day_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // <-- add this
import 'package:provider/provider.dart';

enum SelectedCard { none, start, end }

class DayBody extends StatefulWidget {
  const DayBody({super.key});

  @override
  State<DayBody> createState() => _DayBodyState();
}

class _DayBodyState extends State<DayBody> {
  SelectedCard _selectedCard = SelectedCard.start;

  void _onCardTap(SelectedCard card) {
    setState(() {
      _selectedCard = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekPagerProvider = context.watch<WeeklyPagerProvider>();
    final selected = weekPagerProvider.selectedDate;
    final audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: true);
    final homeAudioProvider =
        Provider.of<HomeAudioProvider>(context, listen: true);
    final formatted = DateFormat('dd MMM, yyyy').format(selected).toUpperCase();

    return Column(
      children: [
        getCustomTextNormal(
          text: formatted,
          textSize: 16.sp,
          textColor: greyTextColor
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                audioPlayerProvider.setAudioTag(AudioTag.day_planning);
                _onCardTap(SelectedCard.start);
                homeAudioProvider.getAudiosForDayAndTag(
                    selected, AudioTag.day_planning);
              },
              child: StartDayCard(
                isSelected: _selectedCard == SelectedCard.start,
              ),
            ),
            GestureDetector(
              onTap: () {
                audioPlayerProvider.setAudioTag(AudioTag.day_reflection);
                _onCardTap(SelectedCard.end);
                homeAudioProvider.getAudiosForDayAndTag(
                    selected, AudioTag.day_reflection);
              },
              child: EndDayCard(
                isSelected: _selectedCard == SelectedCard.end,
              ),
            ),
          ],
        )
      ],
    );
  }
}