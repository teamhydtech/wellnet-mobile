import 'package:flutter/material.dart';

class TargetSettingsPage extends StatelessWidget {
  const TargetSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TargetItem> targets = [
      TargetItem(
        icon: Icons.access_time,
        title: 'Downtime',
        subtitle: 'Set daily screen time limits to stay balanced.',
        route: '/downtime',
        isSelected: true,
      ),
      TargetItem(
        icon: Icons.apps_outlined,
        title: 'App Limits',
        subtitle: 'Choose apps and set time limits for each one.',
        route: '/app-limits',
      ),
      TargetItem(
        icon: Icons.nightlight_round,
        title: 'Sleep Schedule',
        subtitle: 'Lock your device during sleep hours for better rest.',
        route: '/sleep-schedule',
      ),
      TargetItem(
        icon: Icons.no_cell_outlined,
        title: 'Digital Free Time',
        subtitle: 'Take a screen break to recharge and stay balanced.',
        route: '/digital-free-time',
      ),
    ];

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
              // List item dengan navigasi
              ...targets.map((t) => TargetCard(
                item: t,
                onTap: () {
                  Navigator.pushNamed(context, t.route);
                },
              )),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      color: Color(0xFF7C8BA1), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Set all targets before continuing. These steps are required for your Digital Well-Being profile.',
                      style: TextStyle(
                        color: const Color(0xFF7C8BA1),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/assessment');
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

// Model item
class TargetItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final bool isSelected;

  TargetItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    this.isSelected = false,
  });
}

// Widget card
class TargetCard extends StatelessWidget {
  final TargetItem item;
  final VoidCallback onTap;

  const TargetCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
          item.isSelected ? const Color(0xFFE3F4F1) : const Color(0xFFF8FAFB),
          border: Border.all(
            color: item.isSelected
                ? const Color(0xFF71B8A4)
                : const Color(0xFFE3E8EE),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: item.isSelected
                    ? const Color(0xFF009688)
                    : const Color(0xFFE3E8EE),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon,
                  color:
                  item.isSelected ? Colors.white : const Color(0xFF7C8BA1),
                  size: 22),
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
    );
  }
}
