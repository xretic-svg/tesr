import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingContentWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int currentPage;
  final int totalPages;
  final bool isTablet;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;
  final String getStartedLabel;
  final Color accentColor;

  const OnboardingContentWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentPage,
    required this.totalPages,
    required this.isTablet,
    required this.onPrev,
    required this.onNext,
    required this.onGetStarted,
    this.getStartedLabel = 'Get Started',
    this.accentColor = const Color(0xFF52B788),
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = isTablet ? 520.0 : double.infinity;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: isTablet ? 40 : 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withAlpha(179),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Navigation row
              Row(
                children: [
                  // Prev button
                  _CircleNavButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: onPrev,
                    enabled: currentPage > 0,
                  ),
                  const SizedBox(width: 12),
                  // Next button
                  _CircleNavButton(
                    icon: Icons.arrow_forward_rounded,
                    onTap: onNext,
                    enabled: currentPage < totalPages - 1,
                    filled: true,
                  ),
                  const SizedBox(width: 20),
                  // Get Started button
                  Expanded(
                    child: GestureDetector(
                      onTap: onGetStarted,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: accentColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: accentColor.withAlpha(128),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          getStartedLabel,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Page indicators
              Row(
                children: List.generate(totalPages, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.only(right: 6),
                    width: index == currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == currentPage
                          ? accentColor
                          : Colors.white.withAlpha(77),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  final bool filled;

  const _CircleNavButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: filled
              ? Colors.white.withOpacity(enabled ? 0.25 : 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(enabled ? 0.5 : 0.2),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white.withOpacity(enabled ? 1.0 : 0.3),
          size: 20,
        ),
      ),
    );
  }
}
