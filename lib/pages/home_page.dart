import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

// API Packages
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController stockController = TextEditingController();
  double progress = 0;

  Future<Map<String, dynamic>> startTask(String ticker) async {
    final url = Uri.parse('http://localhost:8000/api/v1/$ticker');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load task ID');
    }
  }

  Future<Map<String, dynamic>> getProgress(String taskID) async {
    final url = Uri.parse('http://localhost:8000/api/v1/progress/$taskID');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load progress');
    }
  }

  void updateProgress(String taskID) async {
    while (progress < 100) {
      try {
        var taskProgress = await getProgress(taskID);
        setState(() {
          progress = double.parse(taskProgress["progress"].toString());
        });

        await Future.delayed(Duration(seconds: 1));
      } catch (e) {
        print("Error getting progress: $e");
        break;
      }
    }
  }

  void resetProgress() {
    setState(() {
      progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Company Scan',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Search Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08), // very soft shadow
                    blurRadius: 12, // how soft
                    offset: const Offset(0, 4), // slightly down
                  ),
                ],
              ),
              child: SizedBox(
                width: 512,

                // TextField
                child: TextField(
                  controller: stockController,
                  maxLength: 6,
                  style: GoogleFonts.openSans(color: Colors.black),
                  inputFormatters: [
                    UpperCaseTextFormatter(), // 👈 Custom formatter
                  ],

                  decoration: InputDecoration(
                    // Icon
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(Icons.search, color: Colors.grey[400]),
                    ),

                    // Button
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            final ticker = stockController.text;
                            try {
                              resetProgress();
                              final task = await startTask(ticker);
                              updateProgress(task['task_id']);
                            } catch (e) {
                              print("Error: $e");
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Style
                    counterText: '',
                    hintText: 'Scan a stock... (e.g. NVDA)',
                    hintStyle: GoogleFonts.openSans(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32),

            // Content cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fundamental Card
                Container(
                  width: 300,
                  height: 420,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BoxBorder.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.11),
                        blurRadius: 5,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'AAPL',
                          style: GoogleFonts.openSans(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PE',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              '00.00',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),

                SizedBox(width: 16),

                Column(
                  children: [
                    // Progress Card
                    Container(
                      width: 200,
                      height: 200,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: BoxBorder.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.11),
                            blurRadius: 5,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 13,
                        animation: true,
                        percent: progress / 100,
                        center: Text(
                          progress.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Review Card
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: BoxBorder.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.11),
                            blurRadius: 5,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '80 / 100',
                            style: GoogleFonts.openSans(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Uppercase Formater
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
