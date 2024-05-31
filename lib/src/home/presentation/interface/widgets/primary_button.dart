// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lordicon/lordicon.dart';
import 'package:media_match/shared/data/animation_assets.dart';
import 'package:media_match/shared/data/svg_assets.dart';

class PrimaryButton extends StatefulHookWidget {
  const PrimaryButton({super.key});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with TickerProviderStateMixin {
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

    var mediaMatchAnimation =
        IconController.assets(AnimationAssets.systemrEgular715SpinnerHorizontalDashedCircle);
    var microphoneAnimation = IconController.assets(AnimationAssets.wiredOutline1037VlogCamera);
    var cameraAnimation = IconController.assets(AnimationAssets.wiredOutline188MicrophoneRecording);

    mediaMatchAnimation.addStatusListener((status) {
      if (status == ControllerStatus.ready) {
        mediaMatchAnimation.playFromBeginning();
      }
    });

    const boxWidthToScreenWidthRatio = 0.3646;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: 300.milliseconds,
          height:
              showOptions.value ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width : 0,
          width:
              showOptions.value ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width : 0,
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
            child: showOptions.value ? IconViewer(controller: cameraAnimation) : null,
          ),
        ).animate().fadeIn().scaleXY(duration: 300.milliseconds),

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
          height:
              showOptions.value ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width : 0,
          width:
              showOptions.value ? boxWidthToScreenWidthRatio * MediaQuery.sizeOf(context).width : 0,
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
            child: showOptions.value ? IconViewer(controller: microphoneAnimation) : null,
          ),
        ).animate().fadeIn().scaleXY(duration: 300.milliseconds),
      ],
    );
  }
}
