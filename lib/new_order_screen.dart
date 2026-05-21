import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'app_theme.dart';
import 'order_measurement_screen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController _notesController = TextEditingController();
  final List<Map<String, String>> _garments_male = [
    {
      'label': 'Sherwani',
      'emoji': '\u{1F935}',
      'description': 'Traditional wedding & ceremonial',
      'tag': 'Popular',
    },
    {'label': 'Kurta', 'emoji': '\u{1F455}', 'description': 'Comfortable everyday wear'},
    {'label': 'Trousers', 'emoji': '\u{1F456}', 'description': 'Tailored fit essentials'},
    {'label': 'Nehru Jacket', 'emoji': '\u{1F9E5}', 'description': 'Smart formal layering', 'tag': 'New'},
    {'label': 'Formal Shirt', 'emoji': '\u{1F454}', 'description': 'Perfect for events'},
  ];

  final List<Map<String, String>> _garments_female = [
    {
      'label': 'Saree',
      'emoji': '\u{1F457}',
      'description': 'Traditional wedding & ceremonial',
      'tag': 'Popular',
    },
    {'label': 'Kurti', 'emoji': '\u{1F455}', 'description': 'Comfortable everyday wear'},
    {'label': 'Coord Set', 'emoji': '\u{1F456}', 'description': 'Tailored fit essentials'},
    {'label': 'Salwar Kamiz', 'emoji': '\u{1F9E5}', 'description': 'Tailored fit', 'tag': 'New'},
    {'label': 'Night Suit', 'emoji': '\u{1F634}', 'description': 'Perfect for sleep'},
  ];

  String _selectedGarment = 'Sherwani';
  bool _isMale = true;
  bool _hasOwnFabric = false;
  String _selectedFabricType = 'Select Fabric Type';

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _showFabricPickerModal(BuildContext context) {
    final List<String> fabricOptions = [
      'Select Fabric Type',
      'Banarasi Silk',
      'Pashmina Wool',
      'Khadi Cotton',
      'Linen',
      'Velvet',
    ];

    int selectedIndex = fabricOptions.indexOf(_selectedFabricType);
    if (selectedIndex < 0) selectedIndex = 0;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                        const Text(
                          'Select Fabric',
                          style: TextStyle(
                            color: AppColors.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedFabricType = fabricOptions[selectedIndex];
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                      onSelectedItemChanged: (int index) {
                        selectedIndex = index;
                      },
                      children: fabricOptions.map((String fabric) {
                        return Center(
                          child: Text(
                            fabric,
                            style: const TextStyle(
                              color: AppColors.onSurface,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
          'New Order',
          style: TextStyle(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: FloatingActionButton.small(
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Close',
          backgroundColor: Colors.transparent,
          heroTag: 'close_btn',
          elevation: 0,
          child: const Icon(Icons.close, color: AppColors.primaryContainer),
        ),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16),
        //     width: 40,
        //     height: 40,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        //       color: AppColors.surfaceContainerHigh,
        //     ),
        //     child: const Center(
        //       child: Icon(
        //         Icons.person,
        //         color: AppColors.primary,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
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
                      color: AppColors.surfaceContainerHigher,
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
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Select ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: 'Garment',
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
              'Step 1: Define the foundation of your bespoke piece.',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMale = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _isMale ? AppColors.primaryContainer : AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.male,
                              color: _isMale ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'MALE',
                              style: TextStyle(
                                color: _isMale ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMale = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: !_isMale ? AppColors.primaryContainer : AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.female,
                              color: !_isMale ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                color: !_isMale ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
              children:  (_isMale ? _garments_male : _garments_female).map((garment) {
                final selected = garment['label'] == _selectedGarment;
                return _GarmentCard(
                  label: garment['label']!,
                  emoji: garment['emoji']!,
                  description: garment['description'],
                  tag: garment['tag'],
                  selected: selected,
                  onTap: () => setState(() => _selectedGarment = garment['label']!),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            const Text(
              'Fabric Source',
              style: TextStyle(
                color: AppColors.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => setState(() => _hasOwnFabric = true),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _hasOwnFabric
                      ? AppColors.surfaceContainerLow.withValues(alpha: 0.9)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: _hasOwnFabric ? Border.all(color: AppColors.primary.withValues(alpha: 0.25), width: 1.5) : Border.all(color: AppColors.surfaceContainerHigher, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.check_circle, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'I have my own fabric',
                            style: TextStyle(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Customer provided material',
                            style: TextStyle(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _hasOwnFabric ? AppColors.primary : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => setState(() => _hasOwnFabric = false),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: !_hasOwnFabric ? AppColors.surfaceContainerLow.withValues(alpha: 0.9) : AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: !_hasOwnFabric ? Border.all(color: AppColors.primary.withValues(alpha: 0.25), width: 1.5) : Border.all(color: AppColors.surfaceContainerHigher, width: 1.5),

                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.warehouse, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Let them choose fabric',
                            style: TextStyle(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Fabric sourced by the studio',
                            style: TextStyle(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: !_hasOwnFabric ? AppColors.primary : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Fabric Details',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showFabricPickerModal(context),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.surfaceContainerHigher),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedFabricType,
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.surfaceContainerHigher),
              ),
              child: TextField(
                controller: _notesController,
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  hintText: 'Additional notes (pattern, color, yardage...)',
                  hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderMeasurementScreen(
                      selectedGarment: _selectedGarment,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'NEXT: MEASUREMENTS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _GarmentCard extends StatelessWidget {
  const _GarmentCard({
    required this.label,
    required this.emoji,
    this.description,
    this.tag,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String emoji;
  final String? description;
  final String? tag;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceContainerHigh : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.15),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tag != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  tag!.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            const Spacer(),
            Text(
              emoji,
              style: const TextStyle(fontSize: 25, inherit: true),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: 6),
              Text(
                description!,
                style: const TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
