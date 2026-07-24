import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../components/empty_state.dart';
import '../../components/grade_book_widgets.dart';
import '../../components/common_widgets.dart';
import '../../services/data_service.dart';
import '../../utils/page_transitions.dart';
import '../../providers/naac_state.dart';
import 'sqa_detail_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureGridTile(
                icon: Icons.verified,
                label: 'SQAA',
                hasFavoriteStar: true,
                isFavorite: false,
                onFavoriteToggle: (_) {},
                onTap: () => Navigator.push(context, SlideRightRoute(page: const SqaaScreen())),
              ),
              FeatureGridTile(
                icon: Icons.assessment,
                label: 'NAAC and NIRF',
                hasFavoriteStar: true,
                isFavorite: false,
                onFavoriteToggle: (_) {},
                onTap: () => Navigator.push(context, SlideRightRoute(page: const NaacNirfHomeScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SqaaScreen extends StatelessWidget {
  const SqaaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SQAA'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _AccordionSection(
            title: 'HSE (Health, Safety and Environment)',
            children: [
              _subItem('Safety Policies', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Safety Policies', category: 'hse')))),
              _subItem('Health Protocols', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Health Protocols', category: 'hse')))),
              _subItem('Environment Guidelines', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Environment Guidelines', category: 'hse')))),
            ],
          ),
          _AccordionSection(
            title: 'Compliance',
            children: [
              _subItem('Regulatory Compliance', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Regulatory Compliance', category: 'compliance')))),
              _subItem('Internal Audits', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Internal Audits', category: 'compliance')))),
            ],
          ),
          _AccordionSection(
            title: 'Framework and Documents',
            children: [
              _subItem('Quality Framework', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Quality Framework', category: 'framework')))),
              _subItem('Policy Documents', () => Navigator.push(context, SlideRightRoute(page: const SqaDetailScreen(title: 'Policy Documents', category: 'framework')))),
            ],
          ),
          const Divider(),
          ListTile(
            title: const Text('SQAA Core Learning Team Designations', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () => Navigator.push(context, SlideRightRoute(page: const SqaaDesignationsScreen())),
          ),
        ],
      ),
    );
  }

  static Widget _subItem(String label, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 48, right: 16),
      title: Text(label, style: const TextStyle(fontSize: 13)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

class _AccordionSection extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const _AccordionSection({required this.title, required this.children});

  @override
  State<_AccordionSection> createState() => _AccordionSectionState();
}

class _AccordionSectionState extends State<_AccordionSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
          onTap: () => setState(() => isExpanded = !isExpanded),
        ),
        if (isExpanded) ...widget.children,
        const Divider(height: 1),
      ],
    );
  }
}

class SqaaDesignationsScreen extends StatelessWidget {
  const SqaaDesignationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final designations = [
      _Designation('Team Leader', 'Dr. Priya Sharma', 'Quality Assurance & Accreditation'),
      _Designation('Co-Leader', 'Mr. Amit Kumar', 'Document Management'),
      _Designation('Member', 'Mrs. Radhika Jaiswal', 'Curriculum Development'),
      _Designation('Member', 'Mr. Rajesh Patil', 'Student Feedback'),
      _Designation('Member', 'Ms. Sneha Reddy', 'Research & Publications'),
      _Designation('Member', 'Mr. Vikram Singh', 'Infrastructure & Safety'),
      _Designation('Member', 'Mrs. Kavita Nair', 'Co-curricular Activities'),
      _Designation('Member', 'Mr. Suresh Gupta', 'Alumni Relations'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SQAA Core Learning Team'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: AppColors.primaryRed.withOpacity(0.05),
            child: const Text('Infant Jesus High School, Nallasopara', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: designations.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (ctx, i) {
                final d = designations[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                    child: Text(d.name[0], style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700)),
                  ),
                  title: Text(d.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  subtitle: Text(d.role, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(d.designation, style: const TextStyle(fontSize: 10, color: AppColors.primaryRed, fontWeight: FontWeight.w600)),
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

class _Designation {
  final String designation;
  final String name;
  final String role;
  _Designation(this.designation, this.name, this.role);
}

class NaacNirfHomeScreen extends StatelessWidget {
  const NaacNirfHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NAAC and NIRF'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('NAAC Statement Documents', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, SlideRightRoute(page: const NaacDocumentsScreen())),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('NAAC Statement Grades', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, SlideRightRoute(page: const NaacGradesScreen())),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('NAAC Statement Grades Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, SlideRightRoute(page: const NaacGradesSummaryScreen())),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('NIRF Framework', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, SlideRightRoute(page: const NirfFrameworkScreen())),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class NaacDocumentsScreen extends StatefulWidget {
  const NaacDocumentsScreen({super.key});

  @override
  State<NaacDocumentsScreen> createState() => _NaacDocumentsScreenState();
}

class _NaacDocumentsScreenState extends State<NaacDocumentsScreen> {
  String? selectedCategory;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    final documents = dataService.naacDocuments;
    final categories = documents.map((d) => d.category).toSet().toList()..sort();
    final years = documents.map((d) {
      final parts = d.uploadDate.split(' ');
      return parts.last;
    }).toSet().toList()..sort((a, b) => b.compareTo(a));

    final filtered = documents.where((d) {
      if (selectedCategory != null && d.category != selectedCategory) return false;
      if (selectedYear != null && !d.uploadDate.endsWith(selectedYear!)) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NAAC Statement Documents'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accentGreen, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        value: selectedCategory,
                        hint: const Text('All Categories', style: TextStyle(fontSize: 12)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                        items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)))).toList(),
                        onChanged: (v) => setState(() => selectedCategory = v),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accentGreen, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        value: selectedYear,
                        hint: const Text('All Years', style: TextStyle(fontSize: 12)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                        items: years.map((y) => DropdownMenuItem(value: y, child: Text(y, style: const TextStyle(fontSize: 12)))).toList(),
                        onChanged: (v) => setState(() => selectedYear = v),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No documents found', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final doc = filtered[i];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.description, color: AppColors.primaryRed, size: 20),
                        ),
                        title: Text(doc.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(doc.category, style: const TextStyle(fontSize: 10, color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 8),
                            Text(doc.uploadDate, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                          ],
                        ),
                        trailing: Text('by ${doc.uploadedBy}', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: '+ Upload Documents',
          onPressed: () {},
          width: double.infinity,
        ),
      ),
    );
  }
}

class NaacGradesScreen extends StatelessWidget {
  const NaacGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final naacState = context.watch<NaacState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NAAC Statement Grades'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: naacState.sections.map((s) => Tab(text: s.name)).toList(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: _buildDropdown('School', naacState.selectedSchool, ['Infant Jesus'], (v) => naacState.setSchool(v!))),
                const SizedBox(width: 8),
                Expanded(child: _buildDropdown('Year', naacState.selectedYear, ['2026-2027', '2025-2026'], (v) => naacState.setYear(v!))),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: naacState.sections.map((section) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: section.keyIndicators.length,
                  itemBuilder: (ctx, i) {
                    final ki = section.keyIndicators[i];
                    return KeyIndicatorCard(
                      title: ki.title,
                      code: ki.code,
                      gradeOptions: ['A++', 'A+', 'A', 'B++', 'B+', 'B', 'C', 'D'],
                      selectedGrade: naacState.getGrade(ki.id),
                      remarks: naacState.getRemarks(ki.id),
                      onGradeChanged: (v) => naacState.setGrade(ki.id, v),
                      onRemarksChanged: (v) => naacState.setRemarks(ki.id, v),
                      onSave: () => naacState.saveKi(ki.id),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Container(
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
        ),
      ],
    );
  }
}

class NaacGradesSummaryScreen extends StatelessWidget {
  const NaacGradesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final naacState = context.watch<NaacState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NAAC Statement Grades Summary'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildDropdown('School', naacState.selectedSchool, ['Infant Jesus'], (v) => naacState.setSchool(v!))),
                const SizedBox(width: 8),
                Expanded(child: _buildDropdown('Year', naacState.selectedYear, ['2026-2027', '2025-2026'], (v) => naacState.setYear(v!))),
              ],
            ),
            const SizedBox(height: 12),
            ...naacState.sections.map((section) {
              final rows = section.keyIndicators.map((ki) {
                return [
                  ki.title,
                  naacState.getGrade(ki.id) ?? '-',
                  naacState.getRemarks(ki.id) ?? '-',
                ];
              }).toList();
              return SummaryTable(
                title: section.name,
                headers: ['Key Indicators (KIs)', 'Grade', 'Remarks'],
                rows: rows,
              );
            }),
          ],
        ),
      ),
    );
  }

  static Widget _buildDropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Container(
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
              style: const TextStyle(fontSize: 12),
              items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 12)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class NirfFrameworkScreen extends StatelessWidget {
  const NirfFrameworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parameters = dataService.nirfParameters;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NIRF Framework'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('School', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accentGreen, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: 'Infant Jesus',
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                            items: const [DropdownMenuItem(value: 'Infant Jesus', child: Text('Infant Jesus', style: TextStyle(fontSize: 12)))],
                            onChanged: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Year', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accentGreen, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: '2026-2027',
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                            items: const [DropdownMenuItem(value: '2026-2027', child: Text('2026-2027', style: TextStyle(fontSize: 12)))],
                            onChanged: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: parameters.length,
              itemBuilder: (ctx, i) {
                final p = parameters[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.parameter, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.6,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _StatItem(label: 'Weightage', value: p.weightage.toStringAsFixed(2)),
                            _StatItem(label: 'Statements', value: '${p.statements}'),
                            _StatItem(label: 'Benchmarks', value: p.benchmarks != null ? '${p.benchmarks}' : '–'),
                            _StatItem(label: 'Score', value: p.score ?? '–'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryRed,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Proceed', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
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
