import 'dart:io';
import 'dart:async';

import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/entities/local_media.dart';
import 'package:record/record.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'audio_search_result.dart';
import '../../../../../http_requests/search.dart';
import '../../../../../shared/data/animation_assets.dart';
import '../../../../../entities/shared_preferences.dart';

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

    /// Instance of record
    final record = Record();
    ValueNotifier<String> recordedFilePath = ValueNotifier<String>('');
    Timer? autoStopTimer;

    Future<void> stopRecording() async {
      if (kDebugMode) {
        print('10 seconds up ===>');
      }

      recordedFilePath.value = (await record.stop())!;
      autoStopTimer?.cancel();
      if (kDebugMode) {
        print('file source: ${recordedFilePath.value}');
      }

      if (recordedFilePath.value.isNotEmpty) {
        var file = File(recordedFilePath.value);
        if (await file.exists()) {
          try {
            search(recordedFilePath.value).then(
              (result) async {
                HapticFeedback.heavyImpact();
                final localMedia = LocalMedia(
                    id: result.id,
                    fileName: result.fileName,
                    dateSearched: DateTime.now(),
                    durationSeconds: result.durationSeconds);
                await SharedPreferencesHelper.addAudioSearchResponse(
                    localMedia);
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          AudioSearchResultPage(result: result),
                    ),
                  );
                }
              },
            );
          } on Exception catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message:
                    'This was tough, we couldn\'t find a match! When you recognize it please update our database for others to find a match next time',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.failure,
              ),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          }
        } else {
          if (kDebugMode) {
            print('File does not exist');
          }
        }
      } else {
        if (kDebugMode) {
          print('Recording file path is null or empty');
        }
      }
    }

    Future<void> cancelRecording() async {
      await record.stop();
      if (context.mounted) Navigator.pop(context);
    }

    Future<void> recordAudio() async {
      if (kDebugMode) {
        print('===== = == = = = Job started');
      }
      // Check and request permission
      if (await record.hasPermission()) {
        /// Get temporary directory for storing the recording
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String filePath = '$tempPath/recording.m4a';

        /// Start recording
        await record.start(
          path: filePath,
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );

        /// Auto stop recording after 10 seconds and search database
        autoStopTimer = Timer(const Duration(seconds: 10), () {
          stopRecording();
        });
      } else {
        if (kDebugMode) {
          print('Recording permission not granted');
        }
      }
    }

    useMemoized(() {
      Timer.periodic(const Duration(seconds: 10), (timer) {
        gibberishIndex.value = (gibberishIndex.value + 1) % gibberish.length;
      });
    });

    useEffect((){
      recordAudio();
      return;
    },[]);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: CloseButton(onPressed: cancelRecording),
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
