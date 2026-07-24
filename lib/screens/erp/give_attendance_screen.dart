import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/attendance_widgets.dart';
import '../../components/calendar_strip.dart';
import '../../components/common_widgets.dart';
import '../../models/models.dart';
import '../../services/data_service.dart';

class GiveAttendanceScreen extends StatefulWidget {
  final ClassSection classSection;
  const GiveAttendanceScreen({super.key, required this.classSection});

  @override
  State<GiveAttendanceScreen> createState() => _GiveAttendanceScreenState();
}

class _GiveAttendanceScreenState extends State<GiveAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedSession = 'Morning';
  String _filterStatus = 'All';
  List<StudentAttendanceRecord> _students = [];

  @override
  void initState() {
    super.initState();
    _students = dataService.attendanceStudents.map((s) => StudentAttendanceRecord(
      admissionNo: s.admissionNo,
      name: s.name,
      rollNo: s.rollNo,
      status: s.status,
      isExcused: s.isExcused,
    )).toList();
  }

  int get _total => _students.length;
  int get _present => _students.where((s) => s.status == 'P').length;
  int get _absent => _students.where((s) => s.status == 'A').length;

  List<StudentAttendanceRecord> get _filteredStudents {
    if (_filterStatus == 'All') return _students;
    return _students.where((s) => s.status == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Give Attendance - ${widget.classSection.label}'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (v) {},
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.classSection.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.dividerGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isDense: true,
                                value: _selectedSession,
                                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                                style: const TextStyle(fontSize: 12),
                                items: ['Morning', 'Afternoon'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                                onChanged: (v) => setState(() => _selectedSession = v ?? _selectedSession),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CalendarStrip(
            selectedDate: _selectedDate,
            onDateSelected: (d) => setState(() => _selectedDate = d),
          ),
          AttendanceCounter(total: _total, present: _present, absent: _absent),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${_filteredStudents.length} students', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const Spacer(),
                _filterChip('All'),
                const SizedBox(width: 4),
                _filterChip('P'),
                const SizedBox(width: 4),
                _filterChip('A'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStudents.length,
              itemBuilder: (ctx, i) {
                final student = _filteredStudents[i];
                final originalIndex = _students.indexOf(student);
                return AttendanceStudentRow(
                  student: student,
                  onStatusChanged: (status) {
                    setState(() => _students[originalIndex].status = status);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))],
        ),
        child: PrimaryButton(
          label: 'Save Attendance',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Attendance saved successfully!'), backgroundColor: AppColors.accentGreen),
            );
            Navigator.pop(context);
          },
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _filterChip(String label) {
    final isActive = _filterStatus == label;
    final count = label == 'All' ? _students.length : _students.where((s) => s.status == label).length;
    return GestureDetector(
      onTap: () => setState(() => _filterStatus = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryRed : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? AppColors.primaryRed : AppColors.dividerGrey),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
