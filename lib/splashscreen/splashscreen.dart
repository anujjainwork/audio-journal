import 'package:arre/components/custom_text.dart';
import 'package:arre/constants.dart';
import 'package:arre/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRouteNames.homeScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSvgAsset(String path, {double? height, double? width}) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => const CircularProgressIndicator.adaptive(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgreenish,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      _buildSvgAsset(
                        'assets/splashscreen/arre.svg',
                        height: 70.h,
                        width: 200.w,
                      ),
                      SizedBox(height: 40.h),
                      _buildSvgAsset(
                        'assets/splashscreen/arre_journal.svg',
                        height: 28.h,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: getCustomTextNormal(
                      text: 'Audio journalling made easy!',
                      textSize: 16.sp,
                      textColor: greyTextColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
