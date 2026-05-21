import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'order_finalization_screen.dart';

class OrderMeasurementScreen extends StatefulWidget {
  final String selectedGarment;

  const OrderMeasurementScreen({
    super.key,
    required this.selectedGarment,
  });

  @override
  State<OrderMeasurementScreen> createState() => _OrderMeasurementScreenState();
}

class _OrderMeasurementScreenState extends State<OrderMeasurementScreen> {
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _shoulderController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _sleeveController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _armHoleController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();
  final TextEditingController _inseamController = TextEditingController();
  final TextEditingController _bottomOpeningController = TextEditingController();

  @override
  void dispose() {
    _chestController.dispose();
    _shoulderController.dispose();
    _lengthController.dispose();
    _sleeveController.dispose();
    _neckController.dispose();
    _armHoleController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    _inseamController.dispose();
    _bottomOpeningController.dispose();
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
          'Measurements',
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
          heroTag: 'back_btn_measurements',
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
                      color: AppColors.surfaceContainerHigher,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
                // Expanded(
                //   child: Container(
                //     height: 4,
                //     decoration: BoxDecoration(
                //       color: AppColors.surfaceContainerHigher,
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
                    text: 'Step ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: '2',
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
              'Enter precise measurements for the perfect fit. All values in inches.',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            // Info Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Precision Guide',
                          style: TextStyle(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'All measurements must be entered in ',
                                style: TextStyle(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'inches',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Body Foundation Section
            _buildSectionHeader('Body Foundation', Icons.accessibility_new),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Chest (in)',
                    controller: _chestController,
                    hint: '0.0',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Shoulder (in)',
                    controller: _shoulderController,
                    hint: '0.0',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Kurta Dimensions Section
            _buildSectionHeader('Kurta Dimensions', Icons.checkroom),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMeasurementInput(
                          label: 'Length (in)',
                          controller: _lengthController,
                          hint: '0.0',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMeasurementInput(
                          label: 'Sleeve (in)',
                          controller: _sleeveController,
                          hint: '0.0',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMeasurementInput(
                          label: 'Neck/Collar (in)',
                          controller: _neckController,
                          hint: '0.0',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMeasurementInput(
                          label: 'Arm Hole (in)',
                          controller: _armHoleController,
                          hint: '0.0',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Pyjama Specs Section
            _buildSectionHeader('Pyjama Specs', Icons.subject),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Waist (in)',
                    controller: _waistController,
                    hint: '0.0',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Hip (in)',
                    controller: _hipController,
                    hint: '0.0',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Inseam (in)',
                    controller: _inseamController,
                    hint: '0.0',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementInput(
                    label: 'Bottom Opening (in)',
                    controller: _bottomOpeningController,
                    hint: '0.0',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(
                        color: AppColors.surfaceContainerHigher,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      _showSnackBar('Draft saved for ${widget.selectedGarment}.');
                    },
                    child: const Text(
                      'SAVE DRAFT',
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderFinalizationScreen(
                            selectedGarment: widget.selectedGarment,
                            selectedFabric: 'Select Fabric Type',
                          ),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'REVIEW ORDER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementInput({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceContainerHigher),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: AppColors.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
