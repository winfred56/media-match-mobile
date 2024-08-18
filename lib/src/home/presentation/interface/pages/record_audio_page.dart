import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/shared/data/animation_assets.dart';

class RecordAudioPage extends HookWidget {
  const RecordAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gibberishIndex = useState(0);

    final gibberish = [
      'Make sure your device can here the sound clearly',
      'Hang on for a moment',
      'Almost there, you\'re doing great',
      'This is taking longer than usual',
    ];

    useMemoized(() {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        gibberishIndex.value = (gibberishIndex.value + 1) % gibberish.length;
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                AnimationAssets.recording,
                frameRate: FrameRate.max,
                reverse: true,
                height: 200,
              ),
              const Gap(20),
              const Text(
                'Listening for music',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
                child: Text(
                  gibberish[gibberishIndex.value],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fade(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
