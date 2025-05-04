import 'package:arre/audio/presentation/widgets/playback.dart';
import 'package:arre/components/bottom_nav_bar.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/widget/planner_cards.dart';
import 'package:arre/home/presentation/widget/header.dart';
import 'package:arre/home/presentation/widget/week_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      appBar: Header(
        iconSize: 50.w,
        isMenuOpen: _isMenuOpen,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child:
                    getCustomTextBold(text: 'Good morning.', textSize: 30.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              const WeeklyPager(),
              const Divider(
                height: 5,
                color: Colors.black12,
              ),
              SizedBox(
                height: 40.h,
              ),
              const DayBody()
            ],
          ),
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
            bottom: _isMenuOpen ? 10.h : -200.h, // animate in/out
            left: ScreenUtil().screenWidth * 0.5 - 75.w,
            child: AnimatedOpacity(
              opacity: _isMenuOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: _menuBox(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onCenterButtonTap: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen;
          });
        },
      ),
    ));
  }

  Widget _menuBox() {
    return Container(
        width: 150.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/home/write.svg'),
                getCustomTextMedium(text: 'Write', textSize: 14.sp)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Divider(
                color: Colors.black12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/home/record.svg'),
                getCustomTextMedium(text: 'Record', textSize: 14.sp)
              ],
            )
          ],
        ));
  }
}
