import 'package:arre/components/bottom_nav_bar.dart';
import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/home/presentation/widget/day_body.dart';
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
            Expanded(
                child: Container(
              color: Colors.black.withOpacity(0.3),
            )),
          if (_isMenuOpen) _menuBox()
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onCenterButtonTap: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen;
          });
          print('isMenuOpen $_isMenuOpen');
        },
      ),
    ));
  }

  Widget _menuBox() {
    return Positioned(
      bottom: 10.h,
      left: MediaQuery.of(context).size.width * 0.5 - 75.w,
      child: Container(
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
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.w), child: const Divider(color: Colors.black12,),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('assets/home/record.svg'),
                  getCustomTextMedium(text: 'Record', textSize: 14.sp)
                ],
              )
            ],
          )),
    );
  }
}