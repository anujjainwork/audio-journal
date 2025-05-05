import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecorderAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final int totalSteps;
  final VoidCallback onBack;
  final VoidCallback onCancel;

  const RecorderAppbar({
    super.key,
    required this.currentIndex,
    required this.totalSteps,
    required this.onBack,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (currentIndex == 0) {
                  Navigator.pop(context);
                } else {
                  onBack();
                }
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: darkgreenish),
            ),
            SizedBox(width: 60.w),
            Expanded(
              child: Row(
                children: List.generate(totalSteps, (index) {
                  final isFilled = index <= currentIndex;
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
                      decoration: BoxDecoration(
                        color: isFilled ? darkgreenish : Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 60.w),
            GestureDetector(
              onTap: onCancel,
              child: const Icon(Icons.close_rounded, size: 24, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
