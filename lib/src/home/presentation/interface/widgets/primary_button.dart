import 'dart:io';
import 'dart:async';

import 'package:record/record.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:lordicon/lordicon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:media_match/shared/data/svg_assets.dart';
import 'package:media_match/shared/data/animation_assets.dart';
import 'package:media_match/src/home/presentation/interface/pages/record_audio.dart';

import '../../../../../http_requests/search.dart';
import '../pages/audio_search_result.dart';

class PrimaryButton extends StatefulHookWidget {
  const PrimaryButton({super.key});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showOptions = useState(false);

    /// Instance of record
    final record = Record();
    ValueNotifier<String> recordedFilePath = ValueNotifier<String>('');
    Timer? autoStopTimer;

    /// Stop recording and search database for a match
    Future<void> stopRecording() async {
      print('10 seconds up ===>');
      recordedFilePath.value = (await record.stop())!;
      autoStopTimer?.cancel();
      print('file source: ${recordedFilePath.value}');

      if (recordedFilePath.value.isNotEmpty) {
        var file = File(recordedFilePath.value);
        if (await file.exists()) {
          search(recordedFilePath.value).then(
            (result) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AudioSearchResultPage(result: result),
              ),
            ),
          );
        } else {
          print('File does not exist');
        }
      } else {
        print('Recording file path is null or empty');
      }
    }

    Future<void> recordAudio() async {
      print('===== = == = = = Job started');
      // Check and request permission
      if (await record.hasPermission()) {
        // Get temporary directory for storing the recording
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String filePath = '$tempPath/recording.m4a';

        // Start recording
        await record.start(
          path: filePath,
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );

        // Auto stop recording after 10 seconds and search database
        autoStopTimer = Timer(const Duration(seconds: 10), () {
          stopRecording();
        });
      } else {
        print('Recording permission not granted');
      }
    }

    var mediaMatchAnimation = IconController.assets(
        AnimationAssets.systemrEgular715SpinnerHorizontalDashedCircle);

    mediaMatchAnimation.addStatusListener((status) {
      if (status == ControllerStatus.ready) {
        mediaMatchAnimation.playFromBeginning();
      }
    });

    const boxWidthToScreenWidthRatio = 0.3646;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showOptions.value = false;
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, child, animation) {
                return RecordAudioPage(
                  recordAudio: recordAudio,
                  stopRecording: stopRecording,
                );
              },
            ));
          },
          child: AnimatedContainer(
            duration: 300.milliseconds,
            height: showOptions.value
                ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width
                : 0,
            width: showOptions.value
                ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width
                : 0,
            margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: const Border(top: BorderSide(color: Colors.white54)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade400,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade700,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: SvgPicture.asset(SvgAssets.microphone),
            ),
          ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
        ),

        //! ///////
        GestureDetector(
          onTap: () {
            showOptions.value = !showOptions.value;
          },
          child: AnimatedContainer(
            duration: 300.milliseconds,
            height: showOptions.value
                ? 70
                : boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
            width: showOptions.value
                ? 70
                : boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: const Border(top: BorderSide(color: Colors.white54)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade300,
                  Colors.blue.shade400,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade700,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ScaleTransition(
                  scale: _controller,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: !showOptions.value
                    ? IconViewer(controller: mediaMatchAnimation)
                    : SvgPicture.asset(
                        SvgAssets.cross,
                        color: Colors.white,
                        height: 20,
                        width: 20,
                      ),
              ),
            ),
          ),
        ),

        //! //////////////

        AnimatedContainer(
          duration: 300.milliseconds,
          height: showOptions.value
              ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width
              : 0,
          width: showOptions.value
              ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width
              : 0,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: const Border(top: BorderSide(color: Colors.white54)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade300,
                Colors.blue.shade300,
                Colors.blue.shade300,
                Colors.blue.shade400,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade700,
                blurRadius: 5,
                offset: const Offset(0, 2),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: SvgPicture.asset(SvgAssets.cameraMovie),
          ),
        ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
      ],
    );
  }
}
