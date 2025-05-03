import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final double iconSize;
  final bool isMenuOpen;

  const Header({
    super.key,
    required this.iconSize,
    this.isMenuOpen = false,
  });

  @override
  State<Header> createState() => _HeaderState();

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/home/flower.svg',
                width: widget.iconSize.w,
                height: widget.iconSize.w,
              ),
              SvgPicture.asset(
                'assets/home/user_circle.svg',
                width: widget.iconSize.w,
                height: widget.iconSize.w,
              ),
            ],
          ),
        ),

        if (widget.isMenuOpen)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
      ],
    );
  }
}
