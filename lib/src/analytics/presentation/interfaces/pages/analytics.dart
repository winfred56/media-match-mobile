import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_match/shared/data/svg_assets.dart';

import '../../../../../http_requests/analytics.dart';

class AnalyticsPage extends HookWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {

    getAllAnalytics()async{
      await requestsPerMonth(); /// Returns [MonthlyRequests]
      await searchesMadeToday(); /// Returns a [List<SearchedToday>]
      await totalRequestsThisYear(); /// Returns an [int]
      await averageWeeklySearches(); /// Returns a [double]
      await mostMatchedSongs(); /// Returns top 3 [MostMatched] Songs/Audios
      await mostMatchedVideos(); /// Returns top 3 [MostMatched] Videos
    }
    useEffect((){
      getAllAnalytics();
     return;
    },[]);

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
        child: Center(
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
                'Your analytics will be here.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Media match needs enough data from your usage to show you analytics.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ].animate(interval: 200.milliseconds).fadeIn().slideY(begin: 0.1),
          ),
        ),
      ),
    );
  }
}
