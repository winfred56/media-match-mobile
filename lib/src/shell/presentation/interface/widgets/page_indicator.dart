import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.offset,
    required this.pages,
  });

  final ValueNotifier<double> offset;
  final List<StatelessWidget> pages;

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      offset: offset.value,
      count: pages.length,
      effect: const WormEffect(
        dotWidth: 8,
        dotHeight: 8,
        spacing: 15,
        activeDotColor: Colors.white,
        dotColor: Colors.grey,
        type: WormType.thin,
      ),
      size: const Size(50, 1),
    );
  }
}
