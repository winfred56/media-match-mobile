import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_match/src/home/presentation/interface/pages/home.dart';
import 'package:media_match/src/library/presentation/interface/pages/library.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Shell extends HookWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final offset = useState(1.0);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.jumpToPage(1);
      });

      controller.addListener(() {
        offset.value = controller.page ?? controller.initialPage.toDouble();
      });
    });

    final pages = [
      const LibraryPage(),
      HomePage(controller: controller),
      Container(color: Colors.white),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: pages,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SmoothIndicator(
                  offset: offset.value,
                  count: pages.length,
                  effect: WormEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    spacing: 15,
                    activeDotColor: offset.value.round() == 1 ? Colors.white : Colors.blue,
                    dotColor: offset.value.round() == 1 ? Colors.white54 : Colors.grey,
                    type: WormType.thin,
                  ),
                  size: const Size(50, 1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
