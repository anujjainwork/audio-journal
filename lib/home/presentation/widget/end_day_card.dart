import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EndDayCard extends StatelessWidget {
  final bool isSelected;
  const EndDayCard({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 280.h,
      width: 180.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: isSelected? darkgreenish: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: isSelected? Border.all(
          color: whiteBoxBorderColor
        ) : null
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          getCustomTextBold(text: 'Evening Reflection', textSize: 24.sp, textColor:  isSelected ? Colors.white : Colors.black),
          Padding(padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h), child: getCustomTextMedium(text: 'Sum up your day', textSize: 14.sp, textColor: greyTextColor),),
          const Spacer(),
          SvgPicture.asset('assets/home/subtract.svg', width: 40.sp,color: isSelected ? Colors.white : darkgreenish,)
        ],
      ),
    );
  }
}