import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../services/data_service.dart';
import 'sis_screen.dart';
import 'period_wise_attendance_report_screen.dart';
import 'period_wise_attendance_percentage_screen.dart';
import 'ptm_screens.dart';
import 'give_attendance_screen.dart';
import 'period_wise_attendance_screen.dart';
import 'professional_attendance_screen.dart';
import 'misc_erp_screens.dart';
import 'fee_collection_screen.dart';
import 'transport_screen.dart';
import 'id_card_screen.dart';
import 'library_screen.dart';
import 'certificates_screen.dart';
import '../../components/class_section_picker.dart';
import '../../utils/page_transitions.dart';

class ErpHomeScreen extends StatefulWidget {
  const ErpHomeScreen({super.key});

  @override
  State<ErpHomeScreen> createState() => _ErpHomeScreenState();
}

class _ErpHomeScreenState extends State<ErpHomeScreen> {
  Map<String, bool> _favorites = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _buildQuickStats(context),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureGridTile(
                icon: Icons.people,
                label: 'SIS',
                hasFavoriteStar: true,
                isFavorite: _favorites['SIS'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['SIS'] = v),
                onTap: () => Navigator.push(context, SlideRightRoute(page: const SisScreen())),
              ),
              FeatureGridTile(
                icon: Icons.check_circle,
                label: 'Attendance',
                hasFavoriteStar: true,
                isFavorite: _favorites['Attendance'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['Attendance'] = v),
                onTap: () {
                  Navigator.push(context, SlideRightRoute(
                    page: ClassSectionPicker(
                      classSections: dataService.classSections,
                      onSelected: (cs) => Navigator.pushReplacement(context, SlideRightRoute(
                        page: GiveAttendanceScreen(classSection: cs),
                      )),
                    ),
                  ));
                },
              ),
              FeatureGridTile(
                icon: Icons.schedule,
                label: 'Time Table',
                hasFavoriteStar: true,
                isFavorite: _favorites['TimeTable'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['TimeTable'] = v),
                onTap: () => Navigator.push(context, SlideRightRoute(page: const TimeTableScreen())),
              ),
              FeatureGridTile(
                icon: Icons.event,
                label: 'PTM',
                hasFavoriteStar: true,
                isFavorite: _favorites['PTM'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['PTM'] = v),
                onTap: () => Navigator.push(context, SlideRightRoute(page: const ManagePtmScreen())),
              ),
              FeatureGridTile(
                icon: Icons.receipt_long,
                label: 'Fee Collection',
                hasFavoriteStar: true,
                isFavorite: _favorites['Fee'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['Fee'] = v),
                onTap: () => Navigator.push(context, SlideRightRoute(page: const FeeCollectionScreen())),
              ),
              FeatureGridTile(
                icon: Icons.directions_bus,
                label: 'Transport',
                hasFavoriteStar: true,
                isFavorite: _favorites['Transport'] ?? false,
                onFavoriteToggle: (v) => setState(() => _favorites['Transport'] = v),
                onTap: () => Navigator.push(context, SlideRightRoute(page: const TransportScreen())),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureList(context),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 360;

    return Container(
      padding: EdgeInsets.all(isCompact ? 10 : 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryRed, AppColors.primaryRed.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryRed.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Overview',
            style: TextStyle(color: Colors.white, fontSize: isCompact ? 13 : 15, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: isCompact ? 8 : 12),
          Row(
            children: [
              _statItem(Icons.groups, 'Students', '347', isCompact),
              SizedBox(width: isCompact ? 4 : 8),
              _statItem(Icons.person, 'Staff', '28', isCompact),
              SizedBox(width: isCompact ? 4 : 8),
              _statItem(Icons.check_circle, 'Present', '312', isCompact),
              SizedBox(width: isCompact ? 4 : 8),
              _statItem(Icons.cancel, 'Absent', '35', isCompact),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String label, String value, bool isCompact) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isCompact ? 6 : 8, horizontal: isCompact ? 2 : 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: isCompact ? 16 : 20),
            SizedBox(height: isCompact ? 2 : 4),
            Text(value, style: TextStyle(color: Colors.white, fontSize: isCompact ? 14 : 16, fontWeight: FontWeight.w700)),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, style: TextStyle(color: Colors.white70, fontSize: isCompact ? 8 : 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      _Feature('Period Wise Attendance Report', Icons.assignment, () => Navigator.push(context, SlideRightRoute(page: const PeriodWiseAttendanceReportScreen()))),
      _Feature('Period Wise Attendance Percentage Report', Icons.pie_chart, () => Navigator.push(context, SlideRightRoute(page: const PeriodWiseAttendancePercentageScreen()))),
      _Feature('Give PTM Feedback', Icons.feedback, () => Navigator.push(context, SlideRightRoute(page: const GivePtmFeedbackScreen()))),
      _Feature('Manage PTM', Icons.event, () => Navigator.push(context, SlideRightRoute(page: const ManagePtmScreen()))),
      _Feature('Student Report', Icons.analytics, () => Navigator.push(context, SlideRightRoute(page: const StudentReportScreen()))),
      _Feature('Give Attendance', Icons.check_circle, () {
        Navigator.push(context, SlideRightRoute(
          page: ClassSectionPicker(
            classSections: dataService.classSections,
            onSelected: (cs) => Navigator.pushReplacement(context, SlideRightRoute(
              page: GiveAttendanceScreen(classSection: cs),
            )),
          ),
        ));
      }),
      _Feature('Period Wise Attendance', Icons.schedule, () {
        Navigator.push(context, SlideRightRoute(
          page: ClassSectionPicker(
            classSections: dataService.classSections,
            onSelected: (cs) => Navigator.pushReplacement(context, SlideRightRoute(
              page: PeriodWiseAttendanceScreen(classSection: cs),
            )),
          ),
        ));
      }),
      _Feature('Professional Student Attendance', Icons.how_to_reg, () => Navigator.push(context, SlideRightRoute(page: const ProfessionalStudentAttendanceScreen()))),
      _Feature('Parent Notes / Leave Intimations', Icons.note, () => Navigator.push(context, SlideRightRoute(page: const ParentNotesScreen()))),
      _Feature('Learning Based Assessment', Icons.school, () => Navigator.push(context, SlideRightRoute(page: const LearningBasedAssessmentScreen()))),
      _Feature('Time Table', Icons.table_chart, () => Navigator.push(context, SlideRightRoute(page: const TimeTableScreen()))),
      _Feature('Fee Collection', Icons.receipt_long, () => Navigator.push(context, SlideRightRoute(page: const FeeCollectionScreen()))),
      _Feature('Transport', Icons.directions_bus, () => Navigator.push(context, SlideRightRoute(page: const TransportScreen()))),
      _Feature('ID Card', Icons.badge, () => Navigator.push(context, SlideRightRoute(page: const IdCardScreen()))),
      _Feature('Library', Icons.menu_book, () => Navigator.push(context, SlideRightRoute(page: const LibraryScreen()))),
      _Feature('Certificates', Icons.description, () => Navigator.push(context, SlideRightRoute(page: const CertificatesScreen()))),
    ];

    return Column(
      children: features.map((f) => _FeatureListRow(
        icon: f.icon,
        title: f.title,
        onTap: f.onTap,
      )).toList(),
    );
  }
}

class _Feature {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  _Feature(this.title, this.icon, this.onTap);
}

class _FeatureListRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _FeatureListRow({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
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
