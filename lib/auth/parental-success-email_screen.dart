import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class successParentalVerificationScreen extends StatefulWidget {
  const successParentalVerificationScreen({super.key});

  @override
  State<successParentalVerificationScreen> createState() => _successParentalVerificationScreenState();
}

class _successParentalVerificationScreenState extends State<successParentalVerificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 200),
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
                    textAlign: TextAlign.center,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
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

              const SizedBox(height: 40),

              Align(
                alignment: Alignment.center,
                child: const Text(
                  'Parental Email Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0A0A32),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.center,
                child: const Text(
                  "Since your age is under 13, parental\nconsent is required. Please enter your\n parent's email to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9CA0B0),
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F6),
                  border: Border.all(color: const Color(0xFF1BA39C)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1BA39C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Verification email has been sent successfully. Please continue.',
                        style: TextStyle(
                          color: Color(0xFF4E5A68),
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Next Button
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
                    Get.toNamed(AppRoutes.selfAssesment);
                  },
                  child: const Text(
                    'CONTINUE',
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
}
