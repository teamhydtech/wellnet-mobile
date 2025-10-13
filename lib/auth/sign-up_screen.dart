import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;
  TimeOfDay? _digitalUsage;
  TimeOfDay? _sleepStart;
  TimeOfDay? _sleepEnd;

  Future<void> _pickTime(BuildContext context, Function(TimeOfDay) onPicked) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (picked != null) onPicked(picked);
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '...... : ......';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour : $minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo + Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo-wellnet.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0A32),
                      ),
                      children: [
                        const TextSpan(text: 'Sign Up to '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1BA39C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            child: const Text(
                              'Wellnet',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Full Name
              const Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF0A0A32),
                ),
              ),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _nameController,
                hint: 'input your name here',
              ),

              const SizedBox(height: 20),

              // Age
              const Text(
                'Age',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF0A0A32),
                ),
              ),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _ageController,
                hint: 'input your age here',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              // Gender
              const Text(
                'Gender',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF0A0A32),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF1BA39C)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: ['Male', 'Female', 'Other'].contains(_selectedGender) ? _selectedGender : null,
                    hint: const Text(
                      'select your gender',
                      style: TextStyle(color: Color(0xFF9CA0B0)),
                    ),
                    isExpanded: true,
                    items: ['Male', 'Female', 'Other'].map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    )).toList(),
                    onChanged: (value) => setState(() => _selectedGender = value),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Daily Digital Usage
              const Text(
                'Daily Digital Usage (hours/minutes)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF0A0A32),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => _pickTime(context, (t) => setState(() => _digitalUsage = t)),
                child: _buildTimeField(_formatTime(_digitalUsage)),
              ),

              const SizedBox(height: 20),

              // 🌙 Sleep Habit
              const Text(
                'Sleep Habit (bedtime & wake-up time)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF0A0A32),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  await _pickTime(context, (t) => setState(() => _sleepStart = t));
                  await _pickTime(context, (t) => setState(() => _sleepEnd = t));
                },
                child: _buildTimeField(
                  '${_formatTime(_sleepStart)}   to   ${_formatTime(_sleepEnd)}',
                ),
              ),

              const SizedBox(height: 40),

              // 🟩 Next Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1BA39C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.parentalVerification);
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA0B0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1BA39C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1BA39C), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildTimeField(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1BA39C)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Color(0xFF9CA0B0)),
          ),
          const Icon(Icons.access_time, color: Color(0xFF9CA0B0)),
        ],
      ),
    );
  }
}
