import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

@immutable
class IconSizes extends ThemeExtension<IconSizes> {
  final double xs; // e.g. 12
  final double sm; // e.g. 16
  final double md; // e.g. 20
  final double lg; // e.g. 24
  final double xl; // e.g. 28
  final double xxl; // e.g. 32

  const IconSizes({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  @override
  IconSizes copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return IconSizes(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  IconSizes lerp(ThemeExtension<IconSizes>? other, double t) {
    if (other is! IconSizes) return this;

    return IconSizes(
      xs: lerpDouble(xs, other.xs, t),
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      xl: lerpDouble(xl, other.xl, t),
      xxl: lerpDouble(xxl, other.xxl, t),
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

@immutable
class ImageSizes extends ThemeExtension<ImageSizes> {
  final double thumb; // small square thumbnails
  final double card; // typical card width/height hint for lists
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;

  const ImageSizes({
    required this.thumb,
    required this.card,
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,
  });

  @override
  ImageSizes copyWith({
    double? thumb,
    double? card,
    double? avatarSm,
    double? avatarMd,
    double? avatarLg,
  }) {
    return ImageSizes(
      thumb: thumb ?? this.thumb,
      card: card ?? this.card,
      avatarSm: avatarSm ?? this.avatarSm,
      avatarMd: avatarMd ?? this.avatarMd,
      avatarLg: avatarLg ?? this.avatarLg,
    );
  }

  @override
  ImageSizes lerp(ThemeExtension<ImageSizes>? other, double t) {
    if (other is! ImageSizes) return this;

    return ImageSizes(
      thumb: IconSizes.lerpDouble(thumb, other.thumb, t),
      card: IconSizes.lerpDouble(card, other.card, t),
      avatarSm: IconSizes.lerpDouble(avatarSm, other.avatarSm, t),
      avatarMd: IconSizes.lerpDouble(avatarMd, other.avatarMd, t),
      avatarLg: IconSizes.lerpDouble(avatarLg, other.avatarLg, t),
    );
  }
}

@immutable
class ShimmerColors extends ThemeExtension<ShimmerColors> {
  final Color base;
  final Color highlight;

  const ShimmerColors({
    required this.base,
    required this.highlight,
  });

  @override
  ShimmerColors copyWith({
    Color? base,
    Color? highlight,
  }) {
    return ShimmerColors(
      base: base ?? this.base,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  ShimmerColors lerp(ThemeExtension<ShimmerColors>? other, double t) {
    if (other is! ShimmerColors) return this;
    return ShimmerColors(
      base: Color.lerp(base, other.base, t) ?? base,
      highlight: Color.lerp(highlight, other.highlight, t) ?? highlight,
    );
  }
}

extension ThemeExtensionHelper on ThemeData {
  IconSizes get iconSizes => extension<IconSizes>()!;
  ImageSizes get imageSizes => extension<ImageSizes>()!;
  ShimmerColors? get shimmerColors => extension<ShimmerColors>();
}

class AppTheme {

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        error: AppColors.error,
        errorContainer: AppColors.errorContainer,
        onError: AppColors.onError,
        onErrorContainer: AppColors.onErrorContainer,
        onPrimary: AppColors.onPrimary,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        onSecondary: AppColors.onSecondary,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        scrim: AppColors.scrim,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        shadow: AppColors.shadow,
        surface: AppColors.surface,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
        surfaceTint: AppColors.surfaceTint,
      ),
      textTheme: TextTheme(
        // H-1: 48px, Bold 700, line-height 72px (1.5), letter-spacing 0px
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-2: 40px, Bold 700, line-height 60px (1.5), letter-spacing 0px
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-3: 34px, Bold 700, line-height 51px (1.5), letter-spacing 0px
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-4: 28px, Bold 700, line-height 42px (1.5), letter-spacing 0px
        titleLarge: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-5: 24px, Bold 700, line-height 36px (1.5), letter-spacing 0px
        titleMedium: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-6: 20px, Medium 500, line-height 30px (1.5), letter-spacing 0px
        titleSmall: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // H-7: 16px, Medium 500, line-height 24px (1.5), letter-spacing 0px
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // B-1: 14px, Regular 400, line-height 21px (1.5), letter-spacing 0px
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // B-2: 12px, Regular 400, line-height 18px (1.5), letter-spacing 0px
        bodySmall: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // B-3: 10px, Regular 400, line-height 15px (1.5), letter-spacing 0px
        labelLarge: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // B-4: 8px, Regular 400, line-height 12px (1.5), letter-spacing 0px
        labelMedium: GoogleFonts.montserrat(
          fontSize: 8,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        // B-5: 6px, Regular 400, line-height 9px (1.5), letter-spacing 0px
        labelSmall: GoogleFonts.montserrat(
          fontSize: 6,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.onSurface,
        size: 24,
      ),
      primaryIconTheme: const IconThemeData(
        color: AppColors.onPrimary,
        size: 24,
        ),
      extensions: <ThemeExtension<dynamic>>[
        const IconSizes(
          xs: 12,
          sm: 16,
          md: 20,
          lg: 24,
          xl: 28,
          xxl: 32,
        ),
        const ImageSizes(
          thumb: 40,
          card: 120,
          avatarSm: 32,
          avatarMd: 48,
          avatarLg: 64,
        ),
        const ShimmerColors(
          base: AppColors.grey200,
          highlight: AppColors.white,
        ),
      ],
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: AppColors.cardBorder,
            width: 1,
          ),
        ),
        shadowColor: AppColors.shadow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1,
        ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
        ),
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 32,
        ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      scaffoldBackgroundColor: AppColors.surface,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}