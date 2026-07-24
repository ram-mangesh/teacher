import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/calendar_strip.dart';
import '../../services/data_service.dart';

class PeriodWiseAttendanceReportScreen extends StatefulWidget {
  const PeriodWiseAttendanceReportScreen({super.key});

  @override
  State<PeriodWiseAttendanceReportScreen> createState() => _PeriodWiseAttendanceReportScreenState();
}

class _PeriodWiseAttendanceReportScreenState extends State<PeriodWiseAttendanceReportScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Period Wise Attendance Report'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          MonthCalendarStrip(
            selectedDate: _selectedDate,
            onDateSelected: (d) => setState(() => _selectedDate = d),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(AppColors.backgroundGrey),
                  columnSpacing: 16,
                  columns: [
                    const DataColumn(label: Text('Student Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    const DataColumn(label: Text('Roll No', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    ...List.generate(6, (i) => DataColumn(
                      label: Text('P${i + 1}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      numeric: true,
                    )),
                  ],
                  rows: dataService.attendanceReportData.map((record) {
                    return DataRow(cells: [
                      DataCell(Text(record.studentName, style: const TextStyle(fontSize: 12))),
                      DataCell(Text(record.rollNo, style: const TextStyle(fontSize: 12))),
                      ...List.generate(6, (i) {
                        final status = record.periodStatus['${i + 1}'] ?? '-';
                        final isPresent = status == 'P';
                        return DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPresent ? AppColors.accentGreen.withOpacity(0.1) : AppColors.primaryRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isPresent ? AppColors.accentGreen : AppColors.primaryRed,
                              ),
                            ),
                          ),
                        );
                      }),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
