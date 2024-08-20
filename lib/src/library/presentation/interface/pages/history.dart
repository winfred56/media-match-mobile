import 'package:gap/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:media_match/entities/local_media.dart';
import 'package:media_match/shared/data/svg_assets.dart';
import 'package:media_match/src/library/presentation/interface/widgets/empty_history.dart';

import '../../../../../entities/shared_preferences.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  Future<List<LocalMedia>> retrieveLocalMatches() async {
    return await SharedPreferencesHelper.getAudioSearchResponseList();
  }

  @override
  Widget build(BuildContext context) {
    // String formatDuration(double seconds) {
    //   final int minutes = seconds ~/ 60;
    //   final double remainingSeconds = seconds % 60;
    //
    //   String formattedMinutes = minutes > 0 ? '$minutes min' : '';
    //   String formattedSeconds = remainingSeconds > 0
    //       ? '${remainingSeconds.toStringAsFixed(2)} sec'
    //       : '';
    //
    //   if (minutes > 0 && remainingSeconds > 0) {
    //     return '$formattedMinutes $formattedSeconds';
    //   } else if (minutes > 0) {
    //     return formattedMinutes;
    //   } else {
    //     return formattedSeconds;
    //   }
    // }

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
        body: FutureBuilder<List<LocalMedia>>(
          future: retrieveLocalMatches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return const EmptyHistory();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const EmptyHistory();
            } else {
              final matches = snapshot.data!.reversed.toList();
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ListView.separated(
                  itemCount: matches.length,
                  itemBuilder: (BuildContext context, int index) {
                    final match = matches[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  match.fileName.split('.').first,
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
                                    timeago.format(match.dateSearched),
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
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 8),
                ),
              );
            }
          },
        ));
  }
}
