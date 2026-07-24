import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ListRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const ListRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(icon, color: AppColors.primaryRed, size: 22),
          title: Text(title, style: AppTextStyles.listItemTitle),
          subtitle: subtitle != null ? Text(subtitle!, style: AppTextStyles.listItemSubtitle) : null,
          trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          onTap: onTap,
        ),
        if (showDivider) const Divider(height: 1, indent: 56),
      ],
    );
  }
}

class DropdownFilterBar extends StatelessWidget {
  final List<FilterChipData> chips;

  const DropdownFilterBar({super.key, required this.chips});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: chips.map((chip) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _FilterChipDropdown(data: chip),
          ),
        )).toList(),
      ),
    );
  }
}

class FilterChipData {
  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  FilterChipData({
    required this.label,
    this.value,
    this.options = const [],
    this.onChanged,
  });
}

class _FilterChipDropdown extends StatelessWidget {
  final FilterChipData data;

  const _FilterChipDropdown({required this.data});

  @override
  Widget build(BuildContext context) {
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
          value: data.value,
          hint: Text(data.label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
          items: data.options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 12)))).toList(),
          onChanged: data.onChanged,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isGreen;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isGreen = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isGreen ? AppColors.accentGreen : AppColors.primaryRed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.buttonRadius)),
          elevation: 2,
        ),
        child: Text(label, style: AppTextStyles.buttonText),
      ),
    );
  }
}

class FavoriteToggle extends StatelessWidget {
  final bool isFavorite;
  final ValueChanged<bool> onChanged;

  const FavoriteToggle({super.key, required this.isFavorite, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isFavorite),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isFavorite ? Icons.star : Icons.star_border, color: AppColors.starYellow, size: 20),
          const SizedBox(width: 4),
          Switch(
            value: isFavorite,
            onChanged: onChanged,
            activeColor: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }
}
