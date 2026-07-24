import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/hr_widgets.dart';
import '../../services/data_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: StaffAttendanceCard(
          user: dataService.currentUser,
          attendance: dataService.currentAttendance,
        ),
      ),
    );
  }
}
