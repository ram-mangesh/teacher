import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  List<_SearchResult> _results = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _query = q;
      if (q.isEmpty) {
        _results = [];
        return;
      }
      _results = _allItems.where((item) =>
        item.title.toLowerCase().contains(q) ||
        item.module.toLowerCase().contains(q)
      ).toList();
    });
  }

  static final List<_SearchResult> _allItems = [
    _SearchResult('SIS', 'ERP', Icons.people),
    _SearchResult('Period Wise Attendance Report', 'ERP', Icons.assignment),
    _SearchResult('Period Wise Attendance Percentage Report', 'ERP', Icons.pie_chart),
    _SearchResult('Give PTM Feedback', 'ERP', Icons.feedback),
    _SearchResult('Manage PTM', 'ERP', Icons.event),
    _SearchResult('Student Report', 'ERP', Icons.analytics),
    _SearchResult('Give Attendance', 'ERP', Icons.check_circle),
    _SearchResult('Period Wise Attendance', 'ERP', Icons.schedule),
    _SearchResult('Professional Student Attendance', 'ERP', Icons.how_to_reg),
    _SearchResult('Parent Notes / Leave Intimations', 'ERP', Icons.note),
    _SearchResult('Learning Based Assessment', 'ERP', Icons.school),
    _SearchResult('Time Table', 'ERP', Icons.table_chart),
    _SearchResult('Fee Collection', 'ERP', Icons.receipt_long),
    _SearchResult('Transport', 'ERP', Icons.directions_bus),
    _SearchResult('ID Card', 'ERP', Icons.badge),
    _SearchResult('Library', 'ERP', Icons.menu_book),
    _SearchResult('Certificates', 'ERP', Icons.description),
    _SearchResult('HR', 'HR', Icons.business),
    _SearchResult('Staff Wall', 'HR', Icons.wallpaper),
    _SearchResult('Staff Meetings', 'HR', Icons.groups),
    _SearchResult('Payslip', 'HR', Icons.receipt),
    _SearchResult('Leave Application', 'HR', Icons.leave_bags_at_home),
    _SearchResult('Staff Directory', 'HR', Icons.contact_phone),
    _SearchResult('CBSE and State', 'GRADE BOOK', Icons.menu_book),
    _SearchResult('Subject Outcomes', 'GRADE BOOK', Icons.trending_up),
    _SearchResult('Test and Marks', 'GRADE BOOK', Icons.grading),
    _SearchResult('Examination Marks', 'GRADE BOOK', Icons.emoji_events),
    _SearchResult('CoScholastic Grade Entry', 'GRADE BOOK', Icons.star),
    _SearchResult('Student Remarks', 'GRADE BOOK', Icons.comment),
    _SearchResult('Class Teacher Remarks', 'GRADE BOOK', Icons.rate_review),
    _SearchResult('Assignments', 'LMS', Icons.assignment_turned_in),
    _SearchResult('Online Worksheet', 'LMS', Icons.edit_note),
    _SearchResult('Reading Assignment', 'LMS', Icons.auto_stories),
    _SearchResult('SMS', 'CONNECT', Icons.sms),
    _SearchResult('Send SMS', 'CONNECT', Icons.send),
    _SearchResult('Announcements', 'CONNECT', Icons.campaign),
    _SearchResult('Calendar', 'CONNECT', Icons.calendar_month),
    _SearchResult('Chat', 'CONNECT', Icons.chat),
    _SearchResult('Gallery', 'CONNECT', Icons.photo_library),
    _SearchResult('SQAA', 'ADMIN', Icons.verified),
    _SearchResult('NAAC and NIRF', 'ADMIN', Icons.assessment),
    _SearchResult('SQAA Detail', 'ADMIN', Icons.info),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Search'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search features, modules...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          if (_query.isNotEmpty && _results.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60, color: AppColors.dividerGrey),
                    SizedBox(height: 12),
                    Text('No results found', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
            )
          else if (_query.isEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _allItems.length,
                itemBuilder: (ctx, i) => _buildResultTile(_allItems[i]),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _results.length,
                itemBuilder: (ctx, i) => _buildResultTile(_results[i]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultTile(_SearchResult result) {
    return Column(
      children: [
        ListTile(
          leading: Icon(result.icon, color: AppColors.primaryRed, size: 22),
          title: Text(result.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          subtitle: Text(result.module, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          onTap: () => Navigator.pop(context),
        ),
        const Divider(height: 1, indent: 56),
      ],
    );
  }
}

class _SearchResult {
  final String title;
  final String module;
  final IconData icon;
  _SearchResult(this.title, this.module, this.icon);
}
