import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../core/app_state.dart';

class AppNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color accentColor;

  const AppNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF163527),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(89),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: appState.t('Home', 'ماڵەوە'),
              isActive: currentIndex == 0,
              accentColor: accentColor,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.shopping_basket_rounded,
              label: appState.t('Basket', 'سەبەتە'),
              isActive: currentIndex == 1,
              accentColor: accentColor,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: Icons.favorite_rounded,
              label: appState.t('Favourite', 'دڵخواز'),
              isActive: currentIndex == 2,
              accentColor: accentColor,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: Icons.settings_rounded,
              label: appState.t('Settings', 'ڕێکخستن'),
              isActive: currentIndex == 3,
              accentColor: accentColor,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? accentColor.withAlpha(51) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? accentColor : const Color(0xFF4A7C59),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
