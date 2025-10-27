import 'package:flutter/material.dart';

class DigitalFreeTimePage extends StatefulWidget {
  const DigitalFreeTimePage({super.key});

  @override
  State<DigitalFreeTimePage> createState() => _DigitalFreeTimePageState();
}

class _DigitalFreeTimePageState extends State<DigitalFreeTimePage> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Duration? get activeDuration {
    if (startTime == null || endTime == null) return null;
    final start = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    final end = Duration(hours: endTime!.hour, minutes: endTime!.minute);
    // Jika waktu akhir lebih kecil, berarti lewat tengah malam
    return end >= start ? end - start : (const Duration(days: 1) - start) + end;
  }

  Future<void> _selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return '...... : ......';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour : $minute';
  }

  @override
  Widget build(BuildContext context) {
    final duration = activeDuration;
    final hours = duration?.inHours ?? 0;
    final minutes = duration != null ? duration.inMinutes.remainder(60) : 0;

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
                'Digital Free Time',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C1D4A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Take a screen break to recharge and stay balanced.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7C8BA1),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Card utama
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD8E0E8)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Bagian input waktu
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Mulai',
                            style: TextStyle(
                              color: Color(0xFF7C8BA1),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Berakhir',
                            style: TextStyle(
                              color: Color(0xFF7C8BA1),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => _selectTime(true),
                            child: Text(
                              formatTime(startTime),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0C1D4A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'to',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF7C8BA1),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => _selectTime(false),
                            child: Text(
                              formatTime(endTime),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0C1D4A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 0, color: Color(0xFFD8E0E8)),

                    // Kalkulasi total waktu
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Free Time Active :',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0C1D4A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${hours}h ${minutes}m',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0C1D4A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Save
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (startTime == null || endTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Silakan pilih waktu mulai dan berakhir'),
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Free Time diset: ${hours}h ${minutes}m',
                        ),
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
