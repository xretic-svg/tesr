import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../core/app_state.dart';

class HomeBannerWidget extends StatelessWidget {
  final Color accentColor;

  const HomeBannerWidget({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF1B4332), Color(0xFF0F2D1F)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withAlpha(20),
                ),
              ),
            ),
            // Watch image on right
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(20),
                ),
                child: CustomImageWidget(
                  imageUrl:
                      'https://images.pexels.com/photos/1697214/pexels-photo-1697214.jpeg',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  semanticLabel:
                      'Luxury green dial watch with leather strap promotional banner image',
                ),
              ),
            ),
            // Gradient overlay on image
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 160,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(20),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF1B4332), Colors.transparent],
                  ),
                ),
              ),
            ),
            // Text content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appState.t(
                      'Luxury Watches,\nDiscounted\nPrices',
                      'کاتژمێری لوکس،\nنرخی\nداشکاندراو',
                    ),
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appState.t('Buy Now', 'ئێستا بکڕە'),
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
