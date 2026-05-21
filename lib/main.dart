import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Tailored',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.primary,
          primaryContainer: AppColors.primaryContainer,
          secondary: AppColors.secondary,
          onSurface: AppColors.onSurface,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.onSecondary,
        ),
        // fontFamily: 'Plus Jakarta Sans',
        // fontFamilyFallback: [
          // 'Apple Color Emoji',
          // 'Segoe UI Emoji',
          // 'Noto Color Emoji',
        // ],
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            color: AppColors.onSurface,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: AppColors.onSurface,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            letterSpacing: 1.8,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
