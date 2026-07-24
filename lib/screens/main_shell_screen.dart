import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../components/app_header.dart';
import '../components/top_tab_bar.dart';
import '../components/bottom_nav_bar.dart';
import '../components/drawer_menu.dart';
import '../components/bottom_sheet_tabs.dart';
import '../components/class_section_picker.dart';
import '../services/data_service.dart';
import '../screens/erp/erp_home_screen.dart';
import '../screens/erp/sis_screen.dart';
import '../screens/erp/period_wise_attendance_report_screen.dart';
import '../screens/erp/period_wise_attendance_percentage_screen.dart';
import '../screens/erp/ptm_screens.dart';
import '../screens/erp/give_attendance_screen.dart';
import '../screens/erp/period_wise_attendance_screen.dart';
import '../screens/erp/professional_attendance_screen.dart';
import '../screens/erp/misc_erp_screens.dart';
import '../screens/erp/fee_collection_screen.dart';
import '../screens/erp/transport_screen.dart';
import '../screens/erp/id_card_screen.dart';
import '../screens/erp/library_screen.dart';
import '../screens/erp/certificates_screen.dart';
import '../screens/hr/hr_home_screen.dart';
import '../screens/hr/staff_wall_screen.dart';
import '../screens/hr/payslip_screen.dart';
import '../screens/hr/leave_application_screen.dart';
import '../screens/hr/staff_directory_screen.dart';
import '../screens/gradebook/gradebook_home_screen.dart';
import '../screens/lms/lms_home_screen.dart';
import '../screens/connect/connect_home_screen.dart';
import '../screens/connect/send_sms_screen.dart';
import '../screens/connect/chat_screen.dart';
import '../screens/connect/gallery_screen.dart';
import '../screens/admin/admin_home_screen.dart';
import '../screens/common/notifications_screen.dart';
import '../screens/common/profile_screen.dart';
import '../screens/common/search_screen.dart';
import '../utils/page_transitions.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTab = 0;
  int _bottomNavIndex = 0;

  final List<String> _tabs = ['ERP', 'HR', 'GRADE BOOK', 'LMS', 'CONNECT', 'ADMIN'];

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0: return const ErpHomeScreen();
      case 1: return const HrHomeScreen();
      case 2: return const GradeBookHomeScreen();
      case 3: return const LmsHomeScreen();
      case 4: return const ConnectHomeScreen();
      case 5: return const AdminHomeScreen();
      default: return const ErpHomeScreen();
    }
  }

  Widget _buildBottomNavContent() {
    switch (_bottomNavIndex) {
      case 0: return _buildTabContent();
      case 1: return _buildTabContent();
      case 2: return const NotificationsScreen();
      case 3: return const NotificationsScreen();
      case 4: return const ProfileScreen();
      default: return _buildTabContent();
    }
  }

  void _onDrawerItemTap(String label) {
    final tabIndex = _tabs.indexOf(label);
    if (tabIndex >= 0) {
      setState(() {
        _selectedTab = tabIndex;
        _bottomNavIndex = 0;
      });
      return;
    }

    Widget page;

    switch (label) {
      case 'SIS':
        page = const SisScreen();
        break;
      case 'Period Wise Attendance Report':
        page = const PeriodWiseAttendanceReportScreen();
        break;
      case 'Period Wise Attendance Percentage Report':
        page = const PeriodWiseAttendancePercentageScreen();
        break;
      case 'Give PTM Feedback':
        page = const GivePtmFeedbackScreen();
        break;
      case 'Manage PTM':
        page = const ManagePtmScreen();
        break;
      case 'Student Report':
        page = const StudentReportScreen();
        break;
      case 'Give Attendance':
        Navigator.push(context, SlideRightRoute(
          page: ClassSectionPicker(
            classSections: dataService.classSections,
            onSelected: (cs) => Navigator.pushReplacement(context, SlideRightRoute(
              page: GiveAttendanceScreen(classSection: cs),
            )),
          ),
        ));
        return;
      case 'Period Wise Attendance':
        Navigator.push(context, SlideRightRoute(
          page: ClassSectionPicker(
            classSections: dataService.classSections,
            onSelected: (cs) => Navigator.pushReplacement(context, SlideRightRoute(
              page: PeriodWiseAttendanceScreen(classSection: cs),
            )),
          ),
        ));
        return;
      case 'Professional Student Attendance':
        page = const ProfessionalStudentAttendanceScreen();
        break;
      case 'Parent Notes / Leave Intimations':
        page = const ParentNotesScreen();
        break;
      case 'Learning Based Assessment':
        page = const LearningBasedAssessmentScreen();
        break;
      case 'Time Table':
        page = const TimeTableScreen();
        break;
      case 'Fee Collection':
        page = const FeeCollectionScreen();
        break;
      case 'Transport':
        page = const TransportScreen();
        break;
      case 'ID Card':
        page = const IdCardScreen();
        break;
      case 'Library':
        page = const LibraryScreen();
        break;
      case 'Certificates':
        page = const CertificatesScreen();
        break;

      case 'HR':
        setState(() {
          _selectedTab = 1;
          _bottomNavIndex = 0;
        });
        return;
      case 'Staff Wall':
        page = const StaffWallScreen();
        break;
      case 'Staff Meetings':
        page = const StaffMeetingsScreen();
        break;
      case 'Payslip':
        page = const PayslipScreen();
        break;
      case 'Leave Application':
        page = const LeaveApplicationScreen();
        break;
      case 'Staff Directory':
        page = const StaffDirectoryScreen();
        break;

      case 'CBSE and State':
        page = const CBSEStateScreen();
        break;
      case 'Subject Outcomes':
        page = const SubjectOutcomesScreen();
        break;
      case 'Test and Marks':
        page = const TestAndMarksScreen();
        break;
      case 'Examination Marks':
        page = const ExaminationMarksScreen();
        break;
      case 'CoScholastic Grade Entry':
        page = const CoScholasticScreen();
        break;
      case 'Student Remarks':
        page = const StudentRemarksScreen();
        break;
      case 'Class Teacher Remarks':
        page = const ClassTeacherRemarksScreen();
        break;

      case 'Assignments':
        setState(() {
          _selectedTab = 3;
          _bottomNavIndex = 0;
        });
        return;
      case 'Online Worksheet':
        page = const LmsFeatureScreen(title: 'Online Worksheet');
        break;
      case 'Reading Assignment':
        page = const LmsFeatureScreen(title: 'Reading Assignment');
        break;

      case 'SMS':
        page = const SmsListScreen();
        break;
      case 'Send SMS':
        page = const SendSmsScreen();
        break;
      case 'Announcements':
        page = const AnnouncementsScreen();
        break;
      case 'Calendar':
        page = const CalendarScreen();
        break;
      case 'Chat':
        page = const ChatListScreen();
        break;
      case 'Gallery':
        page = const GalleryScreen();
        break;

      case 'SQAA':
        page = const SqaaScreen();
        break;
      case 'NAAC and NIRF':
        page = const NaacNirfHomeScreen();
        break;

      default:
        return;
    }

    Navigator.push(context, SlideRightRoute(page: page));
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerMenu(
        sections: dataService.menuSections,
        onItemTap: _onDrawerItemTap,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            AppHeader(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              onSearchTap: () => Navigator.push(context, SlideRightRoute(page: const SearchScreen())),
              selectedYear: appState.selectedAcademicYear,
              onYearChanged: (val) => appState.setAcademicYear(val ?? appState.selectedAcademicYear),
            ),
            TopTabBar(
              tabs: _tabs,
              selectedIndex: _selectedTab,
              onTabChanged: (i) => setState(() {
                _selectedTab = i;
                _bottomNavIndex = 0;
              }),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: _buildBottomNavContent(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _bottomNavIndex,
        onTap: (i) {
          if (i == 1) {
            BottomSheetTabs.show(context);
          } else {
            setState(() => _bottomNavIndex = i);
          }
        },
      ),
    );
  }
}
