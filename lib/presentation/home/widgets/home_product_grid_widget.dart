import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../core/app_state.dart';

class HomeProductGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> watches;
  final bool isTablet;
  final Color accentColor;
  final Function(String) onToggleFavorite;
  final Function(Map<String, dynamic>) onAddToCart;
  final Set<String> favouriteIds;

  const HomeProductGridWidget({
    super.key,
    required this.watches,
    required this.isTablet,
    required this.accentColor,
    required this.onToggleFavorite,
    required this.onAddToCart,
    required this.favouriteIds,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    if (watches.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.watch_off_rounded,
                size: 64,
                color: const Color(0xFF4A7C59),
              ),
              const SizedBox(height: 16),
              Text(
                appState.t('No watches found', 'کاتژمێر نەدۆزرایەوە'),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                appState.t(
                  'Try a different category or search term',
                  'پۆلێنی تر یان وشەی گەڕانی تر تاقی بکەرەوە',
                ),
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: const Color(0xFFA8C5B5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final crossAxisCount = isTablet ? 3 : 2;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final watch = watches[index];
          final isFav = favouriteIds.contains(watch['id'] as String);
          return _ProductCard(
            watch: watch,
            accentColor: accentColor,
            isFav: isFav,
            onToggleFavorite: onToggleFavorite,
            onAddToCart: onAddToCart,
            animationIndex: index,
          );
        }, childCount: watches.length),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Map<String, dynamic> watch;
  final Color accentColor;
  final bool isFav;
  final Function(String) onToggleFavorite;
  final Function(Map<String, dynamic>) onAddToCart;
  final int animationIndex;

  const _ProductCard({
    required this.watch,
    required this.accentColor,
    required this.isFav,
    required this.onToggleFavorite,
    required this.onAddToCart,
    required this.animationIndex,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    Future.delayed(
      Duration(milliseconds: 60 * widget.animationIndex.clamp(0, 6)),
      () {
        if (mounted) _entranceController.forward();
      },
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.watch['price'] as double;
    final name = widget.watch['name'] as String;
    final id = widget.watch['id'] as String;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.productDetail,
            arguments: widget.watch,
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
                // Image area
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: CustomImageWidget(
                          imageUrl: widget.watch['imageUrl'] as String,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          semanticLabel:
                              widget.watch['semanticLabel'] as String,
                        ),
                      ),
                      // Heart button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => widget.onToggleFavorite(id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: widget.isFav
                                  ? Colors.red.withAlpha(38)
                                  : Colors.white.withAlpha(217),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(26),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.isFav
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: widget.isFav
                                  ? Colors.red
                                  : const Color(0xFF666666),
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Info row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
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
                                color: widget.accentColor,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
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
                      // Cart button
                      GestureDetector(
                        onTap: () => widget.onAddToCart(widget.watch),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: widget.accentColor,
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
        ),
      ),
    );
  }
}
