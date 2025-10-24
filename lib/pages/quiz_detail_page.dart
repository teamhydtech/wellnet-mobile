import 'package:flutter/material.dart';

class QuizDetailPage extends StatefulWidget {
  final String week;
  final String title;
  final String description;

  const QuizDetailPage({
    super.key,
    required this.week,
    required this.title,
    required this.description,
  });

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  int _currentQuestion = 0;
  final Map<int, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      "question":
          "1. Pernyataan “Semua informasi yang viral di media sosial sudah pasti benar dan terverifikasi.”",
      "options": ["Fakta", "Mitos"],
    },
    {
      "question":
          "2. Manakah definisi yang paling tepat untuk “Literasi Digital”?",
      "options": [
        "Kemampuan menggunakan komputer dan internet dengan cepat.",
        "Kemampuan untuk mencari hiburan di media sosial.",
        "Kemampuan untuk memiliki semua aplikasi media sosial terbaru.",
        "Kemampuan untuk menggunakan teknologi digital secara bijak dan bertanggung jawab.",
      ],
    },
    {
      "question":
          "3. Manakah contoh penggunaan ponsel yang paling mencerminkan perilaku produktif untuk mendukung pembelajaran?",
      "options": [
        "Menggunakan aplikasi kamus online untuk membantu tugas bahasa.",
        "Terus-menerus scrolling media sosial tanpa tujuan.",
        "Membalas pesan chat setiap kali ada notifikasi.",
        "Menghabiskan berjam-jam bermain game tanpa tujuan.",
      ],
    },
    {
      "question":
          "4. Dari literasi digital (menemukan, menggunakan, mengevaluasi, membuat, dan membagikan informasi), langkah yang paling krusial untuk menghindari hoax dan disinformasi adalah...",
      "options": [
        "Mencari informasi.",
        "Mengevaluasi informasi.",
        "Membuat informasi.",
        "Membagikan informasi.",
      ],
    },
    {
      "question":
          "4. Dari literasi digital (menemukan, menggunakan, mengevaluasi, membuat, dan membagikan informasi), langkah yang paling krusial untuk menghindari hoax dan disinformasi adalah...",
      "options": [
        "Mencari informasi.",
        "Mengevaluasi informasi.",
        "Membuat informasi.",
        "Membagikan informasi.",
      ],
    },
  ];

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Kuis Selesai 🎉"),
            content: const Text(
              "Kamu telah menyelesaikan semua pertanyaan minggu ini.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Kembali"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER GRADIENT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol back
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Minggu (misal: Week 1)
                  Text(
                    widget.week,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Judul kuis (misal: Hutan Pengetahuan)
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Deskripsi singkat (misal: "Uji pengetahuanmu tentang lingkungan!")
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 BODY KUIS
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                 

                    // Progress indicator
                    Center(
                      child: Text(
                        "Pertanyaan ${_currentQuestion + 1} dari ${_questions.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1EAE98),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Pertanyaan
                    Text(
                      question["question"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Opsi jawaban
                    ...List.generate(question["options"].length, (index) {
                      final option = question["options"][index];
                      final selected = _answers[_currentQuestion] == option;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _answers[_currentQuestion] = option;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    selected
                                        ? const Color(0xFF1EAE98)
                                        : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              color:
                                  selected
                                      ? const Color(0xFFE0F7F3)
                                      : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  selected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color:
                                      selected
                                          ? const Color(0xFF1EAE98)
                                          : Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 25),

                    // Tombol Next / Finish
                    Center(
                      child: ElevatedButton(
                        onPressed:
                            _answers.containsKey(_currentQuestion)
                                ? _nextQuestion
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1EAE98),
                          minimumSize: const Size(120, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _currentQuestion == _questions.length - 1
                              ? "Finish"
                              : "Next",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
