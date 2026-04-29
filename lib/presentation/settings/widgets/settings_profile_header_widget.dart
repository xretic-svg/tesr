import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class SettingsProfileHeaderWidget extends StatelessWidget {
  final Color accentColor;
  final bool isKurdish;

  const SettingsProfileHeaderWidget({
    super.key,
    required this.accentColor,
    required this.isKurdish,
  });

  String _t(String en, String ku) => isKurdish ? ku : en;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF163527),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF2D6A4F).withAlpha(77),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar with edit overlay
            Stack(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accentColor, width: 2.5),
                  ),
                  child: ClipOval(
                    child: CustomImageWidget(
                      imageUrl:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      semanticLabel:
                          'Profile photo of Robert Fox, man with short brown hair in casual attire',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF163527),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Robert Fox',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: accentColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _t('New York, USA', 'نیویۆرک، ئەمریکا'),
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: const Color(0xFFA8C5B5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 13, color: accentColor),
                      const SizedBox(width: 4),
                      Text(
                        '+1 (555) 248-3910',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: const Color(0xFFA8C5B5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Edit button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(38),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: accentColor.withAlpha(102),
                    width: 1,
                  ),
                ),
                child: Icon(Icons.edit_rounded, size: 16, color: accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
