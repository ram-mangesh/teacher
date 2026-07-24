import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/empty_state.dart';
import '../../services/data_service.dart';

class PeriodWiseAttendancePercentageScreen extends StatefulWidget {
  const PeriodWiseAttendancePercentageScreen({super.key});

  @override
  State<PeriodWiseAttendancePercentageScreen> createState() => _PeriodWiseAttendancePercentageScreenState();
}

class _PeriodWiseAttendancePercentageScreenState extends State<PeriodWiseAttendancePercentageScreen> {
  late String _selectedSubject;

  @override
  void initState() {
    super.initState();
    _selectedSubject = dataService.subjects.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Period Wise Attendance % Report'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryRed,
            child: DefaultTabController(
              length: dataService.subjects.length,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                onTap: (i) => setState(() => _selectedSubject = dataService.subjects[i]),
                tabs: dataService.subjects.map((s) => Tab(text: s)).toList(),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final filtered = dataService.attendancePercentages
                    .where((a) => a.subject == _selectedSubject)
                    .toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pie_chart, size: 80, color: AppColors.dividerGrey),
                        const SizedBox(height: 16),
                        Text('No Data Found\n$_selectedSubject', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final a = filtered[index];
                    final barColor = a.percentage >= 85 ? AppColors.accentGreen : a.percentage >= 60 ? AppColors.primaryOrange : AppColors.primaryRed;
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a.subject, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: a.percentage / 100,
                                minHeight: 8,
                                backgroundColor: AppColors.dividerGrey,
                                valueColor: AlwaysStoppedAnimation(barColor),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${a.percentage.toStringAsFixed(1)}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: barColor)),
                                Text('Attended ${a.attendedClasses}/${a.totalClasses} classes', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
