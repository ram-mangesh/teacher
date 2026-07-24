import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/data_service.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payslips = dataService.payslips;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payslip / Salary Slip'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: payslips.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt, size: 80, color: AppColors.dividerGrey),
                  SizedBox(height: 16),
                  Text('No Payslips Available', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: payslips.length,
              itemBuilder: (ctx, i) {
                final p = payslips[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryRed,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.receipt, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text('${p.month} ${p.year}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                              child: Text(p.status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Earnings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accentGreen)),
                            ),
                            const SizedBox(height: 6),
                            _payRow('Basic Pay', '₹${p.basicPay.toStringAsFixed(0)}'),
                            _payRow('HRA', '₹${p.hra.toStringAsFixed(0)}'),
                            _payRow('DA', '₹${p.da.toStringAsFixed(0)}'),
                            _payRow('TA', '₹${p.ta.toStringAsFixed(0)}'),
                            _payRow('Gross Earnings', '₹${p.grossEarnings.toStringAsFixed(0)}', isBold: true, color: AppColors.accentGreen),
                            const Divider(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Deductions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryRed)),
                            ),
                            const SizedBox(height: 6),
                            _payRow('PF', '₹${p.pf.toStringAsFixed(0)}'),
                            _payRow('Professional Tax', '₹${p.pt.toStringAsFixed(0)}'),
                            _payRow('Income Tax', '₹${p.it.toStringAsFixed(0)}'),
                            _payRow('Total Deductions', '₹${p.totalDeductions.toStringAsFixed(0)}', isBold: true, color: AppColors.primaryRed),
                            const Divider(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.accentGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Net Pay', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                                  Text('₹${p.netPay.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.accentGreen)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Payslip download started'), backgroundColor: AppColors.accentGreen),
                                  );
                                },
                                icon: const Icon(Icons.download, size: 16, color: AppColors.primaryRed),
                                label: const Text('Download PDF', style: TextStyle(color: AppColors.primaryRed)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.primaryRed),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
              },
            ),
    );
  }

  Widget _payRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: isBold ? FontWeight.w700 : FontWeight.w400)),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: color)),
        ],
      ),
    );
  }
}
