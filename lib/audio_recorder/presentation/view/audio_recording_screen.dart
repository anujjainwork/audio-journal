import 'package:arre/audio_recorder/presentation/widgets/recorder_widget.dart';
import 'package:arre/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RecorderScreen extends StatefulWidget {
  final VoidCallback goNext;
  const RecorderScreen({super.key, required this.goNext});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              getCustomTextThin(
                  text: 'Start recording....',
                  textSize: 18.sp,
                  textAlign: TextAlign.start),
              const Spacer()
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SvgPicture.asset(
                'assets/home/add.svg',
                width: 64.sp,
                height: 64.sp,
              ),
              const Spacer()
            ],
          ),
          SizedBox(height: 25.h),
          SizedBox(
            height: 10.h,
          ),
          RecorderWidget(
            onStopped: (path) {
              // recorderProvider.setAudioPath(path!);
              widget.goNext();
            },
          ),
        ],
      ),
    );
  }
}
