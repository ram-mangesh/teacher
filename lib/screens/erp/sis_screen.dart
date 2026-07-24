import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/common_widgets.dart';
import '../../components/empty_state.dart';
import '../../services/data_service.dart';

class SisScreen extends StatefulWidget {
  const SisScreen({super.key});

  @override
  State<SisScreen> createState() => _SisScreenState();
}

class _SisScreenState extends State<SisScreen> {
  String? _selectedClass;
  String? _selectedSection;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Student Info System'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilterSheet),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                Expanded(
                  child: _buildDropdown('Class', _selectedClass, ['9', '10'], (v) => setState(() => _selectedClass = v)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDropdown('Section', _selectedSection, ['A', 'B', 'C', 'D', 'E', 'F'], (v) => setState(() => _selectedSection = v)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search students...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: _selectedClass == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people, size: 80, color: AppColors.dividerGrey),
                        SizedBox(height: 16),
                        Text('Select Class & Section\nto view students', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                      ],
                    ),
                  )
                : _buildStudentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> options, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accentGreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          isExpanded: true,
          value: value,
          hint: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildStudentList() {
    final students = dataService.attendanceStudents.where((s) {
      if (_searchQuery.isNotEmpty) {
        return s.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }
      return true;
    }).toList();

    if (students.isEmpty) return const EmptyStateWidget(type: EmptyStateType.noData, customMessage: 'No students found');

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (ctx, i) {
        final s = students[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryRed.withOpacity(0.1),
              child: Text(s.name[0], style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700)),
            ),
            title: Text(s.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            subtitle: Text('Adm: ${s.admissionNo} | Roll: ${s.rollNo} | Class: ${_selectedClass}-$_selectedSection', style: const TextStyle(fontSize: 11)),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => _showStudentDetail(s),
          ),
        );
      },
    );
  }

  void _showStudentDetail(student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (ctx, controller) => SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.dividerGrey, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                  child: Text(student.name[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primaryRed)),
                ),
              ),
              const SizedBox(height: 12),
              Center(child: Text(student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              Center(child: Text('Admission No: ${student.admissionNo}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
              const SizedBox(height: 20),
              _detailRow('Roll Number', student.rollNo),
              _detailRow('Class', '${_selectedClass ?? "-"}-${_selectedSection ?? "-"}'),
              _detailRow('Status', student.status == 'P' ? 'Present' : 'Absent'),
              _detailRow('Attendance', '${student.status} / ${student.status == "P" ? "Present" : "Absent"}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Students', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildDropdown('Class', _selectedClass, ['9', '10'], (v) => setState(() => _selectedClass = v)),
            const SizedBox(height: 12),
            _buildDropdown('Section', _selectedSection, ['A', 'B', 'C', 'D', 'E', 'F'], (v) => setState(() => _selectedSection = v)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(label: 'Apply Filter', onPressed: () => Navigator.pop(ctx)),
            ),
          ],
        ),
      ),
    );
  }
}
