import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/empty_state.dart';
import '../../components/common_widgets.dart';
import '../../services/data_service.dart';

class GivePtmFeedbackScreen extends StatelessWidget {
  const GivePtmFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feedbacks = dataService.ptmFeedbacks;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Give PTM Feedback'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: feedbacks.isEmpty
          ? const EmptyStateWidget(
              type: EmptyStateType.noPTM,
              customMessage: 'No Data Found',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: feedbacks.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final fb = feedbacks[index];
                final isCompleted = fb.status == 'Completed';
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                    child: Text(
                      fb.studentName[0],
                      style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700),
                    ),
                  ),
                  title: Text(fb.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Class: ${fb.className}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(width: 8),
                            Text('Parent: ${fb.parentName}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fb.feedback,
                          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(fb.date, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.accentGreen : AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(fb.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                );
              },
            ),
    );
  }
}

class ManagePtmScreen extends StatefulWidget {
  const ManagePtmScreen({super.key});

  @override
  State<ManagePtmScreen> createState() => _ManagePtmScreenState();
}

class _ManagePtmScreenState extends State<ManagePtmScreen> {
  String? _selectedSchool = 'Infant Jesus';
  String? _selectedYear = '2026-2027';
  String _selectedFilter = 'Upcoming Days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Manage PTM'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: _buildDropdown('School', _selectedSchool, ['Infant Jesus'], (v) => setState(() => _selectedSchool = v))),
                const SizedBox(width: 8),
                Expanded(child: _buildDropdown('Year', _selectedYear, ['2026-2027', '2025-2026'], (v) => setState(() => _selectedYear = v))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ['Upcoming Days', 'All', 'Past'].map((f) {
                final isSelected = _selectedFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : AppColors.textPrimary)),
                    selected: isSelected,
                    selectedColor: AppColors.primaryRed,
                    onSelected: (_) => setState(() => _selectedFilter = f),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildFilteredEvents(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () => _showAddPtmDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
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
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 12)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildFilteredEvents() {
    final allEvents = dataService.ptmEvents;
    final filtered = allEvents.where((e) {
      if (_selectedFilter == 'Upcoming Days') return e.status == 'Upcoming';
      if (_selectedFilter == 'Past') return e.status == 'Past';
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return const EmptyStateWidget(type: EmptyStateType.noPTM, customMessage: 'No PTM Events Found');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final event = filtered[index];
        final isUpcoming = event.status == 'Upcoming';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isUpcoming ? AppColors.accentGreen : AppColors.primaryRed).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.event,
              color: isUpcoming ? AppColors.accentGreen : AppColors.primaryRed,
              size: 22,
            ),
          ),
          title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(event.date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isUpcoming ? AppColors.accentGreen : AppColors.textSecondary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(event.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        );
      },
    );
  }

  void _showAddPtmDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add PTM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _formField('Title'),
            const SizedBox(height: 12),
            _formField('Date'),
            const SizedBox(height: 12),
            _formField('Time'),
            const SizedBox(height: 12),
            _formField('Class'),
            const SizedBox(height: 12),
            _formField('Notes'),
            const SizedBox(height: 16),
            PrimaryButton(label: 'Save PTM', onPressed: () => Navigator.pop(ctx), width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _formField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

class StudentReportScreen extends StatelessWidget {
  const StudentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Student Report'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 14, color: AppColors.primaryRed),
                  SizedBox(width: 4),
                  Text('Mumbai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryRed)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              city: 'Mumbai',
              totalNew: 45,
              totalExisting: 302,
              totalBoys: 178,
              totalGirls: 169,
              children: [
                _buildSchoolCard(
                  school: 'Infant Jesus High School, Nallasopara',
                  newCount: 45,
                  existingCount: 302,
                  boys: 178,
                  girls: 169,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String city,
    required int totalNew,
    required int totalExisting,
    required int totalBoys,
    required int totalGirls,
    required List<Widget> children,
  }) {
    final total = totalNew + totalExisting;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Text(city, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(12)),
                  child: Text('D($total)', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _miniStat('New', '$totalNew', Colors.blue),
                const SizedBox(width: 12),
                _miniStat('Existing', '$totalExisting', AppColors.accentGreen),
                const SizedBox(width: 12),
                _miniStat('Boys', '$totalBoys', Colors.orange),
                const SizedBox(width: 12),
                _miniStat('Girls', '$totalGirls', Colors.purple),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildSchoolCard({
    required String school,
    required int newCount,
    required int existingCount,
    required int boys,
    required int girls,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(school, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              _miniStat('New', '$newCount', Colors.blue),
              const SizedBox(width: 16),
              _miniStat('Existing', '$existingCount', AppColors.accentGreen),
              const SizedBox(width: 16),
              _miniStat('Boys', '$boys', Colors.orange),
              const SizedBox(width: 16),
              _miniStat('Girls', '$girls', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }
}
