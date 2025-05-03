import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StartDayCard extends StatelessWidget {
  const StartDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 180.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: darkgreenish,
        borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),

      child: Column(
        children: [
          SizedBox(height: 20.h,),
          getCustomTextBold(text: "Let's start your day", textSize: 24.sp, textColor: Colors.white),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h), child: getCustomTextMedium(text: 'with morning preparation', textSize: 14.sp, textColor: greyTextColor),),
          const Spacer(),
          SvgPicture.asset('assets/home/ellipse.svg', width: 70.sp,)
        ],
      ),
    );
  }
}