import 'package:flutter/material.dart';
import 'package:media_match/shared/presentation/theme/theme.dart';
import 'package:media_match/src/shell/presentation/interface/pages/shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media match',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const Shell(),
    );
  }
}
