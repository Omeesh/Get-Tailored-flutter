import 'package:flutter/material.dart';
import 'app_theme.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
    this.userName,
    required this.onMenuItemTap,
  });

  final String? userName;
  final Function(String) onMenuItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      userName?.isNotEmpty == true
                          ? '${userName!.split(' ')[0][0]}${userName!.split(' ').length > 1 ? userName!.split(' ')[1][0] : ''}'
                          : 'U',
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userName ?? 'Guest User',
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'arjun@gettailored.com',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _DrawerMenuItem(
                  icon: Icons.home,
                  label: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('home');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.shopping_bag,
                  label: 'My Orders',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('orders');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('profile');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.favorite,
                  label: 'Wishlist',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('wishlist');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('notifications');
                  },
                ),
                const Divider(color: Color(0x33504538), height: 20),
                _DrawerMenuItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('settings');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.help,
                  label: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('help');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    onMenuItemTap('logout');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x33504538)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, size: 16, color: AppColors.onSurfaceVariant),
                  SizedBox(width: 8),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppColors.primaryContainer,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppColors.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
