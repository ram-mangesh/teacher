import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../components/common_widgets.dart';
import '../../services/data_service.dart';
import '../../utils/page_transitions.dart';

class LmsHomeScreen extends StatefulWidget {
  const LmsHomeScreen({super.key});

  @override
  State<LmsHomeScreen> createState() => _LmsHomeScreenState();
}

class _LmsHomeScreenState extends State<LmsHomeScreen> {
  bool _showAssignments = false;

  @override
  Widget build(BuildContext context) {
    if (_showAssignments) return _buildAssignmentsScreen();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureGridTile(
                icon: Icons.assignment_turned_in,
                label: 'Assignments',
                hasFavoriteStar: true,
                isFavorite: false,
                onFavoriteToggle: (_) {},
                onTap: () => setState(() => _showAssignments = true),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildListRow('Online Worksheet', Icons.edit_note, () => _navigateTo(context, 'Online Worksheet')),
          _buildListRow('Reading Assignment', Icons.auto_stories, () => _navigateTo(context, 'Reading Assignment')),
        ],
      ),
    );
  }

  Widget _buildListRow(String title, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryRed, size: 22),
          title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          onTap: onTap,
        ),
        const Divider(height: 1, indent: 56),
      ],
    );
  }

  void _navigateTo(BuildContext context, String feature) {
    Navigator.push(context, SlideRightRoute(
      page: LmsFeatureScreen(title: feature),
    ));
  }

  Widget _buildAssignmentsScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Assignments'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.dividerGrey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        value: '9-E',
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        style: const TextStyle(fontSize: 12),
                        items: ['9-A', '9-E', '10-A', '10-B', '10-D', '10-F']
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: const Text('Assignments / Class 9-E', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      value: 'All',
                      icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                      style: const TextStyle(fontSize: 12),
                      items: ['All', 'Active', 'Completed'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'From Date',
                      hintStyle: const TextStyle(fontSize: 11),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      suffixIcon: const Icon(Icons.calendar_today, size: 16),
                    ),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'To Date',
                      hintStyle: const TextStyle(fontSize: 11),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      suffixIcon: const Icon(Icons.calendar_today, size: 16),
                    ),
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: dataService.assignments.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final assignment = dataService.assignments[index];
                final isActive = assignment.status == 'Active';
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (isActive ? AppColors.accentGreen : AppColors.linkBlue).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.assignment,
                      color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
                      size: 22,
                    ),
                  ),
                  title: Text(assignment.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Class: ${assignment.className}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(width: 8),
                            Text('Subject: ${assignment.subject}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.date_range, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(assignment.dateRange, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(assignment.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class LmsFeatureScreen extends StatelessWidget {
  final String title;
  const LmsFeatureScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                Expanded(
                  child: Text('(AY - 2026-2027)', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Infant Jesus High School Nallasopara - 17 Jul 2026 to 23 Jul 2026',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
                const Icon(Icons.filter_list, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
          Expanded(
            child: title.contains('Online Worksheet')
                ? _buildOnlineWorksheetsList()
                : title.contains('Reading Assignment')
                    ? _buildReadingAssignmentsList()
                    : const Center(child: Text('No data available')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildOnlineWorksheetsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: dataService.onlineWorksheets.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final worksheet = dataService.onlineWorksheets[index];
        final isActive = worksheet.status == 'Active';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isActive ? AppColors.accentGreen : AppColors.linkBlue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.edit_note,
              color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
              size: 22,
            ),
          ),
          title: Text(worksheet.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Class: ${worksheet.className}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(width: 8),
                    Text('Subject: ${worksheet.subject}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.date_range, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('${worksheet.assignedDate} to ${worksheet.dueDate}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(worksheet.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        );
      },
    );
  }

  Widget _buildReadingAssignmentsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: dataService.readingAssignments.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final assignment = dataService.readingAssignments[index];
        final isActive = assignment.status == 'Active';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isActive ? AppColors.accentGreen : AppColors.linkBlue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.auto_stories,
              color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
              size: 22,
            ),
          ),
          title: Text(assignment.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Class: ${assignment.className}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(width: 8),
                    Text('Subject: ${assignment.subject}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.book, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(assignment.bookTitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.date_range, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('${assignment.assignedDate} to ${assignment.dueDate}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? AppColors.accentGreen : AppColors.linkBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(assignment.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        );
      },
    );
  }
}
