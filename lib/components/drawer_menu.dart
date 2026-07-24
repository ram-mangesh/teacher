import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class DrawerMenu extends StatelessWidget {
  final List<MenuSection> sections;
  final Function(String) onItemTap;

  const DrawerMenu({
    super.key,
    required this.sections,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text('Smart MCB', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: sections.length,
              itemBuilder: (context, sectionIndex) {
                return _ExpandableSection(
                  section: sections[sectionIndex],
                  onItemTap: onItemTap,
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Version: 3.4.0', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: AppColors.primaryRed, size: 18),
                    label: const Text('Logout', style: TextStyle(color: AppColors.primaryRed)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryRed),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableSection extends StatefulWidget {
  final MenuSection section;
  final Function(String) onItemTap;

  const _ExpandableSection({required this.section, required this.onItemTap});

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.section.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...widget.section.items.map((item) => _ExpandableItem(
                item: item,
                onItemTap: widget.onItemTap,
              )),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}

class _ExpandableItem extends StatefulWidget {
  final MenuItem item;
  final Function(String) onItemTap;

  const _ExpandableItem({required this.item, required this.onItemTap});

  @override
  State<_ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<_ExpandableItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.item.children != null && widget.item.children!.isNotEmpty;

    if (!hasChildren) {
      return ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(left: 32, right: 16),
        leading: Icon(_getIconData(widget.item.icon ?? ''), size: 20, color: AppColors.textSecondary),
        title: Text(widget.item.label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
        onTap: () {
          Navigator.pop(context);
          widget.onItemTap(widget.item.label);
        },
      );
    }

    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 32, right: 16),
          leading: Icon(_getIconData(widget.item.icon ?? ''), size: 20, color: AppColors.textSecondary),
          title: Text(widget.item.label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 18,
            color: AppColors.textSecondary,
          ),
          onTap: () => setState(() => isExpanded = !isExpanded),
        ),
        if (isExpanded)
          ...widget.item.children!.map((child) => ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 56, right: 16),
                title: Text(child, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                trailing: const Icon(Icons.chevron_right, size: 16, color: AppColors.dividerGrey),
                onTap: () {
                  Navigator.pop(context);
                  widget.onItemTap(child);
                },
              )),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'people': return Icons.people;
      case 'assignment': return Icons.assignment;
      case 'pie_chart': return Icons.pie_chart;
      case 'feedback': return Icons.feedback;
      case 'event': return Icons.event;
      case 'analytics': return Icons.analytics;
      case 'check_circle': return Icons.check_circle;
      case 'schedule': return Icons.schedule;
      case 'how_to_reg': return Icons.how_to_reg;
      case 'note': return Icons.note;
      case 'school': return Icons.school;
      case 'table_chart': return Icons.table_chart;
      case 'business': return Icons.business;
      case 'wall_art': return Icons.wallpaper;
      case 'groups': return Icons.groups;
      case 'menu_book': return Icons.menu_book;
      case 'trending_up': return Icons.trending_up;
      case 'grading': return Icons.grading;
      case 'emoji_events': return Icons.emoji_events;
      case 'star': return Icons.star;
      case 'remark': return Icons.comment;
      case 'rate_review': return Icons.rate_review;
      case 'assignment_turned_in': return Icons.assignment_turned_in;
      case 'edit_note': return Icons.edit_note;
      case 'auto_stories': return Icons.auto_stories;
      case 'sms': return Icons.sms;
      case 'send': return Icons.send;
      case 'campaign': return Icons.campaign;
      case 'calendar_month': return Icons.calendar_month;
      case 'receipt_long': return Icons.receipt_long;
      case 'directions_bus': return Icons.directions_bus;
      case 'badge': return Icons.badge;
      case 'description': return Icons.description;
      case 'receipt': return Icons.receipt;
      case 'leave_bags_at_home': return Icons.leave_bags_at_home;
      case 'contact_phone': return Icons.contact_phone;
      case 'chat': return Icons.chat;
      case 'photo_library': return Icons.photo_library;
      case 'verified': return Icons.verified;
      case 'assessment': return Icons.assessment;
      default: return Icons.folder;
    }
  }
}
