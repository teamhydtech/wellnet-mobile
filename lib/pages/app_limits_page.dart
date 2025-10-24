import 'package:flutter/material.dart';
import 'package:wellnet/pages/home_page.dart';

class AppLimitsPage extends StatefulWidget {
  const AppLimitsPage({Key? key}) : super(key: key);

  @override
  State<AppLimitsPage> createState() => _AppLimitsPageState();
}

class _AppLimitsPageState extends State<AppLimitsPage> {
  // Data struktur: daftar kategori, setiap kategori berisi daftar apps
  final List<Map<String, dynamic>> categories = [
    {
      'id': 'social',
      'title': 'Social',
      'icon': Icons.chat_bubble_outline,
      'apps': [
        {'name': 'Instagram', 'limit': '2 hr, 10 min', 'icon': Icons.photo},
        {'name': 'TikTok', 'limit': '1 hr, 10 min', 'icon': Icons.music_note},
        {'name': 'WhatsApp', 'limit': '40 min', 'icon': Icons.chat},
      ],
    },
    {
      'id': 'entertainment',
      'title': 'Entertainment',
      'icon': Icons.tv,
      'apps': [
        {
          'name': 'YouTube',
          'limit': '2 hr, 30 min',
          'icon': Icons.ondemand_video,
        },
        {'name': 'Netflix', 'limit': '2 hr', 'icon': Icons.movie},
      ],
    },
    {
      'id': 'education',
      'title': 'Education',
      'icon': Icons.school,
      'apps': [
        {
          'name': 'Google Classroom',
          'limit': '1 hr, 30 min',
          'icon': Icons.class_,
        },
        {'name': 'Duolingo', 'limit': '1 hr', 'icon': Icons.school},
      ],
    },
  ];

  // ID dari panel yang sedang terbuka (radio) — gunakan string id kategori
  String? _openPanelId;

  // Helper: buka time picker dan simpan perubahan pada data categories
  Future<void> _pickLimitForApp(int catIndex, int appIndex) async {
    // initial value: parse existing limit if possible, fallback to 0:0
    final existing = categories[catIndex]['apps'][appIndex]['limit'] as String?;
    int initialHour = 0;
    int initialMinute = 0;
    if (existing != null) {
      // coba parse "X hr, Y min" sederhana
      final hrMatch = RegExp(r'(\d+)\s*hr').firstMatch(existing);
      final minMatch = RegExp(r'(\d+)\s*min').firstMatch(existing);
      if (hrMatch != null) initialHour = int.tryParse(hrMatch.group(1)!) ?? 0;
      if (minMatch != null)
        initialMinute = int.tryParse(minMatch.group(1)!) ?? 0;
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: initialHour.clamp(0, 23),
        minute: initialMinute.clamp(0, 59),
      ),
    );

    if (picked != null && mounted) {
      final formatted =
          "${picked.hour} hr, ${picked.minute.toString().padLeft(2, '0')} min";
      setState(() {
        categories[catIndex]['apps'][appIndex]['limit'] = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Bottom nav (tetap seperti kamu pakai)
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
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Graphic"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "App Limits",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Choose apps and set time limits for each one.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Expansion list area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: _buildExpansionPanels(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membangun ExpansionPanelList.radio dari categories
  Widget _buildExpansionPanels() {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 6),
      animationDuration: const Duration(milliseconds: 300),
      children: [
        for (int ci = 0; ci < categories.length; ci++)
          ExpansionPanelRadio(
            value: categories[ci]['id'] as String,
            headerBuilder: (context, isOpen) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      categories[ci]['icon'] as IconData,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      categories[ci]['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            },
            canTapOnHeader: true,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: Column(
                children: [
                  for (
                    int ai = 0;
                    ai < (categories[ci]['apps'] as List).length;
                    ai++
                  )
                    _buildAppRow(ci, ai),
                ],
              ),
            ),
          ),
      ],
      // track open panel id (optional)
      expansionCallback: (index, isOpen) {
        // we don't need manual toggle because radio handles it, but keep _openPanelId updated if needed
        final id = categories[index]['id'] as String;
        setState(() {
          _openPanelId = isOpen ? null : id;
        });
      },
    );
  }

  // Single app row widget: icon, name, limit, clock icon. Tap opens time picker.
  Widget _buildAppRow(int catIndex, int appIndex) {
    final app = categories[catIndex]['apps'][appIndex] as Map<String, dynamic>;
    final String name = app['name'] as String;
    final String limit = app['limit'] as String;
    final IconData icon = app['icon'] as IconData;

    return GestureDetector(
      onTap: () => _pickLimitForApp(catIndex, appIndex),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon + name
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFE8F7F6),
                  child: Icon(icon, color: const Color(0xFF3DB2A2)),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // limit + clock icon
            Row(
              children: [
                Text(
                  limit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.access_time, color: Colors.black45, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
