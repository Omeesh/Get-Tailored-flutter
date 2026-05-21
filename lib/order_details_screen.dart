import 'package:flutter/material.dart';
import 'app_theme.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String title;
  final String status;
  final String dueDate;
  final String amount;
  final String leadTailor;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.title,
    required this.status,
    required this.dueDate,
    required this.amount,
    required this.leadTailor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: FloatingActionButton.small(
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
          backgroundColor: Colors.transparent,
          heroTag: 'back_order_details',
          elevation: 0,
          child: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID',
                    style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    orderId,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Category', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                            const SizedBox(height: 6),
                            Text(title, style: const TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Total', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                          const SizedBox(height: 6),
                          Text(amount, style: const TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(child: Icon(Icons.checkroom, color: AppColors.primary)),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Lead Tailor', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text(leadTailor, style: const TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Exp. Delivery', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                          const SizedBox(height: 6),
                          Text(dueDate, style: const TextStyle(color: AppColors.primaryContainer, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Timeline title
            Row(
              children: const [
                Icon(Icons.timeline, color: AppColors.primary),
                SizedBox(width: 12),
                Text('Production Timeline', style: TextStyle(color: AppColors.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            // Timeline - simplified vertical list
            Column(
              children: [
                _TimelineItem(title: 'Waiting for Quotation', date: 'Oct 02, 10:30 AM', completed: true),
                _TimelineItem(title: 'Order Quoted', date: 'Oct 03, 02:15 PM', completed: true),
                _TimelineItem(title: 'Order Confirmed', date: 'Oct 04, 11:00 AM', completed: true),
                _TimelineItem(title: 'Tailoring In Progress', date: '', completed: false, active: true),
                _TimelineItem(title: 'Order Ready', date: '', completed: false),
                _TimelineItem(title: 'Ready for Testing', date: '', completed: false),
                _TimelineItem(title: 'Sent for Testing', date: '', completed: false),
                _TimelineItem(title: 'Received after Testing', date: '', completed: false),
                _TimelineItem(title: 'Modification In Progress', date: '', completed: false),
                _TimelineItem(title: 'Order Completed', date: '', completed: false),
              ],
            ),
            const SizedBox(height: 20),
            // Support CTA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  const Text('Need help with this order?', style: TextStyle(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {},
                      child: const Text('Contact Atelier Support', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.title,
    required this.date,
    required this.completed,
    this.active = false,
  });

  final String title;
  final String date;
  final bool completed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: completed ? Colors.green : (active ? AppColors.primary : AppColors.surfaceContainerHigh),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              Container(width: 2, height: 48, color: AppColors.outlineVariant.withOpacity(0.2))
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: active
                  ? BoxDecoration(
                      color: AppColors.surfaceContainerHigh.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                  if (date.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(date, style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
