import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsMenuItemsWidget extends StatelessWidget {
  final Color accentColor;
  final bool isKurdish;

  const SettingsMenuItemsWidget({
    super.key,
    required this.accentColor,
    required this.isKurdish,
  });

  String _t(String en, String ku) => isKurdish ? ku : en;

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.receipt_long_rounded,
        'label': _t('Transactions', 'مامەڵەکان'),
        'badge': '12',
      },
      {
        'icon': Icons.assignment_return_rounded,
        'label': _t('Return Order', 'گەڕاندنەوەی داواکاری'),
        'badge': null,
      },
      {
        'icon': Icons.support_agent_rounded,
        'label': _t('Contact Us', 'پەیوەندیمان پێوەبکە'),
        'badge': null,
      },
      {
        'icon': Icons.info_outline_rounded,
        'label': _t('About', 'دەربارە'),
        'badge': null,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF163527),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF2D6A4F).withAlpha(77)),
        ),
        child: Column(
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;

            return GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                          bottom: BorderSide(
                            color: const Color(0xFF2D6A4F).withAlpha(51),
                            width: 1,
                          ),
                        ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: accentColor.withAlpha(31),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: 18,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item['label'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (item['badge'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item['badge'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: const Color(0xFF4A7C59),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
