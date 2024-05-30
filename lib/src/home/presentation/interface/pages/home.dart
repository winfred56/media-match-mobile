// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_match/shared/data/svg_assets.dart';
import 'package:media_match/src/home/presentation/interface/widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.controller,
  });
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
            Colors.blue.shade900,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          title: GestureDetector(
            onTap: () {
              controller.animateToPage(0,
                  duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  SvgAssets.albumCirclePlus,
                  color: Colors.white,
                  height: 20,
                ),
                const SizedBox(height: 2),
                const Text(
                  'Library',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        body: const SafeArea(
            child: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Spacer(),
                // const Text(
                //   'Tap to Media Match',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18,
                //   ),
                // ),
                // const SizedBox(height: 50),
                PrimaryButton(),
                // const SizedBox(height: 90),
                // Container(
                //   height: 60,
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: const Border(top: BorderSide(color: Colors.white54)),
                //     gradient: LinearGradient(
                //       colors: [
                //         Colors.blue.shade400,
                //         Colors.blue.shade500,
                //         Colors.blue.shade500,
                //         Colors.blue.shade600,
                //       ],
                //     ),
                //   ),
                //   child: SvgPicture.asset(
                //     SvgAssets.upload,
                //     height: 25,
                //     color: Colors.white,
                //   ),
                // ),
                // const Spacer(flex: 2),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
