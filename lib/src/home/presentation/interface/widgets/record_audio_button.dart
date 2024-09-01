import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_match/shared/data/animation_assets.dart';
import 'package:media_match/src/home/presentation/interface/pages/record_audio_page.dart';

class RecordAudioButton extends HookWidget {
  const RecordAudioButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleUp = useState(false);

    useMemoized(() async {
      await Future.delayed(const Duration(milliseconds: 300));
      scaleUp.value = true;
    });

    return SizedBox(
      height: screenWidth * 0.60,
      width: screenWidth * 0.60,
      child: Center(
        child: GestureDetector(
          onPanDown: (details) {
            scaleUp.value = false;
          },
          onPanCancel: () {
            scaleUp.value = true;
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: const RecordAudioPage(),
                  );
                },
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: screenWidth * (scaleUp.value ? 0.60 : 0.5),
            width: screenWidth * (scaleUp.value ? 0.60 : 0.5),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border(
                bottom: BorderSide(color: Colors.white24),
              ),
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: LottieBuilder.asset(
                AnimationAssets.recordingAppear,
                frameRate: FrameRate.max,
                repeat: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
