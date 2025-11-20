import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  
  // Base colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Brand colors
  static const Color primary = Color(0xFFF15A5A);
  static const Color secondary = Color(0xFFF57070);
  
  // Legacy brand colors (mapped to new colors for backward compatibility)
  static const Color primaryIndigo = Color(0xFFF15A5A); // Maps to primary
  static const Color lightIndigo = Color(0xFFF57070); // Maps to secondary
  static const Color darkIndigo = Color(0xFFD94545); // Darker shade of primary
  static const Color accentPurple = Color(0xFFF57070); // Maps to secondary

  // Theme colors
  static const Color success = Color(0xFF00C853);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF410002);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF410E0E);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF411010);
  static const Color onSurface = Color(0xFF191C20);
  static const Color onSurfaceVariant = Color(0xFF43474E);
  static const Color hintTextColor = Color(0xFFCCCCCC);
  static const Color outline = Color(0xFF73777F);
  static const Color outlineVariant = Color(0xFFC3C7CF);
  static const Color primaryContainer = Color(0xFFFFE5E5);
  static const Color scrim = Color(0xFF000000);
  static const Color secondaryContainer = Color(0xFFFFE8E8);
  static const Color shadow = Color(0xFF000000);
  static const Color surface = Color.fromARGB(255, 255, 255, 255);
  static const Color surfaceContainerHighest = Color(0xFFE1E1E1);
  static const Color surfaceTint = Color(0xFFF15A5A);
  
  // Additional theme colors for cards and inputs
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE1E1E1);
  static const Color inputBackground = Color(0xFFF9FAFB);
  static const Color divider = Color(0xFFE1E1E1);
  static const Color textPrimary = Color(0xFF191C20);
  static const Color textSecondary = Color(0xFF757575);

  // Greys
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey600 = Color(0xFF757575);
  
  // Surface variants
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  
  // Light pink background for selected cards
  static const Color selectedCardBackground = Color(0xFFFFF5F5);
}