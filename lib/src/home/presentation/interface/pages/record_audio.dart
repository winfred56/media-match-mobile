import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/shared/data/animation_assets.dart';

class RecordAudioPage extends HookWidget {
  const RecordAudioPage({
    super.key,
    required this.recordAudio,
    required this.stopRecording,
  });

  final Function() recordAudio;
  final Function() stopRecording;

  @override
  Widget build(BuildContext context) {
    useMemoized(() {
      recordAudio();
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
            Colors.blue.shade900,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: CloseButton(
            onPressed: () {
              stopRecording();
              Navigator.pop(context);
            },
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Center(
                child: LottieBuilder.asset(
                  AnimationAssets.audio,
                  frameRate: FrameRate.max,
                ),
              ),
              const Spacer(flex: 2),
              const Text(
                'Listening for media...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).animate(delay: 1.seconds).fadeIn(),
              const Text(
                'Make sure you device can hear the audio clearly',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(delay: 1.5.seconds).fadeIn(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
