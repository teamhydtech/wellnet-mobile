import 'package:flutter/material.dart';
import 'package:wellnet/pages/detail_psychoeducation_page.dart';

class PsychoeducationPage extends StatelessWidget {
  final List<Map<String, String>> materials = [
    {
      'title': 'Jejak Digitalmu, Tanggung Jawabmu',
      'subtitle': 'Digital Footprint & Online Identity',
      'content': '''
1. Pengertian: Apa itu Jejak Digital dan Identitas Online?
Jejak digital (digital footprint) adalah jejak aktivitas yang kita tinggalkan saat menggunakan internet, baik secara sadar (posting, komentar, berbagi) atau tidak sadar (riwayat pencarian, cookies).

Identitas online (online identity) adalah citra diri kita di dunia maya, mencerminkan siapa kita di ranah digital (Feher, 2019).

💡 Tips:
- Pikir sebelum berbagi
- Gunakan media sosial secara etis
- Jaga privasi dan data pribadi
- Selalu ingat: Sekali upload, selalu ada jejaknya
''',
    },
    {
      'title': 'Mengelola Emosi dengan Baik',
      'subtitle': 'Emotional Regulation',
      'content': '''
Emosi adalah bagian dari diri manusia. Mengelola emosi berarti mampu mengenali, memahami, dan mengarahkan perasaan agar tidak merugikan diri sendiri maupun orang lain.

💡 Tips:
- Kenali pemicunya
- Latih pernapasan dalam
- Gunakan cara sehat untuk menenangkan diri
''',
    },
    {
      'title': 'Berpikir Positif di Era Digital',
      'subtitle': 'Positive Mindset Online',
      'content': '''
Berpikir positif membantu kita tetap sehat mental di tengah banjir informasi digital. Fokus pada hal yang bisa dikontrol, bukan yang tidak bisa diubah.

💡 Tips:
- Kurangi perbandingan sosial
- Follow akun inspiratif
- Batasi waktu media sosial
''',
    },
    {
      'title': 'Menjaga Keseimbangan Hidup',
      'subtitle': 'Work-Life Balance',
      'content': '''
Keseimbangan antara pekerjaan dan kehidupan pribadi sangat penting untuk kesehatan mental.

💡 Tips:
- Tetapkan batas waktu kerja
- Nikmati waktu luang tanpa gadget
- Utamakan waktu bersama keluarga dan teman
''',
    },
    {
      'title': 'Mengenal Diri Lebih Dalam',
      'subtitle': 'Self Awareness',
      'content': '''
Kesadaran diri adalah kemampuan memahami pikiran, emosi, dan perilaku kita sendiri. Dengan mengenali diri, kita bisa bertindak lebih bijak.

💡 Tips:
- Refleksi diri setiap hari
- Catat perasaanmu
- Jangan takut bertanya "kenapa aku merasa begini?"
''',
    },
    {
      'title': 'Membangun Hubungan Sehat',
      'subtitle': 'Healthy Relationship',
      'content': '''
Hubungan sehat ditandai dengan saling menghargai, komunikasi terbuka, dan kepercayaan.

💡 Tips:
- Dengarkan tanpa menghakimi
- Jaga batas pribadi
- Hargai perbedaan pendapat
''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.public,
      Icons.self_improvement,
      Icons.psychology,
      Icons.balance,
      Icons.person_search,
      Icons.favorite,
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
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
                  'PSYCOEDUCATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Yuk, ikuti materinya dan temukan insight baru tentang dirimu!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Grid Cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: materials.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = materials[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PsychoeducationDetailPage(
                            title: item['title']!,
                            subtitle: item['subtitle']!,
                            content: item['content']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            size: 50,
                            color: const Color(0xFF1EAE98),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
