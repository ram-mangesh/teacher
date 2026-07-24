import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final navHeight = screenWidth < 360 ? 56.0 : AppDimensions.bottomNavHeight;

    return SafeArea(
      top: false,
      child: Container(
        height: navHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.calendar_today,
              label: 'Timetable',
              index: 1,
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
              secondaryIcon: Icons.edit,
              secondaryColor: AppColors.primaryRed,
            ),
            _NavItem(
              icon: Icons.check_circle,
              label: 'Approvals',
              index: 2,
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
              iconColor: AppColors.accentGreen,
            ),
            _NavItem(
              icon: Icons.notifications_outlined,
              label: 'Notifs',
              index: 3,
              isSelected: currentIndex == 3,
              onTap: () => onTap(3),
              hasBadge: true,
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              index: 4,
              isSelected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final bool hasBadge;
  final IconData? secondaryIcon;
  final Color? secondaryColor;
  final Color? iconColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
    this.hasBadge = false,
    this.secondaryIcon,
    this.secondaryColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: isSelected
                      ? const BoxDecoration(
                          color: Color(0xFFFFF0ED),
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: secondaryIcon != null
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              icon,
                              color: iconColor ?? (isSelected ? AppColors.primaryRed : AppColors.textSecondary),
                              size: 22,
                            ),
                            Positioned(
                              right: -4,
                              bottom: -2,
                              child: Icon(
                                secondaryIcon,
                                color: secondaryColor ?? AppColors.primaryRed,
                                size: 12,
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          icon,
                          color: iconColor ?? (isSelected ? AppColors.primaryRed : AppColors.textSecondary),
                          size: 24,
                        ),
                ),
                if (hasBadge)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.badgeRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? AppColors.primaryRed : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
