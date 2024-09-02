import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/http_requests/search.dart';
import 'package:media_match/shared/data/animation_assets.dart';
import 'package:media_match/src/home/presentation/interface/pages/audio_search_result.dart';

class VideoLoadingScreen extends HookWidget {
  const VideoLoadingScreen({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    final gibberishIndex = useState(0);
    final isSearchCompleted = useState(false);
    Timer? timer;

    final gibberish = [
      'Hang on for a moment',
      'Almost there, you\'re doing great',
      'This is taking longer than usual',
    ];

    useEffect(() {
      timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (!isSearchCompleted.value) {
          gibberishIndex.value = (gibberishIndex.value + 1) % gibberish.length;
        } else {
          timer.cancel();
        }
      });

      return () {
        timer?.cancel(); // Cancel up timer when widget is disposed
      };
    }, [isSearchCompleted.value]);

    useEffect(() {
      Future<void> fetchData() async {
        final response = await search(videoPath);
        if (context.mounted) {
          isSearchCompleted.value = true; // Stop gibberish updates
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AudioSearchResultPage(
                result: response,
              ),
            ),
          );
        }
      }

      fetchData();
      return null;
    }, []);

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
                AnimationAssets.search,
                frameRate: FrameRate.max,
                reverse: true,
                height: 200,
              ),
              const Gap(20),
              const Text(
                'Searching for result ...',
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
