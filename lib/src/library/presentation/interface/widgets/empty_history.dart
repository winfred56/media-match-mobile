import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/data/svg_assets.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgAssets.filmSlash,
            color: Colors.grey,
            height: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'You have no matches yet.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ].animate(interval: 200.milliseconds).fadeIn().slideY(begin: 0.1),
      ),
    );
  }
}
