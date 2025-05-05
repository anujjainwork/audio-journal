import 'package:arre/audio_recorder/presentation/provider/player_provider.dart';
import 'package:arre/audio_recorder/presentation/provider/recorder_provider.dart';
import 'package:arre/audio_recorder/presentation/view/audio_recording_screen.dart';
import 'package:arre/audio_recorder/presentation/view/save_recording_screen.dart';
import 'package:arre/audio_recorder/presentation/widgets/recorder_appbar.dart';
import 'package:arre/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  int currentIndex = 0;

  void goBack() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void goNext() {
    if (currentIndex < pages.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  List<Widget> get pages =>
      [RecorderScreen(goNext: goNext), const SaveRecordingScreen()];

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context, listen: true);
    return ChangeNotifierProvider(
      create: (_) => RecorderProvider(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: RecorderAppbar(
          currentIndex: currentIndex,
          totalSteps: pages.length,
          onBack: goBack,
          onCancel: () {
            audioProvider.reset();
            Navigator.pop(context);
          },
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
