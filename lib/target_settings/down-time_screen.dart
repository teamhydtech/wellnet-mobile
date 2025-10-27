import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/downtime_controller.dart';

class DowntimePage extends StatefulWidget {
  const DowntimePage({super.key});

  @override
  State<DowntimePage> createState() => _DowntimePageState();
}

class _DowntimePageState extends State<DowntimePage> {
  late DowntimeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DowntimeController>();
  }

  void _showDurationPicker() async {
    int tempHours = controller.selectedHours.value;
    int tempMinutes = controller.selectedMinutes.value;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Durasi Harian',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0C1D4A),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Picker jam
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(
                              initialItem: tempHours),
                          onSelectedItemChanged: (value) {
                            setModalState(() => tempHours = value);
                          },
                          children:
                          List.generate(13, (i) => Text("$i Jam")).toList(),
                        ),
                      ),
                      // Picker menit (5 menit interval)
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController:
                          FixedExtentScrollController(initialItem: tempMinutes ~/ 5),
                          onSelectedItemChanged: (value) {
                            setModalState(() => tempMinutes = value * 5);
                          },
                          children:
                          List.generate(12, (i) => Text("${i * 5} Menit")),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Tombol Simpan
                ElevatedButton(
                  onPressed: () {
                    controller.setTarget(tempHours, tempMinutes);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    child: Text(
                      'SIMPAN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Downtime',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C1D4A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Set daily screen time limits to stay balanced.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7C8BA1),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Box utama
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFD8E0E8)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Pilihan durasi
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD8E0E8)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                            "${controller.selectedHours.value}h ${controller.selectedMinutes.value}m",
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Color(0xFF0C1D4A),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                          InkWell(
                            onTap: _showDurationPicker,
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.access_time,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Daily Target
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Daily Target:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0C1D4A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => Text(
                        '${controller.selectedHours.value}h ${controller.selectedMinutes.value}m',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0C1D4A),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Save Target
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Obx(() => Text(
                          'Target harian diset: ${controller.selectedHours.value}h ${controller.selectedMinutes.value}m',
                        )),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 4,
                    shadowColor: Colors.tealAccent.withOpacity(0.25),
                  ),
                  child: const Text(
                    'SAVE TARGET',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Colors.white,
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
}
