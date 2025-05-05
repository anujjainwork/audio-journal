import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/presentation/provider/player_provider.dart';
import 'package:arre/audio_recorder/presentation/provider/recorder_provider.dart';
import 'package:arre/audio_recorder/presentation/widgets/player_widget.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/provider/home_audio_provider.dart';
import 'package:arre/home/presentation/provider/weekly_pager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SaveRecordingScreen extends StatefulWidget {
  const SaveRecordingScreen({super.key});

  @override
  State<SaveRecordingScreen> createState() => _SaveRecordingScreenState();
}

class _SaveRecordingScreenState extends State<SaveRecordingScreen> {
  @override
  Widget build(BuildContext context) {
    final recorderProvider = Provider.of<RecorderProvider>(context,listen:true);
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context,listen:true);
    final homeAudioProvider = Provider.of<HomeAudioProvider>(context,listen: true);
    final weeklyPagerProvider = context.watch<WeeklyPagerProvider>();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                getCustomTextBold(
                    text: 'What do you plan to do today?', textSize: 24.sp),
                const Spacer()
              ],
            ),
            SizedBox(height: 25.h),
            AudioPlayerWidget(audioPath: recorderProvider.audioPath!),
            const Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/home/add.svg',
                  width: 64.sp,
                  height: 64.sp,
                ),
                const Spacer(),
                _saveButton(audioPlayerProvider, weeklyPagerProvider,homeAudioProvider,recorderProvider.audioPath!,context)
              ],
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ));
  }

  Widget _saveButton(AudioPlayerProvider prov, WeeklyPagerProvider weeklyPagerProvider,HomeAudioProvider homeAudioProvider,String audioPath, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await prov.saveRecordedAudio(audioPath);
        await homeAudioProvider.getAudiosForDayAndTag(weeklyPagerProvider.selectedDate, prov.tag ?? AudioTag.day_planning);
        Navigator.pop(context);
      },
      child: Container(
        height: 50.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: darkgreenish, borderRadius: BorderRadius.circular(40.r)),
        child: Center(
          child: getCustomTextBold(
              text: 'Save', textSize: 16.sp, textColor: Colors.white),
        ),
      ),
    );
  }
}
