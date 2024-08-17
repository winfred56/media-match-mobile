import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/shared/data/animation_assets.dart';

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

// class PrimaryButton extends StatefulHookWidget {
//   const PrimaryButton({super.key});

//   @override
//   _PrimaryButtonState createState() => _PrimaryButtonState();
// }

// class _PrimaryButtonState extends State<PrimaryButton>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       lowerBound: 0.95,
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showOptions = useState(false);

//     /// Instance of record
//     final record = Record();
//     ValueNotifier<String> recordedFilePath = ValueNotifier<String>('');
//     Timer? autoStopTimer;

//     /// Stop recording and search database for a match
//     Future<void> stopRecording() async {
//       print('10 seconds up ===>');

//       recordedFilePath.value = (await record.stop())!;
//       autoStopTimer?.cancel();
//       print('file source: ${recordedFilePath.value}');

//       if (recordedFilePath.value.isNotEmpty) {
//         var file = File(recordedFilePath.value);
//         if (await file.exists()) {
//           try {
//             search(recordedFilePath.value).then(
//               (result) async {
//                 HapticFeedback.heavyImpact();
//                 await SharedPreferencesHelper.addAudioSearchResponse(result);
//                 if (context.mounted) {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => AudioSearchResultPage(result: result),
//                     ),
//                   );
//                 }
//               },
//             );
//           } on Exception catch (e) {
//             print(e.toString());
//             final snackBar = SnackBar(
//               elevation: 0,
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.transparent,
//               content: AwesomeSnackbarContent(
//                 title: 'On Snap!',
//                 message:
//                 'This was tough, we couldn\'t find a match! When you recognize it please update our database for others to find a match next time',

//                 /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//                 contentType: ContentType.failure,
//               ),
//             );
//             if(context.mounted) {
//               ScaffoldMessenger.of(context)
//                 ..hideCurrentSnackBar()
//                 ..showSnackBar(snackBar);
//             }
//           }
//         } else {
//           print('File does not exist');
//         }
//       } else {
//         print('Recording file path is null or empty');
//       }
//     }

//     Future<void> recordAudio() async {
//       print('===== = == = = = Job started');
//       // Check and request permission
//       if (await record.hasPermission()) {
//         /// Get temporary directory for storing the recording
//         Directory tempDir = await getTemporaryDirectory();
//         String tempPath = tempDir.path;
//         String filePath = '$tempPath/recording.m4a';

//         /// Start recording
//         await record.start(
//           path: filePath,
//           encoder: AudioEncoder.aacLc,
//           bitRate: 128000,
//           samplingRate: 44100,
//         );

//         /// Auto stop recording after 10 seconds and search database
//         autoStopTimer = Timer(const Duration(seconds: 10), () {
//           stopRecording();
//         });
//       } else {
//         print('Recording permission not granted');
//       }
//     }

//     cancelRecording() async {
//       await record.stop();
//       if (context.mounted) Navigator.pop(context);
//     }

//     var mediaMatchAnimation = IconController.assets(
//         AnimationAssets.systemrEgular715SpinnerHorizontalDashedCircle);

//     mediaMatchAnimation.addStatusListener((status) {
//       if (status == ControllerStatus.ready) {
//         mediaMatchAnimation.playFromBeginning();
//       }
//     });

//     const boxWidthToScreenWidthRatio = 0.3646;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (showOptions.value) ...[
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, PageRouteBuilder(
//                 pageBuilder: (context, child, animation) {
//                   return RecordAudioPage(
//                     recordAudio: recordAudio,
//                     stopRecording: stopRecording,
//                     cancelRecording: cancelRecording,
//                   );
//                 },
//               ));
//             },
//             child: AnimatedContainer(
//               duration: 300.milliseconds,
//               height:
//                   boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//               width:
//                   boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//               margin: const EdgeInsets.only(bottom: 30),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: const Border(top: BorderSide(color: Colors.white54)),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade400,
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.shade700,
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(40),
//                 child: SvgPicture.asset(SvgAssets.microphone),
//               ),
//             ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
//           ),
//         ],
//         GestureDetector(
//           onTap: () {
//             showOptions.value = !showOptions.value;
//           },
//           child: AnimatedContainer(
//             duration: 300.milliseconds,
//             height:
//                 boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//             width:
//                 boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//             margin: const EdgeInsets.only(bottom: 30),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: const Border(top: BorderSide(color: Colors.white54)),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.blue.shade300,
//                   Colors.blue.shade300,
//                   Colors.blue.shade300,
//                   Colors.blue.shade300,
//                   Colors.blue.shade400,
//                 ],
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blue.shade700,
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                   spreadRadius: 1,
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(40),
//               child: showOptions.value
//                   ? SvgPicture.asset(SvgAssets.cross)
//                   : IconViewer(controller: mediaMatchAnimation),
//             ),
//           ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
//         ),
//         if (showOptions.value) ...[
//           GestureDetector(
//             onTap: () async {
//               final ImagePicker picker = ImagePicker();
//               final XFile? video =
//                   await picker.pickVideo(source: ImageSource.camera);
//               if (video != null) {
//                 print('Video path: ${video.path}');
//                 search(video.path);
//               } else {
//                 print('No video recorded');
//               }
//             },
//             child: AnimatedContainer(
//               duration: 300.milliseconds,
//               height:
//                   boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//               width:
//                   boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width,
//               margin: const EdgeInsets.only(top: 30),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: const Border(top: BorderSide(color: Colors.white54)),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade300,
//                     Colors.blue.shade400,
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.shade700,
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(40),
//                 child: SvgPicture.asset(SvgAssets.cameraMovie),
//               ),
//             ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
//           ),
//         ]
//       ],
//     );
//   }
// }


