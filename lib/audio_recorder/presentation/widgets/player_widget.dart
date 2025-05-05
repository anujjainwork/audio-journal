import 'dart:io';
import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/presentation/provider/player_provider.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/provider/home_audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;
  final AudioModel? audioModel;
  final String audioName;
  final bool isAtHomePage;

  const AudioPlayerWidget({super.key, required this.audioPath, this.audioName = 'NONE', this.isAtHomePage = false, this.audioModel});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  String _formatTime(Duration d) =>
      DateFormat('mm:ss').format(DateTime(0).add(d));

  @override
  void initState() {
    super.initState();
    _initPlayer(widget.audioPath);
  }

  Future<void> _initPlayer(String audioPath) async {
    await _player.setFilePath(audioPath);
    if(mounted){
      setState(() {
      _duration = _player.duration ?? Duration.zero;
    });
    }

    _player.positionStream.listen((pos) {
      if(mounted){
        setState(() {
        _position = pos;
      });
      }
    });

    _player.playerStateStream.listen((state) {
      if(mounted){
        setState(() {
        _isPlaying = state.playing;
      });
      }
    });
  }

  void _seek(Duration target) {
    final clamped = target < Duration.zero
        ? Duration.zero
        : target > _duration
            ? _duration
            : target;
    _player.seek(clamped);
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context, listen:true);
    final homePageProvider = Provider.of<HomeAudioProvider>(context, listen:true);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Clip Name Field
          SizedBox(
            height: 44.h,
            child: widget.audioName == 'NONE'
                ? TextField(
                    controller: audioPlayerProvider.nameController,
                    style: TextStyle(
                      letterSpacing: -0.5.w,
                      color: darkgreenish,
                      fontSize: 18.sp,
                      fontFamily: 'MonaSans',
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Row(
                    children: [
                      getCustomTextMedium(text: widget.audioName, textSize: 18.sp, textColor: darkgreenish),
                      const Spacer()
                    ],
                  ),
          ),

          // Slider
          SizedBox(
            width: double.infinity,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
              ),
              child: Slider(
                min: 0,
                max: _duration.inMilliseconds.toDouble(),
                value: _position.inMilliseconds
                    .clamp(0, _duration.inMilliseconds)
                    .toDouble(),
                onChanged: (value) {
                  _seek(Duration(milliseconds: value.toInt()));
                },
                activeColor: darkgreenish,
                inactiveColor: darkgreenish.withOpacity(0.3),
              ),
            ),
          ),

          // Time Labels
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomTextThin(text: _formatTime(_position), textSize: 16.sp),
                getCustomTextThin(text: _formatTime(_duration), textSize: 16.sp),
              ],
            ),
          ),

          SizedBox(height: 5.h),

          // Control Buttons Row
          Row(
            children: [
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  // Optional: Handle waveform toggle
                },
                child: SvgPicture.asset(
                  'assets/audio_recorder/waveform.svg',
                  width: 26.w,
                  height: 26.h,
                  color: darkgreenish,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rewind
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/audio_recorder/rewind_button.svg',
                      width: 34.w,
                      height: 34.h,
                      color: darkgreenish,
                    ),
                    onTap: () {
                      _seek(_position - const Duration(seconds: 5));
                    },
                  ),
                  SizedBox(width: 10.w),
                  // Play / Pause
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: _isPlaying
                        ? Icon(Icons.pause, color: darkgreenish, size: 34.w)
                        : Icon(Icons.play_arrow, color: darkgreenish, size: 34.w),
                  ),
                  SizedBox(width: 10.w),
                  // Forward
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/audio_recorder/forward_button.svg',
                      width: 34.w,
                      height: 34.h,
                      color: darkgreenish,
                    ),
                    onTap: () {
                      _seek(_position + const Duration(seconds: 5));
                    },
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  if(widget.isAtHomePage==true){
                    homePageProvider.deleteAudio(widget.audioModel!);
                  }
                },
                child: SvgPicture.asset(
                  'assets/audio_recorder/trash.svg',
                  width: 26.w,
                  height: 26.h,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
    );
  }
}
