import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_match/src/home/presentation/interface/pages/home.dart';
import 'package:media_match/src/library/presentation/interface/pages/library.dart';
import 'package:media_match/src/shell/presentation/interface/widgets/page_indicator.dart';

class Shell extends HookWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final offset = useState(1.0);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // Jump to the second page when the screen is mounted
        controller.jumpToPage(1);
      });

      controller.addListener(() {
        // Set the offset to the current page of the page view or
        //assign it to the initial page of the pageview if the page view isn't moved.
        offset.value = controller.page ?? controller.initialPage.toDouble();
      });
    });

    final pages = [
      const LibraryPage(),
      HomePage(controller: controller),
      // const AnalyticsPage()
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
                child: PageIndicator(offset: offset, pages: pages),
              ),
            ),
          )
        ],
      ),
    );
  }
}
