// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_match/shared/data/svg_assets.dart';
import 'package:media_match/shared/presentation/theme/theme_extensions.dart';
import 'package:media_match/src/home/presentation/interface/widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.controller,
  });
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final boxDecorationExtensions = Theme.of(context).extension<BoxDecorationExtension>()!;

    return Container(
      decoration: boxDecorationExtensions.homeBackground,
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
              controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              );
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const SafeArea(
            child: Center(
          child: PrimaryButton(),
        )),
      ),
    );
  }
}
