// recorder_widget.dart
import 'dart:math';
import 'package:arre/audio_recorder/presentation/provider/recorder_provider.dart';
import 'package:arre/components/dot_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:arre/constants.dart';

class RecorderWidget extends StatefulWidget {
  final ValueChanged<String?> onStopped;
  const RecorderWidget({required this.onStopped, super.key});

  @override
  _RecorderWidgetState createState() => _RecorderWidgetState();
}

class _RecorderWidgetState extends State<RecorderWidget> {
  String _formatTime(Duration duration) {
    twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes.remainder(60))}:'
        '${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecorderProvider>();
    final showRecorderUI = provider.isRecording || provider.makeRecorderVisible;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        showRecorderUI ? _buildRecorderUI(provider) : _buildPlayerUI(provider),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: showRecorderUI
              ? _recorderButtons(provider)
              : _playerButtons(provider),
        ),
      ],
    );
  }

  Widget _buildRecorderUI(RecorderProvider rec) {
    final elapsed = rec.duration;
    final hasWave = elapsed > Duration.zero;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_formatTime(elapsed)),
        SizedBox(width: 12.w),
        hasWave
            ? Expanded(
                child: Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: AudioWaveforms(
                      recorderController: rec.controller,
                      size: Size(double.infinity, 60.h),
                      decoration: BoxDecoration(
                        color: darkgreenish,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      waveStyle: const WaveStyle(
                        waveColor: Colors.white,
                        spacing: 4,
                        waveThickness: 2,
                        showMiddleLine: false,
                        extendWaveform: true,
                      ),
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: darkgreenish,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              )),
        SizedBox(width: 5.w),
      ],
    );
  }

  Widget _buildPlayerUI(RecorderProvider rec) {
    final isPlaying = rec.playerController.playerState.isPlaying;
    final position = rec.playbackPosition;

    return Container(
      height: 60.h,
      width: ScreenUtil().screenWidth * 0.9,
      decoration: BoxDecoration(
        color: darkgreenish,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          IconButton(
            iconSize: 28.w,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: rec.isPreparing
                  ? const DotLoadingIndicator(key: ValueKey('dots'), dotSize: 3)
                  : Icon(
                      rec.playerController.playerState.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      key: const ValueKey('playPause'),
                      color: Colors.white,
                    ),
            ),
            onPressed: rec.isPreparing ? null : rec.togglePlayback,
          ),

          Expanded(
            child: ClipRect(
              child: LayoutBuilder(builder: (ctx, box) {
                final visibleW = box.maxWidth;
                final innerW = visibleW * 2;

                return Transform.translate(
                  offset: Offset(-visibleW * 0.9, 0),
                  child: OverflowBox(
                    maxWidth: innerW,
                    minWidth: innerW,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: innerW,
                      height: 44.h,
                      child: AudioFileWaveforms(
                        size: Size(innerW, 44.h),
                        playerController: rec.playerController,
                        waveformType: WaveformType.long,
                        playerWaveStyle: const PlayerWaveStyle(
                          fixedWaveColor: Colors.white,
                          liveWaveColor: Colors.grey,
                          waveThickness: 2,
                          showSeekLine: false,
                          spacing: 4,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(width: 10.w),

          // 3) Timer text
          Text(
            _formatTime(position),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _recorderButtons(RecorderProvider rec) {
    return [
      IconButton(
        iconSize: 44.w,
        icon: SvgPicture.asset('assets/audio_recorder/trash.svg'),
        onPressed: rec.reset,
      ),
      IconButton(
        iconSize: 44.w,
        icon: rec.isRecording
            ? Icon(Icons.pause, color: Colors.black, size: 40.w)
            : SvgPicture.asset('assets/audio_recorder/record.svg'),
        onPressed: rec.isRecording ? rec.pause : rec.start,
      ),
      Opacity(
        opacity: rec.isRecording ? 0.4 : 1,
        child: IconButton(
          iconSize: 34.w,
          icon: Container(
            padding: EdgeInsets.all(5.w),
            decoration: const BoxDecoration(
              color: darkgreenish,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          onPressed: rec.isRecording
              ? null
              : () async {
                  final path = await rec.stop();
                  widget.onStopped(path);
                },
        ),
      ),
    ];
  }

  List<Widget> _playerButtons(RecorderProvider rec) {
    return [
      IconButton(
        iconSize: 44.w,
        icon: SvgPicture.asset('assets/audio_recorder/trash.svg'),
        onPressed: rec.reset,
      ),
      IconButton(
        iconSize: 44.w,
        icon: SvgPicture.asset('assets/audio_recorder/record.svg'),
        onPressed: () {
          rec.reset();
          rec.start();
        },
      ),
      IconButton(
        iconSize: 34.w,
        icon: Container(
          padding: EdgeInsets.all(5.w),
          decoration: const BoxDecoration(
            color: darkgreenish,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        onPressed: rec.isPreparing && rec.audioPath==null
            ? null
            : () async {
                rec.playerController.stopPlayer();
                widget.onStopped(rec.audioPath!);
              },
      ),
    ];
  }
}
