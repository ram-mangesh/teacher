import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/data_service.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;
  final String? selectedYear;
  final ValueChanged<String?>? onYearChanged;

  const AppHeader({
    super.key,
    this.onMenuTap,
    this.onSearchTap,
    this.selectedYear,
    this.onYearChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.headerHeight + 50);

  @override
  Widget build(BuildContext context) {
    final user = dataService.currentUser;
    final years = user.sessions;
    final currentYear = selectedYear ?? user.academicYear;
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 360;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isCompact ? 8 : 12, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: AppColors.textWhite, size: isCompact ? 22 : 24),
                    onPressed: onMenuTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                  Container(
                    width: isCompact ? 36 : 42,
                    height: isCompact ? 36 : 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('IJS', style: TextStyle(
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.w700,
                        fontSize: isCompact ? 12 : 14,
                      )),
                    ),
                  ),
                  SizedBox(width: isCompact ? 6 : 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.school,
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: isCompact ? 13 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.name,
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: isCompact ? 10 : 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isCompact)
                    IconButton(
                      icon: const Icon(Icons.search, color: AppColors.textWhite, size: 22),
                      onPressed: onSearchTap,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  if (!isCompact)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: currentYear,
                          isDense: true,
                          dropdownColor: AppColors.primaryRed,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                          onChanged: onYearChanged,
                        ),
                      ),
                    ),
                  SizedBox(width: isCompact ? 4 : 6),
                  GestureDetector(
                    onTap: () => _showProfileSheet(context, user),
                    child: Container(
                      width: isCompact ? 32 : 36,
                      height: isCompact ? 32 : 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          user.initials,
                          style: TextStyle(
                            color: AppColors.primaryRed,
                            fontWeight: FontWeight.w800,
                            fontSize: isCompact ? 11 : 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileSheet(BuildContext context, dynamic user) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.dividerGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              user.designation,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 2),
            Text(
              user.role,
              style: const TextStyle(fontSize: 12, color: AppColors.linkBlue, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            _profileRow(Icons.badge, 'Staff ID', user.id),
            _profileRow(Icons.school, 'School', user.school),
            _profileRow(Icons.calendar_today, 'Joined', user.joinDate),
            _profileRow(Icons.calendar_month, 'Academic Year', user.academicYear),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _profileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryRed),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
