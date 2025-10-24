import 'package:flutter/material.dart';
import 'package:wellnet/pages/app_limits_page.dart';
import 'package:wellnet/pages/digital_free_time_page.dart';
import 'package:wellnet/pages/downtime_page.dart';
import 'package:wellnet/pages/psychoeducation_page.dart';
import 'package:wellnet/pages/quiz_challenge_page.dart';
import 'package:wellnet/pages/sleepSchedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "Windy";
  String level = "Sprout";
  int score = 20;

  int currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const GraphicPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(child: _pages[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF3DB2A2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Graphic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = "Windy";
    String level = "Sprout";
    int score = 20;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3DB2A2), Color(0xFF73D6B6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, $userName!",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Welcome to Wellnet.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: Icon(Icons.person, color: Color(0xFF3DB2A2)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Sprout card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7F4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Icon(Icons.spa, color: Color(0xFF3DB2A2)),
                ),
                const SizedBox(height: 10),
                Text(
                  level,
                  style: const TextStyle(
                    color: Color(0xFF3DB2A2),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Jumlah Skor : $score",
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 12),
                const Text(
                  "““Kamu mulai tumbuh! Sekarang kamu sudah menyadari bahwa ada hal-hal yang mempengaruhi perasaan dan pikiranmu saat menggunakan internet. Meski kadang masih sulit mengontrolnya, kamu sedang belajar — dan itu luar biasa! Teruslah eksplorasi bagaimana membatasi penggunaan gadget, dan kenali kebiasaan yang bikin kamu lebih nyaman dan tenang secara digital.””",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 0,
            children: [
              FeatureButton(
                icon: Icons.hourglass_empty,
                label: 'Downtime',
                color: Color(0xFF6699CC),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DowntimePage()),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.apps,
                label: 'App Limits',
                color: Color(0xFFE57373),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppLimitsPage(),
                    ),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.nights_stay,
                label: 'Sleep Schedule',
                color: Color(0xFF5C6BC0),
                 onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SleepSchedulePage(),
                    ),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.calendar_today,
                label: 'Scheduling Digital\nFree Time',
                color: Color(0xFF81C784),
                 onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DigitalFreeTimePage(),
                    ),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.quiz,
                label: 'Weekly Quiz\nChallenge',
                color: Color(0xFFFBC02D),
                 onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizChallengePage(),
                    ),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.menu_book,
                label: 'Psychoeducation',
                color: Color(0xFF8D6E63),
                   onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PsychoeducationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GraphicPage extends StatelessWidget {
  const GraphicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appUsage = [
      {
        "icon": Icons.camera,
        "color": Color(0xFFE4405F),
        "name": "Instagram",
        "time": "2 hr, 19 min",
      },
      {
        "icon": Icons.music_note,
        "color": Color.fromARGB(255, 6, 7, 6),
        "name": "Tiktok",
        "time": "1 hr, 19 min",
      },
      {
        "icon": Icons.message,
        "color": Color(0xFF25D366),
        "name": "WhatsApp",
        "time": "57 min",
      },
      {
        "icon": Icons.chrome_reader_mode,
        "color": Color(0xFF4285F4),
        "name": "Chrome",
        "time": "42 min",
      },
      {
        "icon": Icons.send,
        "color": Color(0xFF0088CC),
        "name": "Telegram",
        "time": "27 min",
      },
    ];

    final List<double> weeklyData = [
      2,
      1,
      4,
      0.5,
      6,
      1,
      2,
    ]; // contoh data jam per hari

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3DB2A2), Color(0xFF73D6B6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi, Windy!",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Welcome to Wellnet.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(Icons.person, color: Color(0xFF3DB2A2)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TITLE “Weekly Screen Time”
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Weekly Screen Time",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // GRAFIK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    final double value = weeklyData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 12,
                          height: value * 20, // tinggi batang proporsional
                          decoration: BoxDecoration(
                            color: const Color(0xFF3DB2A2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          [
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat",
                            "Sun",
                          ][index],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tanggal
            const Center(
              child: Text(
                "Sun, Sep 14",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Daftar aplikasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children:
                    appUsage.map((app) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: app['color'],
                                  child: Icon(
                                    app['icon'],
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  app['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              app['time'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // HEADER
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3DB2A2), Color(0xFF73D6B6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
            child: const Center(
              child: Text(
                "Account",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // PROFILE ICON
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Color(0xFF3DB2A2)),
          ),

          const SizedBox(height: 40),

          // MENU ITEMS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                AccountMenuItem(
                  icon: Icons.person_outline,
                  label: 'Edit Profile',
                  onTap: () {
                    // aksi ketika di klik
                  },
                ),
                const SizedBox(height: 20),
                AccountMenuItem(
                  icon: Icons.settings_outlined,
                  label: 'Setting',
                  onTap: () {
                    // aksi ketika di klik
                  },
                ),
                const SizedBox(height: 20),
                AccountMenuItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () {
                    // aksi logout nanti diatur di sini
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF3DB2A2),
                  radius: 20,
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 Tambahkan ini
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 28,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
