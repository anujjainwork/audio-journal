import 'package:arre/audio_recorder/presentation/view/recording_screen.dart';
import 'package:arre/home/presentation/view/homescreen.dart';
import 'package:arre/routes/routes_fading_animation.dart';
import 'package:flutter/material.dart';

class AppRouteNames {
  static const homeScreen = 'homeScreen';
  static const recordingScreen = 'recordingScreen';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.homeScreen:
        return _buildFadePageRoute(
          const Homescreen(),
          name: AppRouteNames.homeScreen,
        );
      case AppRouteNames.recordingScreen:
        return _buildFadePageRoute(
          const RecordingScreen(),
          name: AppRouteNames.recordingScreen,
        );
      default:
        return _buildFadePageRoute(const Scaffold());
    }
  }

  static Route<dynamic> _buildFadePageRoute(Widget widget, {String? name}) {
    return FadePageRoute(
      page: widget,
      duration: const Duration(milliseconds: 200),
    );
  }
}