import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class GradeBookForm extends StatelessWidget {
  final String title;
  final List<FormFieldConfig> fields;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isGreenButton;

  const GradeBookForm({
    super.key,
    required this.title,
    required this.fields,
    required this.buttonText,
    this.onPressed,
    this.isGreenButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...fields.map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(field.label, style: AppTextStyles.formLabel),
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
                        value: field.selectedValue,
                        hint: Text(field.hint ?? 'Select', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        items: (field.options ?? []).map((o) => DropdownMenuItem(
                          value: o,
                          child: Text(o, style: const TextStyle(fontSize: 13)),
                        )).toList(),
                        onChanged: field.onChanged,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: buttonText,
                onPressed: onPressed,
                isGreen: isGreenButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormFieldConfig {
  final String label;
  final String? hint;
  final String? selectedValue;
  final List<String>? options;
  final ValueChanged<String?>? onChanged;

  FormFieldConfig({
    required this.label,
    this.hint,
    this.selectedValue,
    this.options,
    this.onChanged,
  });
}

class KeyIndicatorCard extends StatelessWidget {
  final String title;
  final String? code;
  final List<String> gradeOptions;
  final String? selectedGrade;
  final String? remarks;
  final ValueChanged<String?>? onGradeChanged;
  final ValueChanged<String?>? onRemarksChanged;
  final VoidCallback? onSave;

  const KeyIndicatorCard({
    super.key,
    required this.title,
    this.code,
    this.gradeOptions = const [],
    this.selectedGrade,
    this.remarks,
    this.onGradeChanged,
    this.onRemarksChanged,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${code != null ? '$code ' : ''}$title',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: onSave,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
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
                        value: selectedGrade,
                        hint: const Text('Select Grade', style: TextStyle(fontSize: 12)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                        style: const TextStyle(fontSize: 12),
                        items: gradeOptions.map((g) => DropdownMenuItem(value: g, child: Text(g, style: const TextStyle(fontSize: 12)))).toList(),
                        onChanged: onGradeChanged,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              key: ValueKey(remarks),
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Remarks',
                hintStyle: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.dividerGrey)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              controller: TextEditingController(text: remarks),
              onChanged: onRemarksChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryTable extends StatelessWidget {
  final String title;
  final List<String> headers;
  final List<List<String>> rows;

  const SummaryTable({
    super.key,
    required this.title,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.cardRadius)),
            ),
            child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Table(
            border: TableBorder.all(color: AppColors.dividerGrey, width: 0.5),
            columnWidths: {for (var i = 0; i < headers.length; i) i: const FlexColumnWidth(1.5)},
            children: [
              TableRow(
                decoration: const BoxDecoration(color: AppColors.backgroundGrey),
                children: headers.map((h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(h, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                )).toList(),
              ),
              ...rows.map((row) => TableRow(
                children: row.map((cell) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(cell, style: const TextStyle(fontSize: 11)),
                )).toList(),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
