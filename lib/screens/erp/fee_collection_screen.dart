import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/common_widgets.dart';
import '../../services/data_service.dart';

class FeeCollectionScreen extends StatefulWidget {
  const FeeCollectionScreen({super.key});

  @override
  State<FeeCollectionScreen> createState() => _FeeCollectionScreenState();
}

class _FeeCollectionScreenState extends State<FeeCollectionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String? _selectedFeeType;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fees = dataService.feeRecords.where((f) {
      if (_searchQuery.isNotEmpty && !f.studentName.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      if (_selectedFeeType != null && f.feeType != _selectedFeeType) return false;
      return true;
    }).toList();

    final totalPending = fees.where((f) => f.status != 'Paid').fold(0.0, (sum, f) => sum + f.pending);
    final totalCollected = fees.fold(0.0, (sum, f) => sum + f.paid);
    final overdueCount = fees.where((f) => f.status == 'Overdue').length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Fee Collection'),
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
            Tab(text: 'All Fees'),
            Tab(text: 'Pending'),
            Tab(text: 'Paid'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGrey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search students...',
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
                          value: _selectedFeeType,
                          hint: const Text('Type', style: TextStyle(fontSize: 11)),
                          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                          style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                          items: [null, ...dataService.feeTypes].map((t) => DropdownMenuItem(
                            value: t,
                            child: Text(t ?? 'All', style: const TextStyle(fontSize: 11)),
                          )).toList(),
                          onChanged: (v) => setState(() => _selectedFeeType = v),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _summaryChip('Pending', '₹${totalPending.toStringAsFixed(0)}', AppColors.primaryRed),
                    const SizedBox(width: 8),
                    _summaryChip('Collected', '₹${totalCollected.toStringAsFixed(0)}', AppColors.accentGreen),
                    const SizedBox(width: 8),
                    _summaryChip('Overdue', '$overdueCount', Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: fees.isEmpty
                ? const Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 80, color: AppColors.dividerGrey),
                      SizedBox(height: 16),
                      Text('No Fee Records Found', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                    ],
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: fees.length,
                    itemBuilder: (ctx, i) {
                      final fee = fees[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                                    child: Text(fee.studentName[0], style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 14)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(fee.studentName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                        Text('${fee.className} • ${fee.feeType}', style: AppTextStyles.listItemSubtitle),
                                      ],
                                    ),
                                  ),
                                  _statusBadge(fee.status),
                                ],
                              ),
                              const Divider(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _feeDetail('Amount', '₹${fee.amount.toStringAsFixed(0)}'),
                                  _feeDetail('Paid', '₹${fee.paid.toStringAsFixed(0)}'),
                                  _feeDetail('Pending', '₹${fee.pending.toStringAsFixed(0)}'),
                                  _feeDetail('Due', fee.dueDate),
                                ],
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

  Widget _summaryChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
            Text(label, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Paid': color = AppColors.accentGreen; break;
      case 'Partial': color = Colors.orange; break;
      case 'Overdue': color = AppColors.primaryRed; break;
      default: color = AppColors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(status, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
    );
  }

  Widget _feeDetail(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textSecondary)),
      ],
    );
  }
}
