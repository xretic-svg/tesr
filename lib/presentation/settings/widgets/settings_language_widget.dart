import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsLanguageWidget extends StatelessWidget {
  final bool isKurdish;
  final Function(bool) onToggle;
  final Color accentColor;

  const SettingsLanguageWidget({
    super.key,
    required this.isKurdish,
    required this.onToggle,
    required this.accentColor,
  });

  String _t(String en, String ku) => isKurdish ? ku : en;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF163527),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF2D6A4F).withAlpha(77)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language_rounded, size: 18, color: accentColor),
                const SizedBox(width: 8),
                Text(
                  _t('Language', 'زمان'),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                // English option
                Expanded(
                  child: GestureDetector(
                    onTap: () => onToggle(false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      height: 44,
                      decoration: BoxDecoration(
                        color: !isKurdish
                            ? accentColor
                            : const Color(0xFF0F2D1F),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: !isKurdish
                              ? accentColor
                              : const Color(0xFF2D6A4F).withAlpha(102),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('🇺🇸', style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            'English',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: !isKurdish
                                  ? Colors.white
                                  : const Color(0xFFA8C5B5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Kurdish option
                Expanded(
                  child: GestureDetector(
                    onTap: () => onToggle(true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isKurdish
                            ? accentColor
                            : const Color(0xFF0F2D1F),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isKurdish
                              ? accentColor
                              : const Color(0xFF2D6A4F).withAlpha(102),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🏳️', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            'کوردی',
                            style: GoogleFonts.notoSansArabic(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isKurdish
                                  ? Colors.white
                                  : const Color(0xFFA8C5B5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Current language indicator
            Center(
              child: Text(
                _t('Currently using English', 'ئێستا کوردی بەکاردێت'),
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: const Color(0xFFA8C5B5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
