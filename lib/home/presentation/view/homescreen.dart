import 'package:arre/audio_recorder/data/model/audio_model.dart';
import 'package:arre/audio_recorder/presentation/view/recording_screen.dart';
import 'package:arre/audio_recorder/presentation/widgets/player_widget.dart';
import 'package:arre/components/bottom_nav_bar.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/provider/home_audio_provider.dart';
import 'package:arre/home/presentation/widget/planner_cards.dart';
import 'package:arre/home/presentation/widget/header.dart';
import 'package:arre/home/presentation/widget/week_pager.dart';
import 'package:arre/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isMenuOpen = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeAudioProvider>(context, listen: false);
      provider.getAudiosForDayAndTag(DateTime.now(), AudioTag.day_planning);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeAudioProvider =
        Provider.of<HomeAudioProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: Header(
          iconSize: 50.w,
          isMenuOpen: _isMenuOpen,
        ),
        body: Stack(
          children: [
            // The scrollable content inside a Positioned widget
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom:
                  80.h, // Adjust the bottom to leave space for the BottomNavBar
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: getCustomTextBold(
                          text: 'Good morning.', textSize: 30.sp),
                    ),
                    SizedBox(height: 10.h),
                    const WeeklyPager(),
                    const Divider(height: 5, color: Colors.black12),
                    SizedBox(height: 20.h),
                    const DayBody(),
                    if (homeAudioProvider.currentAudios.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomTextBold(
                                text: "Today's plans", textSize: 18.sp),
                            SizedBox(height: 10.h),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: homeAudioProvider.currentAudios.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                final audio =
                                    homeAudioProvider.currentAudios[index];
                                return AudioPlayerWidget(
                                  audioPath: audio.audioPath,
                                  audioName: homeAudioProvider
                                      .currentAudios[index].clipName,
                                  audioModel: audio,
                                  isAtHomePage: true,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Menu Box Animation (stays over content)
            if (_isMenuOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMenuOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              bottom: _isMenuOpen ? 80.h : -200.h, // animate in/out
              left: ScreenUtil().screenWidth * 0.5 - 119.w / 2,
              child: AnimatedOpacity(
                opacity: _isMenuOpen ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: _menuBox(),
              ),
            ),

            // Bottom Navigation Bar (fixed at the bottom)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(
                onCenterButtonTap: () {
                  setState(() {
                    _isMenuOpen = !_isMenuOpen;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuBox() {
    return Container(
      width: 119.w,
      height: 105.h,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/home/write_grey.svg',
                    height: 24.sp, width: 24.sp),
                SizedBox(width: 8.w),
                getCustomTextMedium(text: 'Write', textSize: 16.sp),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const Divider(color: Colors.black12),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouteNames.recordingScreen
              ).then((_) {
                setState(() {
                  _isMenuOpen = false;
                });
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/home/mic_grey.svg',
                      height: 24.sp, width: 24.sp),
                  SizedBox(width: 8.w),
                  getCustomTextMedium(text: 'Record', textSize: 16.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}