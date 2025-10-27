import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnet/routes/app_routes.dart'; // <--- Tambahkan ini

class TargetSettingsPage extends StatefulWidget {
  const TargetSettingsPage({super.key});

  @override
  State<TargetSettingsPage> createState() => _TargetSettingsPageState();
}

class _TargetSettingsPageState extends State<TargetSettingsPage> {
  String? selectedRoute;

  final List<TargetItem> targets = [
    TargetItem(
      icon: Icons.access_time,
      title: 'Downtime',
      subtitle: 'Set daily screen time limits to stay balanced.',
      route: AppRoutes.downtime,
    ),
    TargetItem(
      icon: Icons.apps_outlined,
      title: 'App Limits',
      subtitle: 'Choose apps and set time limits for each one.',
      route: AppRoutes.applimit,
    ),
    TargetItem(
      icon: Icons.nightlight_round,
      title: 'Sleep Schedule',
      subtitle: 'Lock your device during sleep hours for better rest.',
      route: AppRoutes.sleepschedule,
    ),
    TargetItem(
      icon: Icons.no_cell_outlined,
      title: 'Digital Free Time',
      subtitle: 'Take a screen break to recharge and stay balanced.',
      route: AppRoutes.digitalfreetime,
    ),
  ];

  void _onItemTap(String route) {
    setState(() => selectedRoute = route);
    Future.delayed(const Duration(milliseconds: 150), () {
      Get.toNamed(route); // ✅ Navigasi pakai GetX
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Target Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0C1D4A),
                ),
              ),
              const SizedBox(height: 40),

              // List item target
              ...targets.map(
                    (t) => TargetCard(
                  item: t,
                  isSelected: selectedRoute == t.route,
                  onTap: () => _onItemTap(t.route),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.info_outline, color: Color(0xFF7C8BA1), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Set all targets before continuing. These steps are required for your Digital Well-Being profile.',
                      style: TextStyle(
                        color: Color(0xFF7C8BA1),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Tombol Continue
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/assessment');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 4,
                    shadowColor: Colors.tealAccent.withOpacity(0.2),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// Model item
// =====================================================
class TargetItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  TargetItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}

// =====================================================
// Widget kartu interaktif
// =====================================================
class TargetCard extends StatelessWidget {
  final TargetItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const TargetCard({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE3F4F1) : const Color(0xFFF8FAFB),
        border: Border.all(
          color: isSelected ? const Color(0xFF71B8A4) : const Color(0xFFE3E8EE),
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        splashColor: Colors.teal.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF009688)
                      : const Color(0xFFE3E8EE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  color: isSelected ? Colors.white : const Color(0xFF7C8BA1),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0C1D4A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C8BA1),
                        height: 1.4,
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
