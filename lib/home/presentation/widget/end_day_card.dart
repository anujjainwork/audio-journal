import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EndDayCard extends StatelessWidget {
  const EndDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300.h,
      width: 180.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(
          color: whiteBoxBorderColor
        )
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          getCustomTextBold(text: 'Evening Reflection', textSize: 24.sp),
          Padding(padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h), child: getCustomTextMedium(text: 'Sum up your day', textSize: 14.sp, textColor: greyTextColor),),
          const Spacer(),
          SvgPicture.asset('assets/home/subtract.svg', width: 40.sp,)
        ],
      ),
    );
  }
}