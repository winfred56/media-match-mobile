// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_match/shared/data/svg_assets.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
