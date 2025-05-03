import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback onCenterButtonTap;
  const BottomNavBar({super.key, required this.onCenterButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _navItem(
            iconPath: 'assets/home/home.svg',
            label: 'Home',
            isActive: true,
          ),
          _navItem(
            iconPath: 'assets/home/explore.svg',
            label: 'Explore',
          ),
          _centerButton(onCenterButtonTap),
          _navItem(
            iconPath: 'assets/home/journey.svg',
            label: 'Journey',
          ),
          _navItem(
            iconPath: 'assets/home/trends.svg',
            label: 'Trends',
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required String iconPath,
    required String label,
    bool isActive = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(
            isActive ? darkgreenish : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isActive ? darkgreenish : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _centerButton(VoidCallback function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: darkgreenish,
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}