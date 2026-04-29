import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../core/app_state.dart';
import '../../widgets/app_navigation.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final accentColor = appState.accentColor;
        final favourites = appState.favouriteWatches;

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF163527),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF2D6A4F).withAlpha(102),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          appState.t('Favourites', 'دڵخوازەکان'),
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (favourites.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withAlpha(31),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.red.withAlpha(102),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${favourites.length}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: favourites.isEmpty
                      ? _EmptyFavourites(
                          accentColor: accentColor,
                          appState: appState,
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.78,
                              ),
                          itemCount: favourites.length,
                          itemBuilder: (context, index) {
                            return _FavouriteCard(
                              watch: favourites[index],
                              accentColor: accentColor,
                              appState: appState,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: AppNavigation(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (r) => false,
                );
              } else if (index == 1) {
                Navigator.pushNamed(context, AppRoutes.basket);
              } else if (index == 3) {
                Navigator.pushNamed(context, AppRoutes.settings);
              }
            },
            accentColor: accentColor,
          ),
        );
      },
    );
  }
}

class _FavouriteCard extends StatelessWidget {
  final Map<String, dynamic> watch;
  final Color accentColor;
  final AppState appState;

  const _FavouriteCard({
    required this.watch,
    required this.accentColor,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final name = watch['name'] as String;
    final price = watch['price'] as double;
    final id = watch['id'] as String;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.productDetail,
        arguments: watch,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0E8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: CustomImageWidget(
                      imageUrl: watch['imageUrl'] as String,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      semanticLabel: watch['semanticLabel'] as String? ?? name,
                    ),
                  ),
                  // Heart button (filled, red)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => appState.toggleFavourite(id),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(38),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(0)}',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                        Text(
                          name,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4A7C59),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => appState.addToCart(watch),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 15,
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

class _EmptyFavourites extends StatelessWidget {
  final Color accentColor;
  final AppState appState;

  const _EmptyFavourites({required this.accentColor, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(31),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 44,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            appState.t('No favourites yet', 'هیچ دڵخوازێکت نییە'),
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appState.t(
              'Tap the heart icon on any watch',
              'ئایکۆنی دڵ لەسەر هەر کاتژمێرێک بپەڕێنە',
            ),
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: const Color(0xFFA8C5B5),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (r) => false,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            ),
            child: Text(
              appState.t('Browse Watches', 'گەڕان بۆ کاتژمێرەکان'),
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
