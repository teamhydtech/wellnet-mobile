import 'package:flutter/material.dart';

import 'initial-result_screen.dart';

class SelfAssessmentScreen extends StatefulWidget {
  const SelfAssessmentScreen({super.key});

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  // Simpan nilai jawaban untuk tiap pertanyaan (index = nomor soal)
  final Map<int, int> _answers = {};

  final List<String> _questions = [
    'Saya mampu mengendalikan emosi negatif yang timbul saat menggunakan perangkat digital.',
    'Saya mampu mengatasi perubahan suasana hati yang disebabkan oleh penggunaan perangkat digital.',
    'Saya mampu mengatasi tekanan emosional yang ditimbulkan saat saya berselancar di dunia maya.',
    'Saya mampu mengatasi hal-hal negatif yang dapat menimpa saya saat berselancar di dunia maya.',
    'Saya menetapkan batasan atas penggunaan gadget.',
    'Saya membatasi waktu penggunaan perangkat digital.',
    'Saya merasa senang saat orang lain terhubung dengan saya di media sosial.',
    'Saya merasa senang saat seseorang secara online menghubungi saya di masa sulit.',
    'Saya merasa senang saat seseorang berinteraksi dengan saya di dunia digital.',
    'Saya merasa senang saat sesama pengguna online menunjukkan perilaku yang sopan.',
    'Saya merasa senang saat sesama pengguna online mempertimbangkan kelayakan konten sebelum membagikannya.',
    'Saya merasa senang saat orang yang saya temui secara online bersikap baik kepada saya.',
  ];

  @override
  Widget build(BuildContext context) {
    final progress = _answers.length / _questions.length;
    final allAnswered = _answers.length == _questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 🟢 Scrollable Content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // Logo
                  Center(
                    child: Image.asset(
                      'images/logo-wellnet.png',
                      width: 72,
                      height: 72,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Title
                  const Text(
                    'Self-Assessment\nDigital Well-being',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A0A32),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Grid pertanyaan
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _questions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 28),
                    itemBuilder: (context, i) {
                      return AssessmentCard(
                        index: i + 1,
                        question: _questions[i],
                        selectedValue: _answers[i] ?? 0,
                        onSelected: (value) {
                          setState(() => _answers[i] = value);
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            // 🔹 Progress bar + Next button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Progress bar
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFFD7EEED),
                      color: const Color(0xFF1BA39C),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 12),

                    // Button Next
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: allAnswered
                            ? () {
                          final totalScore = _answers.values.fold(0, (a, b) => a + b);
                          debugPrint('Total skor: $totalScore');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssessmentResultPage(totalScore: totalScore),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: allAnswered
                              ? const Color(0xFF1BA39C)
                              : const Color(0xFFBFD7D6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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

// Widget pertanyaan individual (card)
class AssessmentCard extends StatelessWidget {
  final int index;
  final String question;
  final int selectedValue;
  final ValueChanged<int> onSelected;

  const AssessmentCard({
    super.key,
    required this.index,
    required this.question,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7EEED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$index. $question',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              color: Color(0xFF0A0A32),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final value = index + 1;
              final isSelected = selectedValue == value;
              return GestureDetector(
                onTap: () => onSelected(value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1BA39C)
                        : const Color(0xFFD7EEED),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF0A0A32),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Never',
                  style: TextStyle(
                    color: Color(0xFF9CA0B0),
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Always',
                  style: TextStyle(
                    color: Color(0xFF9CA0B0),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
