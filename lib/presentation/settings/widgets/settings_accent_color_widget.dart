import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsAccentColorWidget extends StatelessWidget {
  final Map<String, Color> accentOptions;
  final Color selectedColor;
  final Function(Color) onChanged;
  final bool isKurdish;

  const SettingsAccentColorWidget({
    super.key,
    required this.accentOptions,
    required this.selectedColor,
    required this.onChanged,
    required this.isKurdish,
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
                Icon(Icons.palette_rounded, size: 18, color: selectedColor),
                const SizedBox(width: 8),
                Text(
                  _t('Accent Color', 'ڕەنگی سەرەکی'),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: accentOptions.entries.map((entry) {
                final isSelected = entry.value == selectedColor;
                return GestureDetector(
                  onTap: () => onChanged(entry.value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    width: isSelected ? 44 : 36,
                    height: isSelected ? 44 : 36,
                    decoration: BoxDecoration(
                      color: entry.value,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: entry.value.withAlpha(128),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // Color labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: accentOptions.entries.map((entry) {
                final isSelected = entry.value == selectedColor;
                return SizedBox(
                  width: 44,
                  child: Text(
                    _localizedColorName(entry.key, isKurdish),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? entry.value : const Color(0xFFA8C5B5),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedColorName(String key, bool isKurdish) {
    const names = {
      'green': ['Green', 'سەوز'],
      'blue': ['Blue', 'شین'],
      'purple': ['Purple', 'مۆر'],
      'red': ['Red', 'سور'],
      'brown': ['Brown', 'قاوەیی'],
    };
    final pair = names[key] ?? [key, key];
    return isKurdish ? pair[1] : pair[0];
  }
}
