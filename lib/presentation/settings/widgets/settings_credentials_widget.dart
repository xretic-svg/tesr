import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsCredentialsWidget extends StatefulWidget {
  final Color accentColor;
  final bool isKurdish;

  const SettingsCredentialsWidget({
    super.key,
    required this.accentColor,
    required this.isKurdish,
  });

  @override
  State<SettingsCredentialsWidget> createState() =>
      _SettingsCredentialsWidgetState();
}

class _SettingsCredentialsWidgetState extends State<SettingsCredentialsWidget> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController(
    text: 'robert.fox@luxwatch.com',
  );
  final _passwordController = TextEditingController(text: 'LuxW@tch2024');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _t(String en, String ku) => widget.isKurdish ? ku : en;

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
                Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                  color: widget.accentColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _t('Account Security', 'پارێزگاری ئەکاونت'),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Email field
            _buildField(
              label: _t('Email', 'ئیمەیڵ'),
              controller: _emailController,
              icon: Icons.email_outlined,
              obscure: false,
            ),
            const SizedBox(height: 10),
            // Password field
            _buildField(
              label: _t('Password', 'وشەی نهێنی'),
              controller: _passwordController,
              icon: Icons.lock_outlined,
              obscure: _obscurePassword,
              suffixTap: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool obscure,
    VoidCallback? suffixTap,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2D6A4F).withAlpha(102)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(icon, size: 18, color: const Color(0xFFA8C5B5)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.white),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: GoogleFonts.outfit(
                  fontSize: 14,
                  color: const Color(0xFFA8C5B5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                filled: false,
              ),
            ),
          ),
          if (suffixTap != null)
            GestureDetector(
              onTap: suffixTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: const Color(0xFFA8C5B5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
