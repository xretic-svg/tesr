import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../core/app_state.dart';

class HomeHeaderWidget extends StatelessWidget {
  final Color accentColor;

  const HomeHeaderWidget({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withAlpha(128), width: 2),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl:
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                semanticLabel:
                    'Profile photo of Robert Fox, a man with short brown hair',
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appState.t('Hello', 'سڵاو'),
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFA8C5B5),
                  ),
                ),
                Text(
                  'Robert Fox',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Notification bell
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF163527),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF2D6A4F).withAlpha(102),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0A1F14),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
