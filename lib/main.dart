import 'package:arre/audio_recorder/presentation/provider/player_provider.dart';
import 'package:arre/audio_recorder/presentation/provider/recorder_provider.dart';
import 'package:arre/home/presentation/provider/home_audio_provider.dart';
import 'package:arre/home/presentation/provider/weekly_pager_provider.dart';
import 'package:arre/home/presentation/view/homescreen.dart';
import 'package:arre/routes/app_routes.dart';
import 'package:arre/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeeklyPagerProvider()),
        ChangeNotifierProvider(create: (_) => RecorderProvider()),
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (_) => HomeAudioProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874), // screen size in design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
