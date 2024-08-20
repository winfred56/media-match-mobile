import 'package:flutter/material.dart';
import 'package:media_match/shared/presentation/theme/theme_extensions.dart';

class AppTheme {
  ColorScheme _colorScheme() {
    return ColorScheme.fromSeed(
      seedColor: Colors.blue,
    );
  }

  AppBarTheme _appBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ListTileThemeData _listTileTheme() {
    return ListTileThemeData(
      tileColor: Colors.white,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  BoxDecorationExtension _boxDecorationExtension() {
    return BoxDecorationExtension(
      homeBackground: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade500,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
            Colors.blue.shade900,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme(),
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 33, 43),
        fontFamily: 'Montserrat',
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        extensions: <ThemeExtension>{
          _boxDecorationExtension(),
        },
        appBarTheme: _appBarTheme(),
        listTileTheme: _listTileTheme(),
        cardTheme: const CardTheme(
          color: Colors.black54,
          margin: EdgeInsets.all(0),
        ));
  }
}
