import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryRed = Color(0xFFE8342A);
  static const Color primaryOrange = Color(0xFFFF6A3D);
  static const Color accentGreen = Color(0xFF3CB878);
  static const Color saveGreen = Color(0xFF3CB878);
  static const Color cardWhite = Colors.white;
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color dividerGrey = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textWhite = Colors.white;
  static const Color badgeRed = Color(0xFFE8342A);
  static const Color starYellow = Color(0xFFFFC107);
  static const Color linkBlue = Color(0xFF1976D2);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryRed, primaryOrange],
  );
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 12.0;
  static const double paddingLarge = 16.0;
  static const double paddingXLarge = 24.0;
  static const double cardRadius = 10.0;
  static const double buttonRadius = 25.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double avatarSize = 40.0;
  static const double headerHeight = 70.0;
  static const double bottomNavHeight = 60.0;
}

class AppTextStyles {
  static const TextStyle headerTitle = TextStyle(
    color: AppColors.textWhite,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headerSubtitle = TextStyle(
    color: AppColors.textWhite,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle sectionHeader = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static const TextStyle listItemTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle listItemSubtitle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );

  static const TextStyle tileLabel = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle tabActive = TextStyle(
    color: AppColors.textWhite,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle tabInactive = TextStyle(
    color: Colors.white70,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle statNumber = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle statLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11,
  );

  static const TextStyle emptyStateTitle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.textWhite,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle formLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
