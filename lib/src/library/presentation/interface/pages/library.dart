import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      String formattedSeconds = remainingSeconds > 0
          ? '${remainingSeconds.toStringAsFixed(2)} sec'
          : '';

      if (minutes > 0 && remainingSeconds > 0) {
        return '$formattedMinutes $formattedSeconds';
      } else if (minutes > 0) {
        return formattedMinutes;
      } else {
        return formattedSeconds;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(
            SvgAssets.settings,
            color: Colors.grey.shade700,
          ),
          onPressed: () {},
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Library',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<List<AudioSearchResponse>>(
        future: retrieveLocalMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No matches found.'));
          } else {
            final matches = snapshot.data!.reversed.toList();
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                itemCount: matches.length,
                itemBuilder: (BuildContext context, int index) {
                  final match = matches[index];
                  return ListTile(
                    title: Text(match.fileName.split('.')[0]),
                    subtitle: Text(formatDuration(match.durationSeconds)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: .3,
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
