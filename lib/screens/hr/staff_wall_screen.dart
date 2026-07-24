import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/empty_state.dart';
import '../../services/data_service.dart';

class StaffWallScreen extends StatefulWidget {
  const StaffWallScreen({super.key});

  @override
  State<StaffWallScreen> createState() => _StaffWallScreenState();
}

class _StaffWallScreenState extends State<StaffWallScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'Last 30 Days';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Staff Wall'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Announcements'),
            Tab(text: 'System Group'),
            Tab(text: 'Custom'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: AppColors.backgroundGrey,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${dataService.currentUser.school} - $_selectedFilter',
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showFilterPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dividerGrey),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_selectedFilter, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                        const Icon(Icons.arrow_drop_down, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final allPosts = dataService.staffWallPosts;
                final tabs = ['All', 'Announcements', 'System Group', 'Custom'];
                final categoryMap = {
                  'All': null,
                  'Announcements': 'Announcement',
                  'System Group': 'System',
                  'Custom': 'Custom',
                };
                final selectedCategory = categoryMap[tabs[_tabController.index]];
                final filtered = selectedCategory == null
                    ? allPosts
                    : allPosts.where((p) => p.category == selectedCategory).toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('No posts found', style: TextStyle(color: AppColors.textSecondary)));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final post = filtered[index];
                    final initial = post.author.isNotEmpty ? post.author[0].toUpperCase() : '?';
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                                  child: Text(initial, style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 14)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post.author, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                      Text(post.date, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentGreen.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(post.category, style: const TextStyle(fontSize: 10, color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(post.content, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showFilterPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Time Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          ...['Last 7 Days', 'Last 14 Days', 'Last 30 Days', 'Last 90 Days', 'All Time'].map(
            (filter) => ListTile(
              title: Text(filter),
              trailing: _selectedFilter == filter ? const Icon(Icons.check, color: AppColors.accentGreen) : null,
              onTap: () {
                setState(() => _selectedFilter = filter);
                Navigator.pop(ctx);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
