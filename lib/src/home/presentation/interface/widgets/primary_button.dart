// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:media_match/shared/data/animation_assets.dart';
import 'package:media_match/shared/data/svg_assets.dart';

class PrimaryButton extends StatefulHookWidget {
  const PrimaryButton({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: GestureDetector(
            onTap: () {
              showOptions.value = false;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: showOptions.value ? MediaQuery.sizeOf(context).width * 0.4 : 0,
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
              child: showOptions.value
                  ? LottieBuilder.asset(
                      AnimationAssets.wiredOutline1037VlogCamera,
                      repeat: false,
                    )
                  : null,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ScaleTransition(
              scale: _controller,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              showOptions.value = !showOptions.value;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: showOptions.value
                  ? MediaQuery.sizeOf(context).width * 0.2
                  : MediaQuery.sizeOf(context).width * 0.6,
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
              child: !showOptions.value
                  ? LottieBuilder.asset(
                      AnimationAssets.wiredOutline1068InternationalMusic,
                      repeat: false,
                    )
                  : Expanded(
                      child: SvgPicture.asset(
                        SvgAssets.cross,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: GestureDetector(
            onTap: () {
              showOptions.value = false;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: showOptions.value ? MediaQuery.sizeOf(context).width * 0.4 : 0,
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
              child: showOptions.value
                  ? LottieBuilder.asset(
                      AnimationAssets.wiredOutline188MicrophoneRecording,
                      repeat: false,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
