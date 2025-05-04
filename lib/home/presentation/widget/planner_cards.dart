import 'package:arre/components/custom_text.dart';
import 'package:arre/home/presentation/provider/weekly_pager_provider.dart';
import 'package:arre/home/presentation/widget/end_day_card.dart';
import 'package:arre/home/presentation/widget/start_day_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';      // <-- add this
import 'package:provider/provider.dart';

class DayBody extends StatefulWidget {
  const DayBody({super.key});

  @override
  State<DayBody> createState() => _DayBodyState();
}

class _DayBodyState extends State<DayBody> {
  @override
  Widget build(BuildContext context) {
    final weekPagerProvider = context.watch<WeeklyPagerProvider>();
    final selected = weekPagerProvider.selectedDate;  // DateTime

    // format to "12 MAY, 2026"
    final formatted = DateFormat('dd MMM, yyyy')
        .format(selected)
        .toUpperCase();

    return SingleChildScrollView(
      child: Column(
        children: [
          getCustomTextMedium(
            text: formatted,
            textSize: 16.sp,
          ),
          SizedBox(height: 30.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StartDayCard(),
              EndDayCard()
            ],
          )
        ],
      ),
    );
  }
}
