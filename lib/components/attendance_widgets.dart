import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class AttendanceCounter extends StatelessWidget {
  final int total;
  final int present;
  final int absent;

  const AttendanceCounter({
    super.key,
    required this.total,
    required this.present,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.backgroundGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CounterItem(label: 'Total', value: total, color: AppColors.textPrimary),
          _CounterItem(label: 'Present', value: present, color: AppColors.accentGreen),
          _CounterItem(label: 'Absent', value: absent, color: AppColors.primaryRed),
        ],
      ),
    );
  }
}

class _CounterItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _CounterItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            '$value',
            key: ValueKey(value),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color),
          ),
        ),
        Text(label, style: AppTextStyles.statLabel),
      ],
    );
  }
}

class AttendanceStudentRow extends StatelessWidget {
  final StudentAttendanceRecord student;
  final ValueChanged<String> onStatusChanged;

  const AttendanceStudentRow({
    super.key,
    required this.student,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.dividerGrey, width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                student.name[0],
                style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text('Adm: ${student.admissionNo} | Roll: ${student.rollNo}', style: AppTextStyles.listItemSubtitle),
              ],
            ),
          ),
          if (student.isExcused)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Excused', style: TextStyle(fontSize: 10, color: Colors.orange)),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => onStatusChanged(student.status == 'P' ? 'A' : 'P'),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: student.status == 'P' ? AppColors.accentGreen : AppColors.primaryRed,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (student.status == 'P' ? AppColors.accentGreen : AppColors.primaryRed)
                        .withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Text(
                    student.status,
                    key: ValueKey(student.status),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
