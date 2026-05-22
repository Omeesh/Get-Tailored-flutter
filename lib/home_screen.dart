import 'dart:async';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'menu_drawer.dart';
import 'new_order_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userName});

  final String? userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  late PageController _adsPageController;
  late Timer _adsAutoScrollTimer;

  @override
  void initState() {
    super.initState();
    _adsPageController = PageController(initialPage: 0);
    _startAdsAutoScroll();
  }

  void _startAdsAutoScroll() {
    _adsAutoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_adsPageController.hasClients) {
        final nextPage = (_adsPageController.page!.toInt() + 1) % 5;
        _adsPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onMenuItemTap(String item) {
    Navigator.pop(context);
    if (item == 'home') {
      setState(() => _currentTab = 0);
    } else if (item == 'orders') {
      setState(() => _currentTab = 1);
    } else if (item == 'profile') {
      setState(() => _currentTab = 2);
    } else if (item == 'logout') {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully.')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      );
    } else {
      final label = item[0].toUpperCase() + item.substring(1);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$label is coming soon!')));
    }
  }

  void _onBottomNavTap(int index) {
    setState(() => _currentTab = index);
  }

  @override
  void dispose() {
    _adsAutoScrollTimer.cancel();
    _adsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: MenuDrawer(
        userName: widget.userName,
        onMenuItemTap: _onMenuItemTap,
      ),
      body: Stack(
        children: [
          _buildCurrentScreen(),
          // const Positioned(
          //   bottom: 10,
          //   right: 18,
          //   child: _ContextFab(),
          // ),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        currentTab: _currentTab,
        onTabChanged: _onBottomNavTap,
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentTab) {
      case 1:
        return const OrdersScreen();
      case 2:
        return ProfileScreen(userName: widget.userName);
      case 0:
      default:
        return _HomeContentScreen(
          userName: widget.userName,
          adsPageController: _adsPageController,
        );
    }
  }
}

class _HomeContentScreen extends StatelessWidget {
  const _HomeContentScreen({
    required this.userName,
    required this.adsPageController,
  });

  final String? userName;
  final PageController adsPageController;

  String get _greeting {
    return userName != null ? 'Namaste, $userName' : 'Namaste';
  }

  String get _subtitle {
    return userName != null
        ? 'Welcome back to your digital atelier.'
        : 'Discover your custom style journey.';
  }

  String get _avatarText {
    if (userName == null || userName!.isEmpty) {
      return '';
    }
    final parts = userName!
        .split(' ')
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts.first.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _HomeBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10), // Extra space for FAB
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _HomeAppBar(avatarText: _avatarText),
                  const SizedBox(height: 18),
                  _SearchSection(greeting: _greeting, subtitle: _subtitle),
                  const SizedBox(height: 20),
                  const _HeroBanner(),
                  const SizedBox(height: 20),
                  const _ActiveOrdersBanner(),
                  const SizedBox(height: 20),
                  const _CategoriesSection(),
                  const SizedBox(height: 20),
                  _AdsCarousel(pageController: adsPageController),
                  const SizedBox(height: 20),
                  const _TrendingGrid(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        const Positioned(bottom: 10, right: 18, child: _ContextFab()),
      ],
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({required this.avatarText});

  final String avatarText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FloatingActionButton.small(
                heroTag: 'menu_open',
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Open Menu',
                backgroundColor: Colors.transparent,
                child: const Icon(
                  Icons.menu,
                  size: 25,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'GetTailored',
                style: TextStyle(
                  color: AppColors.primaryContainer,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          if (avatarText.isNotEmpty)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0x33F5BC6D)),
              ),
              child: Center(
                child: Text(
                  avatarText,
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection({required this.greeting, required this.subtitle});

  final String greeting;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: const TextStyle(
              color: AppColors.onSurface,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          Stack(
            children: [
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              TextField(
                style: const TextStyle(color: AppColors.onSurface),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  hintText: 'Search your bespoke style...',
                  hintStyle: const TextStyle(color: AppColors.outlineVariant),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceContainerHigh,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1C1B1B), Color(0xFF2E2D2D)],
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.12,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 120,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBnkz8fd03KbUUfvo4U8KwULvAs4gzIyAw3a0b0JthL1knxT0eRXDJDKBAUankdeT4yVE-sL4nguxTg5Zt9bswN2_QM5-SKXVJ6KODPj6qRKdIOhAZC-knziVKQZKE7BpEJfwzFssYsAlG44qEUjl4YiL3xOCNFYBRvlfie6SNLD8fyvSXTieJwKbNZfikQnWjRZESs0HMyyCSK9Ec3-5Eb0uEGsKg9NUWmiK4CvbdqJy6pF7wNjiXQxI7zvMH6Ww8Qhr7L9ECYUNw",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xE6131313), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x2EF5BC6D),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Limited Edition',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Wedding Season Collections 2025',
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const NewOrderScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: const Text('Order Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveOrdersBanner extends StatelessWidget {
  const _ActiveOrdersBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x1AC9954A),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0x33C9954A)),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.inventory_2,
                    color: AppColors.onPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Royal Sherwani in Works',
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ready by Oct 24 • Stitching',
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tracking feature will be available soon.'),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              child: const Text(
                'Track',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explore Categories',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category browsing is coming soon.'),
                    ),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _CategoryCard(
                label: 'Sherwani',
                emoji: '🤵',
                badge: 'Popular',
                subtext: '12 Styles',
              ),
              SizedBox(width: 14),
              _CategoryCard(
                label: 'Kurta Pyjama',
                emoji: '👘',
                subtext: '48 Styles',
              ),
              SizedBox(width: 14),
              _CategoryCard(
                label: 'Lehenga',
                emoji: '💃',
                subtext: '32 Styles',
              ),
              SizedBox(width: 14),
              _CategoryCard(
                label: 'Bandhgala',
                emoji: '🧥',
                subtext: '08 Styles',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.label,
    required this.emoji,
    required this.subtext,
    this.badge,
  });

  final String label;
  final String emoji;
  final String subtext;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: badge != null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Popular',
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Text(
            emoji,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 40, inherit: true),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtext,
                style: const TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdsCarousel extends StatefulWidget {
  const _AdsCarousel({required this.pageController});

  final PageController pageController;

  @override
  State<_AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<_AdsCarousel> {
  late int _currentPage;

  final List<Map<String, String>> _ads = [
    {
      'title': 'Royal Fabric Emporium',
      'subtitle': 'Flat 20% off on premium Italian Silk',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBnkz8fd03KbUUfvo4U8KwULvAs4gzIyAw3a0b0JthL1knxT0eRXDJDKBAUankdeT4yVE-sL4nguxTg5Zt9bswN2_QM5-SKXVJ6KODPj6qRKdIOhAZC-knziVKQZKE7BpEJfwzFssYsAlG44qEUjl4YiL3xOCNFYBRvlfie6SNLD8fyvSXTieJwKbNZfikQnWjRZESs0HMyyCSK9Ec3-5Eb0uEGsKg9NUWmiK4CvbdqJy6pF7wNjiXQxI7zvMH6Ww8Qhr7L9ECYUNw',
    },
    {
      'title': 'Silk Paradise',
      'subtitle': 'Exclusive imported fabrics just arrived',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAWJnir_ISGmqTTXkSaZ_FdVzVBiayKT3HxX7Sohl5-7BtcR8SwUWMQgLntQHajvSyH5QQVwM3csmmu6sxFwU6ptJg81VkL_5qzscC96Lhw_UWK1sQ-tvjGMehyRWEcq5dXcus-f5-PwKsPAonVNJ6Rg81_JGypm2ddm0nuKiie2-koSdhCzjJ7waSyYmjjY9yVwtQPPGlnyDQJEQSfVIXoJ7pCVd4hVLVHqsPOb-t8ZJT6aLu0IpGI9eSrQXA5Kx4y0Avo57qcce4',
    },
    {
      'title': 'Designer Connect',
      'subtitle': 'Get 15% off on your first custom order',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCOAcnQBJOQetYUO2w98p3uZRpRsO3Cix7uDVuxYQg8JdwuOGxfjdag8h1wniKd3KhVb96Wvbo7rbkK7TUKRIJl-4e50lxSbB6930AZW8qXkZlqMPDVPjp9-snQFsREg_rg4Rbg1a_wvvBJOdE_N6HZEfjoBHsqGOEfMHhMM01fnYLO27PT55XdXk4wAPA4WrAWu5V8NaOSQCCCLVhJ99HvQ3QtmBR5Cv62XqBt7etW68hxSlvAWWXA4o_MaDDdpTIKhVDahyDGWGt8',
    },
    {
      'title': 'Premium Threads',
      'subtitle': 'Indian cotton & silk on massive sale',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAH66f_M8-8okXRNpqCCYjlW1ydwWPR7qyv4bshm1cgPTk765S8xfzVRxy2KPAvQHxpHlnyQ7J5MlMrBrRRcjQ60QZ9QcqMCsfStNYNpERPMYgdkMuHYj1j7hVpiPiHGqwLjT9qDdk90nkpXGGCW2raTX2RoE_N0HUsaUOi_6Uv1aN0ABYqOmxrwE2pzyT4IJGUbFeGp9zEYPKwM3SWhqUMrQ53W7aRWsyO5K4Ko9RHGkjlEdiWfp7vocCOx4BfYH9oJ6P3Sa1jTUc',
    },
    {
      'title': 'Artisan Collection',
      'subtitle': 'Handpicked finest fabrics for you',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD7WoZ8sbqttdeZBaJ6_C-eaR5FtgP49YenE2HrJVeItzGGM_A7im2WYl9v0TLVr8cb-42i4Tjr5IKKsGQ-GDSeVCC9k2C65mB8z0_Ayug0aWzNu7C1Vb0gOfUL9xWlgzUqUPCKKAAkblIbTLPz8BkvAUaEa68mQwl7IvkyHelmL6cZ9tbrXreChuaHJk-kZJSvjkP-wZLC5u-QhofNNml8pXtOr9PIC8Vw5FKiXkJy1Kgs80N3X_qd5yKccnFBAsBa7GRDm5G5jhc',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    widget.pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = widget.pageController.page?.toInt() ?? 0;
    });
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: widget.pageController,
              itemCount: _ads.length,
              itemBuilder: (context, index) {
                final ad = _ads[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: const Color(0x33504538)),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              image: DecorationImage(
                                // image: NetworkImage(ad['imageUrl'] ?? ""),
                                image: NetworkImage(ad['imageUrl'] ?? ""),
                                fit: BoxFit.cover,
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.surfaceContainerLowest,
                                  Color(0x66131313),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xEB131313), Colors.transparent],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceContainerHigh,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.storefront,
                                        color: AppColors.primary,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ad['title'] ?? "No Title",
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          ad['subtitle']!,
                                          style: const TextStyle(
                                            color: AppColors.onSurface,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.open_in_new,
                                  color: AppColors.outlineVariant,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _ads.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingGrid extends StatelessWidget {
  const _TrendingGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending This Week',
            style: TextStyle(
              color: AppColors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.9,
            children: const [
              _TrendingCard(
                title: 'Midnight Velvet Blazer',
                subtitle: 'New Arrival',
                price: '₹12,499',
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAWJnir_ISGmqTTXkSaZ_FdVzVBiayKT3HxX7Sohl5-7BtcR8SwUWMQgLntQHajvSyH5QQVwM3csmmu6sxFwU6ptJg81VkL_5qzscC96Lhw_UWK1sQ-tvjGMehyRWEcq5dXcus-f5-PwKsPAonVNJ6Rg81_JGypm2ddm0nuKiie2-koSdhCzjJ7waSyYmjjY9yVwtQPPGlnyDQJEQSfVIXoJ7pCVd4hVLVHqsPOb-t8ZJT6aLu0IpGI9eSrQXA5Kx4y0Avo57qcce4',
              ),
              _TrendingCard(
                title: 'Accessories',
                subtitle: 'Essentials',
                price: '',
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCOAcnQBJOQetYUO2w98p3uZRpRsO3Cix7uDVuxYQg8JdwuOGxfjdag8h1wniKd3KhVb96Wvbo7rbkK7TUKRIJl-4e50lxSbB6930AZW8qXkZlqMPDVPjp9-snQFsREg_rg4Rbg1a_wvvBJOd8N6HZEfjoBHsqGOEfMHhMM01fnYLO27PT55XdXk4wAPA4WrAWu5V8NaOSQCCCLVhJ99HvQ3QtmBR5Cv62XqBt7etW68hxSlvAWWXA4o_MaDDdpTIKhVDahyDGWGt8',
              ),
              _TrendingCard(
                title: 'Bespoke Shirts',
                subtitle: 'Tailored Fit',
                price: '',
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAH66f_M8-8okXRNpqCCYjlW1ydwWPR7qyv4bshm1cgPTk765S8xfzVRxy2KPAvQHxpHlnyQ7J5MlMrBrRRcjQ60QZ9QcqMCsfStNYNpERPMYgdkMuHYj1j7hVpiPiHGqwLjT9qDdk90nkpXGGCW2raTX2RoE_N0HUsaUOi_6Uv1aN0ABYqOmxrwE2pzyT4IJGUbFeGp9zEYPKwM3SWhqUMrQ53W7aRWsyO5K4Ko9RHGkjlEdiWfp7vocCOx4BfYH9oJ6P3Sa1jTUc',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.surfaceContainerHigh),
          ),
          Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xEB131313), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (price.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xE6F5BC6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentTab, required this.onTabChanged});

  final int currentTab;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab,
      elevation: 0,
      onTap: (index) {
        // setState(() {
        //   currentTab = index;
        // });
        onTabChanged(index);
      },
      iconSize: 25,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: AppColors.primary,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_bag),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _ContextFab extends StatelessWidget {
  const _ContextFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const NewOrderScreen()));
      },
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }
}
