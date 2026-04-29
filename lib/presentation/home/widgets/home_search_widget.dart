import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_state.dart';

class HomeSearchWidget extends StatelessWidget {
  final Function(String) onChanged;
  final Color accentColor;

  const HomeSearchWidget({
    super.key,
    required this.onChanged,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF163527),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF2D6A4F).withAlpha(102),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(
              Icons.search_rounded,
              color: Color(0xFFA8C5B5),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                style: GoogleFonts.outfit(fontSize: 14, color: Colors.white),
                decoration: InputDecoration(
                  hintText: appState.t('Search...', 'گەڕان...'),
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 14,
                    color: const Color(0xFFA8C5B5),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
