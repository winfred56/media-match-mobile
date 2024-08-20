// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:media_match/entities/monthly_requests.dart';
import 'package:media_match/entities/most_matched.dart';
import 'package:media_match/entities/songs_searched_today.dart';
import 'package:media_match/http_requests/analytics.dart' as analytics;
import 'package:media_match/shared/data/svg_assets.dart';

class AnalyticsPage extends HookWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final requestsPerMonth = useState<MonthlyRequests?>(null); //
    final searchesMadeToday = useState<List<SearchedToday>?>(null);
    final totalRequestsThisYear = useState<int?>(null); //
    final averageWeeklySearches = useState<double?>(null); //
    final mostMatchedSongs = useState<List<MostMatched>?>(null); //
    final mostMatchedVideos = useState<List<MostMatched>?>(null); //
    final loading = useState(false);

    getAllAnalytics() async {
      /// Returns [MonthlyRequests]
      requestsPerMonth.value = await analytics.requestsPerMonth();

      /// Returns a [List<SearchedToday>]
      searchesMadeToday.value = await analytics.searchesMadeToday();

      /// Returns an [int]
      totalRequestsThisYear.value = await analytics.totalRequestsThisYear();

      /// Returns a [double]
      averageWeeklySearches.value = await analytics.averageWeeklySearches();

      /// Returns top 3 [MostMatched] Songs/Audios
      mostMatchedSongs.value = await analytics.mostMatchedSongs();

      /// Returns top 3 [MostMatched] Videos
      mostMatchedVideos.value = await analytics.mostMatchedVideos();
    }

    useMemoized(() async {
      loading.value = true;
      await getAllAnalytics();
      loading.value = false;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              SvgAssets.fileDownload,
              color: Colors.grey,
              height: 18,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: loading.value
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                  ),
                ),
              )
            : Builder(
                builder: (context) {
                  if (requestsPerMonth.value == null &&
                      searchesMadeToday.value == null &&
                      totalRequestsThisYear.value == null &&
                      averageWeeklySearches.value == null &&
                      mostMatchedSongs.value == null &&
                      mostMatchedVideos.value == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgAssets.stats,
                            color: Colors.grey,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Media Match analytics will be here.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Media match needs enough data from your usage to show you more analytics.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ]
                            .animate(interval: 200.milliseconds)
                            .fadeIn()
                            .slideY(begin: 0.1),
                      ),
                    );
                  }

                  return ListView(
                    children: [
                      if (requestsPerMonth.value != null) ...[
                        const Text(
                          'Requests per month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(10),
                        _RequestsPerMonth(requests: requestsPerMonth.value!),
                      ],
                      if (totalRequestsThisYear.value != null) ...[
                        const Gap(10),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        totalRequestsThisYear.value.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ${totalRequestsThisYear.value == 1 ? 'request' : 'requests'} made this year',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (averageWeeklySearches.value != null) ...[
                        const Gap(10),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: averageWeeklySearches.value!
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ${averageWeeklySearches.value == 1 ? 'request' : 'requests'}/week (average)',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (mostMatchedSongs.value?.isNotEmpty ?? false) ...[
                        const Gap(20),
                        const Text(
                          'Most matched songs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          mostMatchedSongs
                                              .value![index].fileName
                                              .split('.')
                                              .first,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                        Flexible(
                                          child: Text(
                                            '${mostMatchedSongs.value![index].matchCount.toString()}x',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(10),
                          itemCount: mostMatchedSongs.value!.length,
                        ),
                      ],

                      if (mostMatchedVideos.value?.isNotEmpty ?? false) ...[
                        const Gap(20),
                        const Text(
                          'Most matched videos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          mostMatchedVideos
                                              .value![index].fileName
                                              .split('.')
                                              .first,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          mostMatchedVideos
                                              .value![index].matchCount
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(10),
                          itemCount: mostMatchedVideos.value!.length,
                        ),
                      ],
                      // if (searchesMadeToday.value?.isNotEmpty ?? false) ...[
                      //   const Gap(20),
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const Text(
                      //         'Searches made today',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //       Transform.translate(
                      //         offset: const Offset(10, 0),
                      //         child: IconButton(
                      //           onPressed: () {},
                      //           icon: const Icon(
                      //             Icons.arrow_forward_ios,
                      //             color: Colors.grey,
                      //             size: 16,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   const Gap(10),
                      //   GridView.count(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     crossAxisCount: 2,
                      //     children: searchesMadeToday.value!
                      //         .map(
                      //           (search) => Card(
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     search.mediaName,
                      //                     style: const TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: 16,
                      //                     ),
                      //                   ),
                      //                   const Gap(5),
                      //                   Text(
                      //                     search.timestamp.toString(),
                      //                     style: const TextStyle(
                      //                       color: Colors.grey,
                      //                       fontSize: 12,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //         .toList(),
                      //   )
                      // ],
                    ],
                  );
                },
              ),
      ),
    );
  }
}

class _RequestsPerMonth extends HookWidget {
  const _RequestsPerMonth({required this.requests});

  final MonthlyRequests requests;

  @override
  Widget build(BuildContext context) {
    final maximumRequests =
        requests.toJson().values.reduce((a, b) => a > b ? a : b);
    final animate = useState(false);

    useMemoized(() async {
      await Future.delayed(200.milliseconds);
      animate.value = true;
    });

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: requests
                      .toJson()
                      .values
                      .map(
                        (value) => Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (value != 0)
                                  Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                AnimatedContainer(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  curve: Curves.easeInOut,
                                  duration: 200.milliseconds,
                                  width: 5,
                                  height: animate.value || value == 0
                                      ? (value / maximumRequests) *
                                          (constraints.maxHeight - 25)
                                      : 5,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: requests
                    .toJson()
                    .keys
                    .map(
                      (key) => Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            key.substring(0, 3),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
