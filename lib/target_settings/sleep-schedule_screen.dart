import 'package:flutter/material.dart';

class SleepScheduleScreen extends StatefulWidget {
  const SleepScheduleScreen({super.key});

  @override
  State<SleepScheduleScreen> createState() => _SleepScheduleScreenState();
}

class _SleepScheduleScreenState extends State<SleepScheduleScreen> {
  TimeOfDay startTime = const TimeOfDay(hour: 23, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 00);

  // Daftar hari aktif
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  Set<int> selectedDays = {0, 1, 2, 3, 4, 5, 6};

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
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

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}.${time.minute.toString().padLeft(2, '0')}';
  }

  Duration get sleepDuration {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    int diff = endMinutes - startMinutes;
    if (diff < 0) diff += 24 * 60; // Jika melewati tengah malam
    return Duration(minutes: diff);
  }

  @override
  Widget build(BuildContext context) {
    final duration = sleepDuration;
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

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
                'Sleep Schedule',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0C1D4A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lock your device during sleep hours for better rest.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7C8BA1),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              // Kartu utama
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD8E1E8)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeColumn(
                          label: 'Mulai',
                          time: _formatTime(startTime),
                          onTap: () => _selectTime(true),
                        ),
                        _buildTimeColumn(
                          label: 'Berakhir',
                          time: _formatTime(endTime),
                          onTap: () => _selectTime(false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Durasi tidur
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bed_rounded,
                            color: Color(0xFF0C1D4A), size: 22),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Divider(
                            color: Color(0xFF0C1D4A),
                            thickness: 1,
                            indent: 8,
                            endIndent: 8,
                          ),
                        ),
                        Text(
                          '${hours}h ${minutes}m',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF7C8BA1),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Divider(
                            color: Color(0xFF0C1D4A),
                            thickness: 1,
                            indent: 8,
                            endIndent: 8,
                          ),
                        ),
                        const Icon(Icons.wb_sunny_rounded,
                            color: Color(0xFF0C1D4A), size: 22),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Hari-hari
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(days.length, (index) {
                        final isSelected = selectedDays.contains(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedDays.remove(index);
                              } else {
                                selectedDays.add(index);
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: isSelected
                                ? const Color(0xFFB5E2DA)
                                : const Color(0xFFE7EFF3),
                            child: Text(
                              days[index],
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF0C1D4A)
                                    : const Color(0xFF7C8BA1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Tombol simpan
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Simpan data
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7C8BA1),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            time,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0C1D4A),
            ),
          ),
        ],
      ),
    );
  }
}
