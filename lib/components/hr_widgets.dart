import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class StaffAttendanceCard extends StatelessWidget {
  final UserModel user;
  final StaffAttendanceModel attendance;

  const StaffAttendanceCard({
    super.key,
    required this.user,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                  child: Text(
                    user.initials,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryRed),
                  ),
                ),
                const SizedBox(height: 8),
                Text(user.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text(user.id, style: AppTextStyles.listItemSubtitle),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Tag(label: 'Staff', color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    _Tag(label: 'Teaching', color: AppColors.textSecondary),
                  ],
                ),
                Text('Joined: ${user.joinDate}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: AppColors.primaryRed,
            child: Text(
              attendance.shift,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(attendance.date, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Text(' ${attendance.day}', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _CheckInOut(label: 'First Check In', value: attendance.firstCheckIn)),
                const SizedBox(width: 16),
                Expanded(child: _CheckInOut(label: 'Last Check Out', value: attendance.lastCheckOut)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Check In', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Text('More...', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          if (!attendance.locationUpdated)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.warning_amber, color: AppColors.primaryRed, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Institute google location not updated',
                      style: TextStyle(color: AppColors.primaryRed, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          _InfoRow(
            icon: Icons.event,
            label: 'Upcoming Holiday',
            value: attendance.upcomingHoliday ?? 'No upcoming Holiday',
          ),
          _InfoRow(
            icon: Icons.flight_takeoff,
            label: 'Upcoming Leave',
            value: attendance.upcomingLeave ?? 'No upcoming Leave',
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.starYellow.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.support_agent, color: AppColors.starYellow, size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Change PIN/Password/MCB Support',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('Last visited on Jul 23 2026 6:23 PM', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                Text('Version: 3.4.0', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
    );
  }
}

class _CheckInOut extends StatelessWidget {
  final String label;
  final String? value;

  const _CheckInOut({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        Text(
          value != null ? value! : ' : -',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: value != null ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
