// ignore_for_file: deprecated_member_use

import 'package:gap/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/record_audio_button.dart';
import '../../../../../shared/data/svg_assets.dart';
import '../../../../../http_requests/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void animateToPage(int index) {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () => animateToPage(0),
          icon: SvgPicture.asset(
            SvgAssets.timePast,
            color: Colors.white,
            height: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => animateToPage(2),
            icon: SvgPicture.asset(
              SvgAssets.chartHistogram,
              color: Colors.white,
              height: 18,
            ),
          ),
          const Gap(16),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                'Tap to record',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),
              const RecordAudioButton(),
              const Gap(20),
              const Spacer(),
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? video =
                      await picker.pickVideo(source: ImageSource.camera);
                  if (video != null) {
                    if (kDebugMode) {
                      print('Video path: ${video.path}');
                    }
                    search(video.path);
                  } else {
                    if (kDebugMode) {
                      print('No video recorded');
                    }
                  }
                },
                child: SvgPicture.asset(
                  SvgAssets.cameraMovie,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
