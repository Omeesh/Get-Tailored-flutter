import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'login_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.userName});

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(color: AppColors.background),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Builder(
                builder: (context) {
                  void showMessage(String label) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$label is coming soon.')),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            userName?.isNotEmpty == true
                                ? '${userName!.split(' ')[0][0]}${userName!.split(' ').length > 1 ? userName!.split(' ')[1][0] : ''}'
                                : 'U',
                            style: const TextStyle(
                              color: AppColors.onPrimary,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userName ?? 'Guest User',
                        style: const TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'arjun@gettailored.com',
                        style: TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _ProfileOption(
                        icon: Icons.person,
                        label: 'Edit Profile',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                      ),
                      _ProfileOption(
                        icon: Icons.location_on,
                        label: 'Addresses',
                        onTap: () => showMessage('Addresses'),
                      ),
                      _ProfileOption(
                        icon: Icons.payment,
                        label: 'Payment Methods',
                        onTap: () => showMessage('Payment Methods'),
                      ),
                      _ProfileOption(
                        icon: Icons.favorite,
                        label: 'Wishlist',
                        onTap: () => showMessage('Wishlist'),
                      ),
                      _ProfileOption(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () => showMessage('Settings'),
                      ),
                      _ProfileOption(
                        icon: Icons.help,
                        label: 'Help & Support',
                        onTap: () => showMessage('Help & Support'),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'You have been logged out.',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x33FF0000),
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primaryContainer, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.outlineVariant,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
