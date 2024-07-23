import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Media Match Trends',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
