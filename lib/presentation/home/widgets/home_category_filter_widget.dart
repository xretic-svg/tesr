import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCategoryFilterWidget extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Color accentColor;
  final Function(int) onSelect;

  const HomeCategoryFilterWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.accentColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelect(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? accentColor : const Color(0xFF163527),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? accentColor
                      : const Color(0xFF2D6A4F).withAlpha(102),
                  width: 1,
                ),
              ),
              child: Text(
                categories[index],
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFFA8C5B5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
