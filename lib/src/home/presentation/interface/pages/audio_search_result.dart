import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:media_match/entities/audio_search_response.dart';
import 'package:media_match/shared/data/image_assets.dart';
import 'package:media_match/shared/presentation/theme/theme_extensions.dart';

class AudioSearchResultPage extends StatelessWidget {
  const AudioSearchResultPage({super.key, required this.result});

  final AudioSearchResponse result;

  @override
  Widget build(BuildContext context) {
    String formatDuration(double seconds) {
      final int minutes = seconds ~/ 60;
      final double remainingSeconds = seconds % 60;

      String formattedMinutes = minutes > 0 ? '$minutes min' : '';
      String formattedSeconds = remainingSeconds > 0 ? '${remainingSeconds.round()} sec' : '';

      if (minutes > 0 && remainingSeconds > 0) {
        return '$formattedMinutes $formattedSeconds';
      } else if (minutes > 0) {
        return formattedMinutes;
      } else {
        return formattedSeconds;
      }
    }

    String image() {
      final name = result.fileName.split('.')[0];

      if (name.toLowerCase().contains('koda')) return ImageAssets.koda;
      if (name.toLowerCase().contains('diana')) return ImageAssets.dianaHamilton;
      if (name.toLowerCase().contains('despicable')) return ImageAssets.minions;
      return ImageAssets.joy;
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image()),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            leading: const BackButton(),
            // title: const Text(
            //   'Result',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //   ),
            // ),
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  result.fileName.split('.')[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  formatDuration(result.durationSeconds),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 50),
              ].animate(interval: 700.milliseconds).fadeIn(),
            ),
          ),
        ),
      ],
    );
  }
}
