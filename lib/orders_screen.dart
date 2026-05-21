import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(color: AppColors.background),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Orders',
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _OrderCard(
                      orderName: 'Royal Sherwani',
                      status: 'Stitching',
                      progress: 0.6,
                      dueDate: 'Oct 24, 2024',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAWJnir_ISGmqTTXkSaZ_FdVzVBiayKT3HxX7Sohl5-7BtcR8SwUWMQgLntQHajvSyH5QQVwM3csmmu6sxFwU6ptJg81VkL_5qzscC96Lhw_UWK1sQ-tvjGMehyRWEcq5dXcus-f5-PwKsPAonVNJ6Rg81_JGypm2ddm0nuKiie2-koSdhCzjJ7waSyYmjjY9yVwtQPPGlnyDQJEQSfVIXoJ7pCVd4hVLVHqsPOb-t8ZJT6aLu0IpGI9eSrQXA5Kx4y0Avo57qcce4',
                    ),
                    const SizedBox(height: 14),
                    _OrderCard(
                      orderName: 'Bespoke Cotton Shirts',
                      status: 'Fabric Selection',
                      progress: 0.2,
                      dueDate: 'Nov 15, 2024',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAH66f_M8-8okXRNpqCCYjlW1ydwWPR7qyv4bshm1cgPTk765S8xfzVRxy2KPAvQHxpHlnyQ7J5MlMrBrRRcjQ60QZ9QcqMCsfStNYNpERPMYgdkMuHYj1j7hVpiPiHGqwLjT9qDdk90nkpXGGCW2raTX2RoE_N0HUsaUOi_6Uv1aN0ABYqOmxrwE2pzyT4IJGUbFeGp9zEYPKwM3SWhqUMrQ53W7aRWsyO5K4Ko9RHGkjlEdiWfp7vocCOx4BfYH9oJ6P3Sa1jTUc',
                    ),
                    const SizedBox(height: 14),
                    _OrderCard(
                      orderName: 'Lehenga Set',
                      status: 'Completed',
                      progress: 1.0,
                      dueDate: 'Sep 30, 2024',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCOAcnQBJOQetYUO2w98p3uZRpRsO3Cix7uDVuxYQg8JdwuOGxfjdag8h1wniKd3KhVb96Wvbo7rbkK7TUKRIJl-4e50lxSbB6930AZW8qXkZlqMPDVPjp9-snQFsREg_rg4Rbg1a_wvvBJOdE_N6HZEfjoBHsqGOEfMHhMM01fnYLO27PT55XdXk4wAPA4WrAWu5V8NaOSQCCCLVhJ99HvQ3QtmBR5Cv62XqBt7etW68hxSlvAWWXA4o_MaDDdpTIKhVDahyDGWGt8',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.orderName,
    required this.status,
    required this.progress,
    required this.dueDate,
    required this.imageUrl,
  });

  final String orderName;
  final String status;
  final double progress;
  final String dueDate;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            orderId: '#GT-8829-2024',
            title: orderName,
            status: status,
            dueDate: dueDate,
            amount: '₹ 42,500',
            leadTailor: 'Master Rajesh Kumar',
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.primary,
                  size: 34,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderName,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Status: $status',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: AppColors.surfaceContainerLow,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 1.0 ? AppColors.primary : AppColors.primaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Due: $dueDate',
                    style: const TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
