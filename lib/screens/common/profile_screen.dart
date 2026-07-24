import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/hr_widgets.dart';
import '../../services/data_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StaffAttendanceCard(
        user: dataService.currentUser,
        attendance: dataService.currentAttendance,
      ),
    );
  }
}
