import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../components/hr_widgets.dart';
import '../../services/data_service.dart';
import 'staff_wall_screen.dart';
import 'payslip_screen.dart';
import 'leave_application_screen.dart';
import 'staff_directory_screen.dart';
import '../../utils/page_transitions.dart';

class HrHomeScreen extends StatefulWidget {
  const HrHomeScreen({super.key});

  @override
  State<HrHomeScreen> createState() => _HrHomeScreenState();
}

class _HrHomeScreenState extends State<HrHomeScreen> {
  bool _showProfile = false;

  @override
  Widget build(BuildContext context) {
    if (_showProfile) {
      return SingleChildScrollView(
        child: StaffAttendanceCard(
          user: dataService.currentUser,
          attendance: dataService.currentAttendance,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureGridTile(
                icon: Icons.business,
                label: 'HR',
                onTap: () => setState(() => _showProfile = true),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildListRow('Staff Wall', Icons.wallpaper, () => Navigator.push(context, SlideRightRoute(page: const StaffWallScreen()))),
          _buildListRow('Staff Meetings', Icons.groups, () => Navigator.push(context, SlideRightRoute(page: const StaffMeetingsScreen()))),
          _buildListRow('Payslip', Icons.receipt, () => Navigator.push(context, SlideRightRoute(page: const PayslipScreen()))),
          _buildListRow('Leave Application', Icons.leave_bags_at_home, () => Navigator.push(context, SlideRightRoute(page: const LeaveApplicationScreen()))),
          _buildListRow('Staff Directory', Icons.contact_phone, () => Navigator.push(context, SlideRightRoute(page: const StaffDirectoryScreen()))),
          _buildListRow('GPS Check-in/Check-out', Icons.location_on, () => setState(() => _showProfile = true)),
        ],
      ),
    );
  }

  Widget _buildListRow(String title, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryRed, size: 22),
          title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          onTap: onTap,
        ),
        const Divider(height: 1, indent: 56),
      ],
    );
  }
}

class StaffMeetingsScreen extends StatelessWidget {
  const StaffMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Staff Meetings'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Infant Jesus High School Nallasopara - Last 30 Days',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ),
                const Icon(Icons.filter_list, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: dataService.staffMeetings.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final meeting = dataService.staffMeetings[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.groups, color: AppColors.primaryRed, size: 22),
                  ),
                  title: Text(meeting.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(meeting.date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(width: 8),
                            Icon(Icons.access_time, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(meeting.time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(meeting.venue, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.person, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('Organized by ${meeting.organizer}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
