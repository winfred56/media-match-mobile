import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:media_match/shared/data/svg_assets.dart';

import '../../../../../entities/audio_search_response.dart';
import '../../../../../entities/shared_preferences.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  Future<List<AudioSearchResponse>> retrieveLocalMatches() async {
    return await SharedPreferencesHelper.getAudioSearchResponseList();
  }

  @override
  Widget build(BuildContext context) {
    String formatDuration(double seconds) {
      final int minutes = seconds ~/ 60;
      final double remainingSeconds = seconds % 60;

      String formattedMinutes = minutes > 0 ? '$minutes min' : '';
      String formattedSeconds =
          remainingSeconds > 0 ? '${remainingSeconds.toStringAsFixed(2)} sec' : '';

      if (minutes > 0 && remainingSeconds > 0) {
        return '$formattedMinutes $formattedSeconds';
      } else if (minutes > 0) {
        return formattedMinutes;
      } else {
        return formattedSeconds;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              SvgAssets.search,
              color: Colors.white,
              height: 18,
            ),
          ),
          const Gap(16),
        ],
      ),
      body: Center(
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
      ),
      // body: FutureBuilder<List<AudioSearchResponse>>(
      //   future: retrieveLocalMatches(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No matches found.'));
      //     } else {
      //       final matches = snapshot.data!.reversed.toList();
      //       return Padding(
      //         padding: const EdgeInsets.only(top: 20),
      //         child: ListView.separated(
      //           itemCount: matches.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             final match = matches[index];
      //             return ListTile(
      //               title: Text(match.fileName.split('.')[0]),
      //               subtitle: Text(formatDuration(match.durationSeconds)),
      //             );
      //           },
      //           separatorBuilder: (BuildContext context, int index) => const Column(
      //             children: [
      //               SizedBox(
      //                 height: 8,
      //               ),
      //               Divider(
      //                 thickness: .3,
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   },
    );
  }
}
