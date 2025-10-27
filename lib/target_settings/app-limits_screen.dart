import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:typed_data';


class AppLimitsScreen extends StatefulWidget {
  const AppLimitsScreen({super.key});

  @override
  State<AppLimitsScreen> createState() => _AppLimitsScreenState();
}

class _AppLimitsScreenState extends State<AppLimitsScreen> {
  final Map<String, List<AppItem>> appCategories = {
    'Social': [],
    'Entertainment': [],
    'Education': [],
    'Others': [],
  };

  String? expandedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scanInstalledApps();
  }

  /// 🔍 Ambil daftar aplikasi terinstal dari perangkat
  Future<void> _scanInstalledApps() async {
    try {
      List<Application> apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
      );

      for (var app in apps) {
        final category = _categorizeApp(app.appName);
        final icon = app is ApplicationWithIcon ? app.icon : null;

        appCategories[category]!.add(
          AppItem(
            name: app.appName,
            iconBytes: icon,
            limitMinutes: null,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading apps: $e');
    }

    setState(() => isLoading = false);
  }

  /// 🧠 Klasifikasi otomatis berdasarkan nama aplikasi
  String _categorizeApp(String name) {
    name = name.toLowerCase();

    if (name.contains('instagram') ||
        name.contains('facebook') ||
        name.contains('tiktok') ||
        name.contains('whatsapp') ||
        name.contains('telegram') ||
        name.contains('x ') ||
        name.contains('twitter') ||
        name.contains('snapchat')) {
      return 'Social';
    } else if (name.contains('youtube') ||
        name.contains('spotify') ||
        name.contains('netflix') ||
        name.contains('vidio') ||
        name.contains('disney') ||
        name.contains('viu')) {
      return 'Entertainment';
    } else if (name.contains('duolingo') ||
        name.contains('khan') ||
        name.contains('academy') ||
        name.contains('edmodo') ||
        name.contains('quizlet') ||
        name.contains('classroom')) {
      return 'Education';
    } else {
      return 'Others';
    }
  }

  /// ⏱️ Dialog pengaturan waktu limit per aplikasi
  Future<void> _showLimitDialog(AppItem app) async {
    TextEditingController controller = TextEditingController(
      text: app.limitMinutes?.toString() ?? '',
    );

    final result = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Set limit for ${app.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Daily limit (minutes)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final limit = int.tryParse(controller.text);
              Get.back(result: limit);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => app.limitMinutes = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'App Limits',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0C1D4A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose apps and set time limits for each one.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7C8BA1),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              /// Konten utama
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xFFD8E1E8)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: appCategories.keys.map((category) {
                        final apps = appCategories[category]!;
                        if (apps.isEmpty) return const SizedBox();
                        final isExpanded =
                            expandedCategory == category;

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expandedCategory =
                                  isExpanded ? null : category;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE0E7ED),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0C1D4A),
                                      ),
                                    ),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: const Color(0xFF0C1D4A),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded)
                              ...apps.map((app) => _buildAppItem(app)),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Tombol Save
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO:
                    // Simpan data limit ke backend / lokal storage
                    // Bisa disambungkan dengan fitur pemantauan waktu penggunaan
                    Get.snackbar(
                      'Saved',
                      'App limits updated successfully!',
                      backgroundColor: Colors.green.shade600,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    'SAVE TARGET',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Widget item aplikasi
  Widget _buildAppItem(AppItem app) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE7EFF3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (app.iconBytes != null)
                Image.memory(app.iconBytes!, width: 28, height: 28)
              else
                const Icon(Icons.apps, color: Color(0xFF7C8BA1), size: 28),
              const SizedBox(width: 12),
              Text(
                app.name,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF0C1D4A),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _showLimitDialog(app),
            child: Row(
              children: [
                Icon(Icons.refresh,
                    color: const Color(0xFF7C8BA1).withOpacity(0.8), size: 22),
                const SizedBox(width: 4),
                const Icon(Icons.settings,
                    color: Color(0xFF7C8BA1), size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 📦 Model data aplikasi
class AppItem {
  final String name;
  final Uint8List? iconBytes;
  int? limitMinutes;

  AppItem({required this.name, this.iconBytes, this.limitMinutes});
}
