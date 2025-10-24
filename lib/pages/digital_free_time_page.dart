import 'package:flutter/material.dart';
import 'package:wellnet/pages/home_page.dart';
import 'package:wellnet/pages/setDigitalFreeTime_page.dart';

class DigitalFreeTimePage extends StatefulWidget {
  const DigitalFreeTimePage({super.key});

  @override
  State<DigitalFreeTimePage> createState() => _DigitalFreeTimePageState();
}

class _DigitalFreeTimePageState extends State<DigitalFreeTimePage> {
  // waktu default
  TimeOfDay startTime = const TimeOfDay(hour: 14, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 0);

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
        // selectedItemColor: const Color(0xFF1EAE98),
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // posisi halaman AppLimitsPage (Graphic)
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // tetap di halaman ini (AppLimitsPage)
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Graphic",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
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
                    "Digital Free Time",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Take a screen break to recharge and stay balanced.",
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
                          // title bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.dark_mode,
                                    color: Color(0xFF2AB3B5),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Digital Free Time",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Free Time Active : $durationText",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF2AB3B5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // jam mulai dan akhir
                          Text(
                            "${startTime.format(context)} - ${endTime.format(context)} WIB",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.7,
                              backgroundColor: Colors.grey[300],
                              color: const Color(0xFF2AB3B5),
                              minHeight: 10,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // teks info
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.hourglass_empty, color: Colors.grey),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Tersisa 1 jam sebelum free time berakhir! Yuk manfaatkan waktumu dengan sebaik-baiknya.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // tombol ATUR ULANG TARGET
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const SetDigitalFreeTimePage(),
                            ),
                          );

                          // ambil hasil dari halaman atur ulang
                          if (result != null &&
                              result is Map<String, TimeOfDay>) {
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
