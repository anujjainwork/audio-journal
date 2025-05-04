import 'package:arre/constants.dart';
import 'package:arre/home/presentation/provider/weekly_pager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class WeeklyPager extends StatefulWidget {
  const WeeklyPager({Key? key}) : super(key: key);

  @override
  _WeeklyPagerState createState() => _WeeklyPagerState();
}

class _WeeklyPagerState extends State<WeeklyPager> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: WeeklyPagerProvider.bufferWeeks,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeeklyPagerProvider>(context, listen: true);

    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.all(8.w),
        //   child: Text(
        //     provider.userOnCurrentWeek
        //         ? 'On current week'
        //         : 'On another week',
        //     style: TextStyle(fontSize: 14.sp),
        //   ),
        // ),
        SizedBox(
          height: 80.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: WeeklyPagerProvider.bufferWeeks * 2 + 1,
            pageSnapping: true,
            itemBuilder: (ctx, weekIndex) {
              final sunday = provider.weekStart
                  .add(Duration(days: (weekIndex - WeeklyPagerProvider.bufferWeeks) * 7));

              return Row(
                children: List.generate(7, (dayOffset) {
                  final date = sunday.add(Duration(days: dayOffset));
                  final isSelected = date.year == provider.selectedDate.year &&
                      date.month == provider.selectedDate.month &&
                      date.day == provider.selectedDate.day;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.selectDate(date);
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: isSelected ? darkgreenish : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.E().format(date),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[700],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                date.day.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
