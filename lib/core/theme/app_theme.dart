import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

extension AppColorScheme on ColorScheme {
  Color get success => AppColors.success;
  Color get successContainer => AppColors.successContainer;
  Color get onSuccess => AppColors.onSuccess;
  Color get onSuccessContainer => AppColors.onSuccessContainer;
  Color get innerPageSurface => AppColors.innerPageSurface;
}

@immutable
class IconSizes extends ThemeExtension<IconSizes> {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

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
  final double thumb;
  final double card;
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;
  final double logoSm;
  final double logoMd;
  final double logoLg;

  const ImageSizes({
    required this.thumb,
    required this.card,
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,
    required this.logoSm,
    required this.logoMd,
    required this.logoLg,
  });

  @override
  ImageSizes copyWith({
    double? thumb,
    double? card,
    double? avatarSm,
    double? avatarMd,
    double? avatarLg,
    double? logoSm,
    double? logoMd,
    double? logoLg,
  }) {
    return ImageSizes(
      thumb: thumb ?? this.thumb,
      card: card ?? this.card,
      avatarSm: avatarSm ?? this.avatarSm,
      avatarMd: avatarMd ?? this.avatarMd,
      avatarLg: avatarLg ?? this.avatarLg,
      logoSm: logoSm ?? this.logoSm,
      logoMd: logoMd ?? this.logoMd,
      logoLg: logoLg ?? this.logoLg,
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
      logoSm: IconSizes.lerpDouble(logoSm, other.logoSm, t),
      logoMd: IconSizes.lerpDouble(logoMd, other.logoMd, t),
      logoLg: IconSizes.lerpDouble(logoLg, other.logoLg, t),
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
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 8,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
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
          logoSm: 40,
          logoMd: 50,
          logoLg: 60,
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
