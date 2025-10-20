import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnet/routes/app_routes.dart';

class AssessmentResultPage extends StatelessWidget {
  final int totalScore;

  const AssessmentResultPage({super.key, required this.totalScore});

  Map<String, dynamic> _getBadgeData(int score) {
    if (score <= 17) {
      return {
        'title': 'Seedling',
        'image': 'images/badges/seedling.png',
        'description':
        'Hai! Saat ini kamu berada di tahap awal kesadaran digital. '
            'Mungkin kamu masih sering merasa stres, bingung, atau lelah saat menggunakan gadget. '
            'Itu wajar! Ini adalah langkah pertamamu untuk lebih mengenal diri sendiri dalam dunia digital. '
            'Yuk, mulai pelan-pelan belajar mengatur waktu layar dan mengenali emosi kamu saat online. '
            'Kamu tidak sendirian — WELLNET akan mendampingimu.',
      };
    } else if (score <= 24) {
      return {
        'title': 'Sprout',
        'image': 'images/badges/sprout.png',
        'description':
        'Kamu mulai tumbuh! Sekarang kamu sudah menyadari bahwa ada hal-hal yang mempengaruhi perasaan '
            'dan pikiranmu saat menggunakan internet. Meski kadang masih sulit mengontrolnya, kamu sedang belajar — dan itu luar biasa! '
            'Teruslah eksplorasi bagaimana membatasi penggunaan gadget, dan kenali kebiasaan yang bikin kamu lebih nyaman dan tenang secara digital.',
      };
    } else if (score <= 32) {
      return {
        'title': 'Explorer',
        'image': 'images/badges/explorer.png',
        'description':
        'Hebat! Kamu mulai aktif mencari cara untuk menjaga keseimbangan antara dunia nyata dan dunia digital. '
            'Kamu juga sudah bisa mengenali konten atau interaksi yang sehat dan yang perlu dihindari. '
            'Kamu sedang membangun pondasi yang kuat untuk digital wellbeing. Teruskan perjalananmu, kamu sudah berada di jalur yang baik!',
      };
    } else if (score <= 40) {
      return {
        'title': 'Trailblazer',
        'image': 'images/badges/trailblazer.png',
        'description':
        'Kamu telah menunjukkan kemajuan besar! Sekarang kamu bisa mengendalikan emosi saat online dan tahu kapan harus beristirahat dari layar. '
            'Kamu mulai menetapkan batasan, membuat keputusan digital yang lebih bijak, dan bahkan bisa jadi contoh untuk teman-temanmu.',
      };
    } else if (score <= 47) {
      return {
        'title': 'Mountaineer',
        'image': 'images/badges/mountaineer.png',
        'description':
        'Luar biasa! Kamu sudah mencapai tahap yang menunjukkan ketahanan digital yang kuat. '
            'Kamu tahu kapan harus berhenti, bisa menjaga interaksi yang sehat, dan tidak mudah terpengaruh konten negatif. '
            'Teruslah pertahankan dan sebarkan nilai positif ini!',
      };
    } else if (score <= 54) {
      return {
        'title': 'Skywalker',
        'image': 'images/badges/skywalker.png',
        'description':
        'Kamu punya keseimbangan digital yang sangat baik. '
            'Kamu bukan hanya bijak dalam menggunakan teknologi, tapi juga mampu menjaga empati dan sopan santun saat berinteraksi online. '
            'Bangga banget punya kamu di komunitas WELLNET!',
      };
    } else {
      return {
        'title': 'Digital Sage',
        'image': 'images/badges/digital-sage.png',
        'description':
        'Selamat! Kamu telah mencapai level tertinggi dalam kesejahteraan digital. '
            'Kamu bukan hanya mampu mengatur diri dan emosi secara mandiri, tapi juga punya kesadaran tinggi untuk menjadi panutan '
            'dalam etika dan keberlanjutan digital. Tetap rendah hati dan terus sebarkan kebaikan!',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final badge = _getBadgeData(totalScore);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // ✅ Hilangkan panah back
        toolbarHeight: 80, // ✅ Tambah tinggi AppBar agar ada jarak vertikal
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Initial Result',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 80,
              backgroundColor: const Color(0xFF22C55E).withOpacity(0.15),
              child: Image.asset(
                badge['image'],
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge['title'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF082F49),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Jumlah Skor : $totalScore',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF475569),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '“${badge['description']}”',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF475569),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.justify, // ✅ Rata kanan–kiri
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.targetSettings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF0D9488).withOpacity(0.3),
                ),
                child: const Text(
                  'CONTINUE TO TARGET SETTING',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
