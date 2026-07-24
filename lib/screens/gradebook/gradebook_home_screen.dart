import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../components/common_widgets.dart';
import '../../models/models.dart';
import '../../services/data_service.dart';
import '../../utils/page_transitions.dart';

class GradeBookHomeScreen extends StatefulWidget {
  const GradeBookHomeScreen({super.key});

  @override
  State<GradeBookHomeScreen> createState() => _GradeBookHomeScreenState();
}

class _GradeBookHomeScreenState extends State<GradeBookHomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                icon: Icons.menu_book,
                label: 'CBSE and State',
                hasFavoriteStar: true,
                isFavorite: false,
                onFavoriteToggle: (_) {},
                onTap: () => Navigator.push(context, SlideRightRoute(page: const CBSEStateScreen())),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildListRow('Subject Outcomes', Icons.trending_up, () => Navigator.push(context, SlideRightRoute(page: const SubjectOutcomesScreen()))),
          _buildListRow('Test and Marks', Icons.grading, () => Navigator.push(context, SlideRightRoute(page: const TestAndMarksScreen()))),
          _buildListRow('Examination Marks', Icons.emoji_events, () => Navigator.push(context, SlideRightRoute(page: const ExaminationMarksScreen()))),
          _buildListRow('CoScholastic Grade Entry', Icons.star, () => Navigator.push(context, SlideRightRoute(page: const CoScholasticScreen()))),
          _buildListRow('Student Remarks', Icons.comment, () => Navigator.push(context, SlideRightRoute(page: const StudentRemarksScreen()))),
          _buildListRow('Class Teacher Remarks', Icons.rate_review, () => Navigator.push(context, SlideRightRoute(page: const ClassTeacherRemarksScreen()))),
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

}

// CBSE and State Screen
class CBSEStateScreen extends StatelessWidget {
  const CBSEStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CBSE and State'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBoardCard(
            context,
            title: 'CBSE Board',
            subtitle: 'Central Board of Secondary Education',
            icon: Icons.school,
            color: const Color(0xFF1976D2),
            details: [
              'Affiliation No: 1130456',
              'School Code: 09876',
              'Medium: English',
              'Grading: CGPA (Continuous & Comprehensive Evaluation)',
              'Classes: I - X',
            ],
          ),
          const SizedBox(height: 16),
          _buildBoardCard(
            context,
            title: 'State Board',
            subtitle: 'Maharashtra State Board',
            icon: Icons.account_balance,
            color: const Color(0xFF388E3C),
            details: [
              'Affiliation No: MHB-2019-0456',
              'Medium: English / Marathi',
              'Grading: Percentage based',
              'Classes: I - X',
              'Syllabus: Maharashtra State Curriculum',
            ],
          ),
          const SizedBox(height: 24),
          const Text('Academic Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _infoRow('Academic Year', '2026-2027'),
          _infoRow('Total Students', '347'),
          _infoRow('Total Staff', '28'),
          _infoRow('Classes', 'I - X'),
          _infoRow('Sections per Class', '6 (A - F)'),
          _infoRow('Exam Pattern', 'FA1 + FA2 + SA1 + FA3 + FA4 + SA2'),
        ],
      ),
    );
  }

  static Widget _buildBoardCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required List<String> details}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: AppColors.accentGreen),
                    const SizedBox(width: 8),
                    Expanded(child: Text(d, style: const TextStyle(fontSize: 13))),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// Subject Outcomes Screen
class SubjectOutcomesScreen extends StatefulWidget {
  const SubjectOutcomesScreen();

  @override
  State<SubjectOutcomesScreen> createState() => _SubjectOutcomesScreenState();
}

class _SubjectOutcomesScreenState extends State<SubjectOutcomesScreen> {
  String _selectedClass = 'Class 9';
  String _selectedSection = 'A';
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.subjectOutcomes : <SubjectOutcomeRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Outcomes'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', _selectedClass, ['Class 9', 'Class 10'], (v) => setState(() => _selectedClass = v!)),
            const SizedBox(height: 12),
            _dropdown('Section', _selectedSection, ['A', 'B', 'C', 'D', 'E', 'F'], (v) => setState(() => _selectedSection = v!)),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 12),
            _dropdown('Evaluation', 'Term Wise', dataService.getEvaluations('subjectOutcomes'), null),
            const SizedBox(height: 12),
            _dropdown('Subject', 'Computer', dataService.subjects, null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Get',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              Text('Subject Outcomes - $_selectedClass $_selectedSection', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                ...data.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                      child: Text(r.studentName[0], style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                    title: Text(r.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    subtitle: Text('${r.learningGoal} • ${r.subject}', style: const TextStyle(fontSize: 11)),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _gradeColor(r.grade),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(r.grade, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                  ),
                )),
            ],
          ],
        ),
      ),
    );
  }

  static Color _gradeColor(String grade) {
    switch (grade) {
      case 'A+': return const Color(0xFF388E3C);
      case 'A': return const Color(0xFF4CAF50);
      case 'B+': return const Color(0xFFFF9800);
      case 'B': return const Color(0xFFFF5722);
      default: return AppColors.textSecondary;
    }
  }
}

// Test and Marks Screen
class TestAndMarksScreen extends StatefulWidget {
  const TestAndMarksScreen();

  @override
  State<TestAndMarksScreen> createState() => _TestAndMarksScreenState();
}

class _TestAndMarksScreenState extends State<TestAndMarksScreen> {
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.testMarks : <TestMarkRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test and Marks'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', 'Class 9', ['Class 9', 'Class 10'], null),
            const SizedBox(height: 12),
            _dropdown('Section', 'A', ['A', 'B', 'C', 'D', 'E', 'F'], null),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 12),
            _dropdown('Evaluation', dataService.getEvaluations('testAndMarks').first, dataService.getEvaluations('testAndMarks'), null),
            const SizedBox(height: 12),
            _dropdown('Subject', 'Computer', dataService.subjects, null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Get',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Test Results', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: WidgetStateProperty.all(AppColors.backgroundGrey),
                      columns: const [
                        DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Test', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Max', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Obtained', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('%', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      ],
                      rows: data.map((r) => DataRow(cells: [
                        DataCell(Text(r.studentName, style: const TextStyle(fontSize: 12))),
                        DataCell(Text(r.testName, style: const TextStyle(fontSize: 12))),
                        DataCell(Text('${r.maxMarks}', style: const TextStyle(fontSize: 12))),
                        DataCell(Text('${r.marksObtained}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                        DataCell(Text(r.percentage, style: TextStyle(fontSize: 12, color: _percentColor(r.marksObtained, r.maxMarks), fontWeight: FontWeight.w600))),
                      ])).toList(),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  static Color _percentColor(int obtained, int max) {
    final pct = obtained / max;
    if (pct >= 0.8) return const Color(0xFF388E3C);
    if (pct >= 0.6) return const Color(0xFFFF9800);
    return const Color(0xFFFF5722);
  }
}

// Examination Marks Screen
class ExaminationMarksScreen extends StatefulWidget {
  const ExaminationMarksScreen();

  @override
  State<ExaminationMarksScreen> createState() => _ExaminationMarksScreenState();
}

class _ExaminationMarksScreenState extends State<ExaminationMarksScreen> {
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.examMarks : <ExamMarkRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Examination Marks'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', 'Class 9', ['Class 9', 'Class 10'], null),
            const SizedBox(height: 12),
            _dropdown('Section', 'A', ['A', 'B', 'C', 'D', 'E', 'F'], null),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 12),
            _dropdown('Examination', dataService.getEvaluations('examinationMarks').first, dataService.getEvaluations('examinationMarks'), null),
            const SizedBox(height: 12),
            _dropdown('Subject', 'Computer', dataService.subjects, null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Get',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Exam Results', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                ...data.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _gradeBgColor(r.grade).withOpacity(0.15),
                      child: Text(r.grade, style: TextStyle(color: _gradeBgColor(r.grade), fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                    title: Text(r.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    subtitle: Text('${r.examName} • ${r.marksObtained}/${r.maxMarks}', style: const TextStyle(fontSize: 11)),
                    trailing: Text(r.percentage, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _gradeBgColor(r.grade))),
                  ),
                )),
              const SizedBox(height: 12),
              Card(
                color: AppColors.backgroundGrey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _stat('Average', '${(data.fold(0, (sum, r) => sum + r.marksObtained) / data.fold(0, (sum, r) => sum + r.maxMarks) * 100).toStringAsFixed(1)}%'),
                      _stat('Highest', '${data.map((r) => r.marksObtained).reduce((a, b) => a > b ? a : b)}/${data.first.maxMarks}'),
                      _stat('Pass Rate', '${((data.where((r) => r.marksObtained >= r.maxMarks * 0.33).length / data.length) * 100).toStringAsFixed(0)}%'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryRed)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  static Color _gradeBgColor(String grade) {
    switch (grade) {
      case 'A+': return const Color(0xFF388E3C);
      case 'A': return const Color(0xFF4CAF50);
      case 'B+': return const Color(0xFFFF9800);
      case 'B': return const Color(0xFFFF5722);
      default: return AppColors.textSecondary;
    }
  }
}

// CoScholastic Screen
class CoScholasticScreen extends StatefulWidget {
  const CoScholasticScreen();

  @override
  State<CoScholasticScreen> createState() => _CoScholasticScreenState();
}

class _CoScholasticScreenState extends State<CoScholasticScreen> {
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.coScholasticRecords : <CoScholasticRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('CoScholastic Grade Entry'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', 'Class 9', ['Class 9', 'Class 10'], null),
            const SizedBox(height: 12),
            _dropdown('Section', 'A', ['A', 'B', 'C', 'D', 'E', 'F'], null),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 12),
            _dropdown('Part', 'Co-Scholastic (Skill wise grading)', ['Co-Scholastic (Skill wise grading)'], null),
            const SizedBox(height: 12),
            _dropdown('Skill', 'Art & Craft', ['Art & Craft', 'Music', 'Physical Education', 'Work Education'], null),
            const SizedBox(height: 12),
            _dropdown('Assessment', 'Assessment 1', ['Assessment 1', 'Assessment 2'], null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Proceed',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
                isGreen: true,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text('CoScholastic Grades', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: WidgetStateProperty.all(AppColors.backgroundGrey),
                      columns: const [
                        DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Roll No', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Skill', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        DataColumn(label: Text('Grade', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      ],
                      rows: data.map((r) => DataRow(cells: [
                        DataCell(Text(r.studentName, style: const TextStyle(fontSize: 12))),
                        DataCell(Text(r.rollNo, style: const TextStyle(fontSize: 12))),
                        DataCell(Text(r.skill, style: const TextStyle(fontSize: 12))),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _coscholasticGradeColor(r.grade),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(r.grade, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                        )),
                      ])).toList(),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  static Color _coscholasticGradeColor(String grade) {
    switch (grade) {
      case 'A1': return const Color(0xFF388E3C);
      case 'A2': return const Color(0xFF4CAF50);
      case 'B1': return const Color(0xFFFF9800);
      case 'B2': return const Color(0xFFFF5722);
      case 'C1': return const Color(0xFF9E9E9E);
      default: return AppColors.textSecondary;
    }
  }
}

// Student Remarks Screen
class StudentRemarksScreen extends StatefulWidget {
  const StudentRemarksScreen();

  @override
  State<StudentRemarksScreen> createState() => _StudentRemarksScreenState();
}

class _StudentRemarksScreenState extends State<StudentRemarksScreen> {
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.studentRemarks : <StudentRemarkRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Remarks'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', 'Class 9', ['Class 9', 'Class 10'], null),
            const SizedBox(height: 12),
            _dropdown('Section', 'A', ['A', 'B', 'C', 'D', 'E', 'F'], null),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 12),
            _dropdown('Evaluation', 'All', ['All', 'Term Wise'], null),
            const SizedBox(height: 12),
            _dropdown('Field', 'MyGoals', ['MyGoals', 'Remarks', 'Overall'], null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Get Students',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Student Remarks', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                ...data.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.linkBlue.withOpacity(0.1),
                      child: Text(r.studentName[0], style: const TextStyle(color: AppColors.linkBlue, fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                    title: Text(r.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(r.remark, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.linkBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(r.field, style: const TextStyle(fontSize: 10, color: AppColors.linkBlue, fontWeight: FontWeight.w600)),
                    ),
                  ),
                )),
            ],
          ],
        ),
      ),
    );
  }
}

// Class Teacher Remarks Screen
class ClassTeacherRemarksScreen extends StatefulWidget {
  const ClassTeacherRemarksScreen();

  @override
  State<ClassTeacherRemarksScreen> createState() => _ClassTeacherRemarksScreenState();
}

class _ClassTeacherRemarksScreenState extends State<ClassTeacherRemarksScreen> {
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final data = _dataLoaded ? dataService.classTeacherRemarks : <ClassTeacherRemarkRecord>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Teacher Remarks'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dropdown('Class', 'Class 9', ['Class 9', 'Class 10'], null),
            const SizedBox(height: 12),
            _dropdown('Section', 'A', ['A', 'B', 'C', 'D', 'E', 'F'], null),
            const SizedBox(height: 12),
            _dropdown('Terms', dataService.terms.first, dataService.terms, null),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: 'Get Students',
                onPressed: () => setState(() => _dataLoaded = true),
                width: 200,
              ),
            ),
            if (_dataLoaded) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Class Teacher Remarks', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              if (data.isEmpty)
                const Center(child: Text('No data found', style: TextStyle(color: AppColors.textSecondary)))
              else
                ...data.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.accentGreen.withOpacity(0.1),
                              child: Text(r.studentName[0], style: const TextStyle(color: AppColors.accentGreen, fontWeight: FontWeight.w700, fontSize: 14)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                Text('Roll No: ${r.rollNo} • ${r.classSection}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1),
                        const SizedBox(height: 10),
                        Text(r.remark, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4)),
                      ],
                    ),
                  ),
                )),
            ],
          ],
        ),
      ),
    );
  }
}

// Shared dropdown helper
Widget _dropdown(String label, String value, List<String> options, ValueChanged<String?>? onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      const SizedBox(height: 4),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dividerGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
            items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 13)))).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}
