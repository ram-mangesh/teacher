import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';
import '../../models/models.dart';

class SqaDetailScreen extends StatelessWidget {
  final String title;
  final String category;

  const SqaDetailScreen({super.key, required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    List<SqaDetailItem> items;
    switch (category) {
      case 'hse':
        items = dataService.sqaHseItems;
        break;
      case 'compliance':
        items = dataService.sqaComplianceItems;
        break;
      case 'framework':
        items = dataService.sqaFrameworkItems;
        break;
      default:
        items = [];
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 80, color: AppColors.dividerGrey),
                  SizedBox(height: 16),
                  Text('No Items Found', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: AppColors.primaryRed.withOpacity(0.05),
                  child: Text('${items.length} items', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final item = items[i];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.description, color: AppColors.accentGreen, size: 20),
                        ),
                        title: Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(item.description, style: AppTextStyles.listItemSubtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                            if (item.lastUpdated != null) ...[
                              const SizedBox(height: 4),
                              Text('Last Updated: ${item.lastUpdated}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            ],
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(item.status, style: const TextStyle(fontSize: 10, color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
                        ),
                        onTap: () => _showDetail(context, item),
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

  void _showDetail(BuildContext context, SqaDetailItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (ctx, controller) => SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.dividerGrey, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(item.status, style: const TextStyle(fontSize: 12, color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 16),
              Text(item.description, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
              if (item.lastUpdated != null) ...[
                const SizedBox(height: 12),
                Text('Last Updated: ${item.lastUpdated}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 16, color: AppColors.primaryRed),
                      label: const Text('Edit', style: TextStyle(color: AppColors.primaryRed)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryRed),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file, size: 16),
                      label: const Text('Upload Doc', style: TextStyle(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
