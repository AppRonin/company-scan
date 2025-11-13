import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockTile extends StatelessWidget {
  final String ratio;
  final String ratioValue;

  const StockTile({super.key, required this.ratio, required this.ratioValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ratio,
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ratioValue,
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
