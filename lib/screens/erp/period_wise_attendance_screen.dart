import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/calendar_strip.dart';
import '../../models/models.dart';
import '../../services/data_service.dart';

class PeriodWiseAttendanceScreen extends StatefulWidget {
  final ClassSection classSection;
  const PeriodWiseAttendanceScreen({super.key, required this.classSection});

  @override
  State<PeriodWiseAttendanceScreen> createState() => _PeriodWiseAttendanceScreenState();
}

class _PeriodWiseAttendanceScreenState extends State<PeriodWiseAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Period Wise Attendance - ${widget.classSection.label}'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Text(widget.classSection.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: const Text('Attendance Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          MonthCalendarStrip(
            selectedDate: _selectedDate,
            onDateSelected: (d) => setState(() => _selectedDate = d),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: dataService.periodAttendance.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final p = dataService.periodAttendance[index];
                final percentage = p.totalStudents > 0 ? (p.presentStudents / p.totalStudents) : 0.0;
                final pctColor = percentage >= 0.85 ? AppColors.accentGreen : percentage >= 0.6 ? AppColors.primaryOrange : AppColors.primaryRed;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.linkBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(p.period, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.linkBlue)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.subject, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                  Text('${p.startTime} - ${p.endTime}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                            Text('${p.presentStudents}/${p.totalStudents}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percentage.toDouble(),
                            minHeight: 6,
                            backgroundColor: AppColors.dividerGrey,
                            valueColor: AlwaysStoppedAnimation(pctColor),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('${(percentage * 100).toStringAsFixed(1)}% Attendance', style: TextStyle(fontSize: 11, color: pctColor, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
