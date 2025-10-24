import 'package:flutter/material.dart';
import 'package:wellnet/pages/setSleepSchedule_page.dart';

class SleepSchedulePage extends StatefulWidget {
  const SleepSchedulePage({super.key});

  @override
  State<SleepSchedulePage> createState() => _SleepSchedulePageState();
}

class _SleepSchedulePageState extends State<SleepSchedulePage> {
  // nilai awal default
  TimeOfDay startTime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 0);

  Duration get duration {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    if (endMinutes < startMinutes) endMinutes += 24 * 60;
    return Duration(minutes: endMinutes - startMinutes);
  }

  String get durationText =>
      "${duration.inHours}h ${(duration.inMinutes % 60).toString().padLeft(2, '0')}m";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF2AB3B5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Graphic"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3DB2A2), Color(0xFF73D6B6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sleep Schedule",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lock your device during sleep hours for better rest.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // ISI
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // CARD
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF7F4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.nightlight_round, color: Color(0xFF2AB3B5)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Sleep Schedule",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                durationText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF2AB3B5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${startTime.format(context)} - ${endTime.format(context)} WIB",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Time until sleep: 1h 0m",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.grey[300],
                              color: const Color(0xFF2AB3B5),
                              minHeight: 10,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, color: Colors.grey),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Tersisa 1 jam sebelum waktu tidur! Yuk manfaatkan waktumu dengan sebaik-baiknya.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Tombol Atur Ulang Target
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // ⏩ buka halaman setSleepSchedule, tunggu hasilnya
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SetsleepschedulePage(),
                            ),
                          );

                          // kalau ada hasil, update tampilan
                          if (result != null && result is Map<String, TimeOfDay>) {
                            setState(() {
                              startTime = result['start']!;
                              endTime = result['end']!;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2AB3B5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "ATUR ULANG TARGET",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
