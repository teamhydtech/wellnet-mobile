import 'package:flutter/material.dart';
import 'quiz_detail_page.dart'; // ⬅️ import halaman detail kuis

class QuizChallengePage extends StatelessWidget {
  const QuizChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/account');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Graphic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔹 HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5AC8FA), Color(0xFF1EAE98)],
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
                      'Quiz Challenge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Selesaikan kuis minggu ini dan raih skor terbaikmu!',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
             
              const SizedBox(height: 20),

              // 🔹 LIST QUIZ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    QuizCard(
                      week: "WEEK 1",
                      title: "Hutan Pengetahuan: Langkah Awal Sang Penjelajah",
                      description: "Pengantar Literasi Digital",
                      colorTag: Color(0xFFAFE6DB),
                    ),
                    QuizCard(
                      week: "WEEK 2",
                      title: "Lembah Tersembunyi: Melindungi Harta Digitalku",
                      description: "Privasi & Keamanan Data",
                      colorTag: Color(0xFFD1E8E1),
                    ),
                    QuizCard(
                      week: "WEEK 3",
                      title: "Hutan Pengetahuan: Langkah Awal Sang Penjelajah",
                      description: "Pengantar Literasi Digital",
                      colorTag: Color(0xFFAFE6DB),
                    ),
                    QuizCard(
                      week: "WEEK 4",
                      title: "Lembah Tersembunyi: Melindungi Harta Digitalku",
                      description: "Privasi & Keamanan Data",
                      colorTag: Color(0xFFD1E8E1),
                    ),
                    QuizCard(
                      week: "WEEK 5",
                      title: "Danau Refleksi: Menumbuhkan Empati di Dunia Maya",
                      description: "Cyberbullying & Empati Daring",
                      colorTag: Color(0xFFC0E7E0),
                    ),
                    QuizCard(
                      week: "WEEK 6",
                      title: "Tebing Waspada: Menghindari Jaringan Penipuan",
                      description: "Phishing & Penipuan Digital",
                      colorTag: Color(0xFFAFE6DB),
                    ),
                    QuizCard(
                      week: "WEEK 7",
                      title: "Gua Kebenaran: Menyusuri Lorong Informasi Gelap",
                      description: "Disinformasi & Literasi Media",
                      colorTag: Color(0xFFD1E8E1),
                    ),
                    QuizCard(
                      week: "WEEK 8",
                      title: "Hutan Pengetahuan: Langkah Awal Sang Penjelajah",
                      description: "Pengantar Literasi Digital",
                      colorTag: Color(0xFFAFE6DB),
                    ),
                    QuizCard(
                      week: "WEEK 9",
                      title: "Lembah Tersembunyi: Melindungi Harta Digitalku",
                      description: "Privasi & Keamanan Data",
                      colorTag: Color(0xFFD1E8E1),
                    ),
                    QuizCard(
                      week: "WEEK 10",
                      title: "Danau Refleksi: Menumbuhkan Empati di Dunia Maya",
                      description: "Cyberbullying & Empati Daring",
                      colorTag: Color(0xFFC0E7E0),
                    ),
                    QuizCard(
                      week: "WEEK 11",
                      title: "Tebing Waspada: Menghindari Jaringan Penipuan",
                      description: "Phishing & Penipuan Digital",
                      colorTag: Color(0xFFAFE6DB),
                    ),
                    QuizCard(
                      week: "WEEK 12",
                      title: "Gua Kebenaran: Menyusuri Lorong Informasi Gelap",
                      description: "Disinformasi & Literasi Media",
                      colorTag: Color(0xFFD1E8E1),
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

// 🔹 Widget QuizCard
class QuizCard extends StatelessWidget {
  final String week;
  final String title;
  final String description;
  final Color colorTag;

  const QuizCard({
    super.key,
    required this.week,
    required this.title,
    required this.description,
    required this.colorTag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail kuis
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizDetailPage(
              week: week,
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FBFA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7F3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.landscape_rounded, color: Colors.black87),
          ),
          title: Text(
            week,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1EAE98),
              fontSize: 14,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorTag, width: 1.5),
                ),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
