import 'package:flutter/material.dart';
import 'app_theme.dart';

class OrderFinalizationScreen extends StatefulWidget {
  final String selectedGarment;
  final String selectedFabric;

  const OrderFinalizationScreen({
    super.key,
    required this.selectedGarment,
    required this.selectedFabric,
  });

  @override
  State<OrderFinalizationScreen> createState() => _OrderFinalizationScreenState();
}

class _OrderFinalizationScreenState extends State<OrderFinalizationScreen> {
  final TextEditingController _instructionsController = TextEditingController();
  final List<String?> _uploadedImages = [null, null, null]; // 3 slots

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Finalize Order',
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
          heroTag: 'back_btn_finalization',
          elevation: 0,
          child: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Progress indicator
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
                // Expanded(
                //   child: Container(
                //     height: 4,
                //     decoration: BoxDecoration(
                //       color: AppColors.primary,
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 28),
            // Title
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Finalize Your ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: 'Masterpiece',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add final details and reference photos for the artisan.',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            // Special Instructions Section
            const Text(
              'Special Instructions',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.surfaceContainerHigher),
              ),
              child: TextField(
                controller: _instructionsController,
                maxLines: 6,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  hintText: 'Add specific styling notes or fit requirements... (Hindi/English/Regional)',
                  hintStyle: const TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 14,
                  ),
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.mic,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          _showSnackBar('Voice recording not yet implemented');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Design References Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Design References',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                ),
                Text(
                  '${_uploadedImages.where((img) => img != null).length} / 3 SLOTS',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildImageSlot(index);
              },
            ),
            const SizedBox(height: 32),
            // Order Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.receipt_long,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSummaryRow('Category', widget.selectedGarment),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Fabric Choice', widget.selectedFabric),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Measurements', '14 Points Captured', showCheckmark: true),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Estimated Turnaround', '12-14 Days'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Get Quote Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  _showSnackBar(
                    'Order placed for ${widget.selectedGarment}! Check your email for the quote.',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'GET QUOTE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'By clicking, you agree to our artisan engagement terms',
                style: TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlot(int index) {
    final hasImage = _uploadedImages[index] != null;

    if (hasImage) {
      return GestureDetector(
        onLongPress: () {
          setState(() {
            _uploadedImages[index] = null;
          });
          _showSnackBar('Image removed');
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceContainerHigher),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        _showSnackBar('Image upload not yet implemented');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.onSurfaceVariant,
              size: 28,
            ),
            const SizedBox(height: 6),
            const Text(
              'UPLOAD',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool showCheckmark = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (showCheckmark)
              const Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 18,
              ),
          ],
        ),
      ],
    );
  }
}
