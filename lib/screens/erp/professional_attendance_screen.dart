import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/common_widgets.dart';
import '../../services/data_service.dart';

class ProfessionalStudentAttendanceScreen extends StatefulWidget {
  const ProfessionalStudentAttendanceScreen({super.key});

  @override
  State<ProfessionalStudentAttendanceScreen> createState() => _ProfessionalStudentAttendanceScreenState();
}

class _ProfessionalStudentAttendanceScreenState extends State<ProfessionalStudentAttendanceScreen> {
  String? _selectedBranch = 'Infant Jesus';
  String? _selectedClass = 'Class 9';
  String? _selectedSection = 'A';
  String? _selectedSession = 'Morning';
  String? _selectedFaculty;
  String? _selectedSubject;
  TimeOfDay _startTime = const TimeOfDay(hour: 6, minute: 45);
  TimeOfDay _endTime = const TimeOfDay(hour: 13, minute: 0);
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Professional Student Attendance'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField('Branch', _selectedBranch, ['Infant Jesus'], (v) => setState(() => _selectedBranch = v)),
            const SizedBox(height: 12),
            _buildField('Class', _selectedClass, ['Class 9', 'Class 10'], (v) => setState(() => _selectedClass = v)),
            const SizedBox(height: 12),
            _buildField('Section', _selectedSection, ['A', 'B', 'C', 'D', 'E', 'F'], (v) => setState(() => _selectedSection = v)),
            const SizedBox(height: 12),
            _buildDateField('Date', _selectedDate),
            const SizedBox(height: 12),
            _buildField('Session', _selectedSession, ['Morning', 'Afternoon'], (v) => setState(() => _selectedSession = v)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTimeField('Start Time', _startTime, (t) => setState(() => _startTime = t))),
                const SizedBox(width: 12),
                Expanded(child: _buildTimeField('End Time', _endTime, (t) => setState(() => _endTime = t))),
              ],
            ),
            const SizedBox(height: 12),
            _buildField('Faculty Name', _selectedFaculty, ['Radhika Jaiswal', 'Priya Sharma', 'Amit Kumar'], (v) => setState(() => _selectedFaculty = v)),
            const SizedBox(height: 12),
            _buildField('Subject Name', _selectedSubject, dataService.subjects, (v) => setState(() => _selectedSubject = v)),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Give Attendance',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attendance submitted!'), backgroundColor: AppColors.accentGreen),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String? value, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.formLabel),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true,
              isExpanded: true,
              value: value,
              hint: Text('Select $label', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              icon: const Icon(Icons.keyboard_arrow_down, size: 18),
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 13)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.formLabel),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) setState(() => _selectedDate = picked);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, TimeOfDay time, ValueChanged<TimeOfDay> onPicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.formLabel),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) onPicked(picked);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
