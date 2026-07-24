import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';

class StaffDirectoryScreen extends StatefulWidget {
  const StaffDirectoryScreen({super.key});

  @override
  State<StaffDirectoryScreen> createState() => _StaffDirectoryScreenState();
}

class _StaffDirectoryScreenState extends State<StaffDirectoryScreen> {
  String _searchQuery = '';
  String? _selectedDept;

  @override
  Widget build(BuildContext context) {
    final departments = dataService.staffDirectory.map((s) => s.department).toSet().toList();
    final staff = dataService.staffDirectory.where((s) {
      if (_searchQuery.isNotEmpty && !s.name.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      if (_selectedDept != null && s.department != _selectedDept) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Staff Directory'),
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search staff...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accentGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      value: _selectedDept,
                      hint: const Text('Dept', style: TextStyle(fontSize: 11)),
                      icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                      style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                      items: [null, ...departments].map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(d ?? 'All', style: const TextStyle(fontSize: 11)),
                      )).toList(),
                      onChanged: (v) => setState(() => _selectedDept = v),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (staff.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: 80, color: AppColors.dividerGrey),
                    SizedBox(height: 16),
                    Text('No Staff Found', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: staff.length,
                itemBuilder: (ctx, i) {
                  final s = staff[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                        child: Text(
                          s.name.split(' ').map((w) => w[0]).take(2).join(),
                          style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ),
                      title: Text(s.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.designation, style: AppTextStyles.listItemSubtitle),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.linkBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(s.department, style: const TextStyle(fontSize: 9, color: AppColors.linkBlue)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.phone, size: 18, color: AppColors.accentGreen),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.email, size: 18, color: AppColors.linkBlue),
                            onPressed: () {},
                          ),
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
