import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'empty_state.dart';
import '../services/data_service.dart';

class BottomSheetTabs extends StatelessWidget {
  final BuildContext parentContext;

  const BottomSheetTabs({super.key, required this.parentContext});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => _BottomSheetContent(scrollController: scrollController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _BottomSheetContent extends StatefulWidget {
  final ScrollController scrollController;

  const _BottomSheetContent({required this.scrollController});

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: AppColors.dividerGrey,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryRed,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primaryRed,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            tabs: const [
              Tab(text: 'My Subjects'),
              Tab(text: 'TimeTable'),
              Tab(text: 'My Activities'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMySubjects(),
              _buildTimeTable(),
              _buildMyActivities(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMySubjects() {
    final subjects = ['Computer', 'English', 'Marathi', 'Hindi', 'Mathematics'];
    return ListView.separated(
      controller: widget.scrollController,
      itemCount: subjects.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (ctx, i) => ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryRed.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.book, color: AppColors.primaryRed),
        ),
        title: Text(subjects[i], style: const TextStyle(fontSize: 14)),
        subtitle: Text('Class 9-${String.fromCharCode(65 + i)}', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        trailing: const Icon(Icons.chevron_right, size: 20),
      ),
    );
  }

  Widget _buildTimeTable() {
    final entries = dataService.timetableEntries;
    final dayOrder = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    final currentDayIndex = DateTime.now().weekday - 1;
    final currentDay = dayOrder[currentDayIndex.clamp(0, dayOrder.length - 1)];
    final grouped = <String, List>{};
    for (final day in dayOrder) {
      grouped[day] = entries.where((e) => e.day == day).toList();
    }
    final sortedDays = [currentDay, ...dayOrder.where((d) => d != currentDay)];

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: sortedDays.length,
      itemBuilder: (ctx, i) {
        final day = sortedDays[i];
        final dayEntries = grouped[day] ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: day == currentDay ? AppColors.primaryRed.withOpacity(0.08) : AppColors.backgroundGrey,
              child: Row(
                children: [
                  Text(day, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: day == currentDay ? AppColors.primaryRed : AppColors.textPrimary)),
                  if (day == currentDay) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Today', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
            ),
            ...dayEntries.map((e) => ListTile(
                  dense: true,
                  leading: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.primaryRed.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(e.period, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryRed)),
                  ),
                  title: Text(e.subject, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  subtitle: Text('${e.startTime} - ${e.endTime}', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  trailing: Text('${e.className}-${e.section}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                )),
            const Divider(height: 1),
          ],
        );
      },
    );
  }

  Widget _buildMyActivities() {
    final activities = dataService.teacherActivities;
    return ListView.separated(
      controller: widget.scrollController,
      itemCount: activities.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (ctx, i) {
        final a = activities[i];
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              a.type == 'Teaching' ? Icons.school : a.type == 'Event' ? Icons.event : Icons.work,
              color: AppColors.primaryRed,
              size: 20,
            ),
          ),
          title: Text(a.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(a.description, style: TextStyle(fontSize: 11, color: Colors.grey[500]), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(a.type, style: const TextStyle(fontSize: 10, color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                  Text(a.date, style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                ],
              ),
            ],
          ),
          isThreeLine: true,
        );
      },
    );
  }
}
