import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../core/app_state.dart';
import '../../widgets/app_navigation.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _addedToCart = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    final watch =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};
    if (watch.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A1F14),
        body: Center(
          child: Text('Watch not found', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final accentColor = appState.accentColor;
        final isFav = appState.isFavourite(watch['id'] as String);
        final inCart = appState.isInCart(watch['id'] as String);
        final price = watch['price'] as double;
        final name = watch['name'] as String;
        final brand = watch['brand'] as String;
        final description =
            watch['description'] as String? ??
            'A premium timepiece crafted with exceptional precision and luxury materials.';

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          extendBody: true,
          body: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Hero image app bar
                  SliverAppBar(
                    expandedHeight: 42.h,
                    pinned: true,
                    backgroundColor: const Color(0xFF0A1F14),
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF163527).withAlpha(230),
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
                    actions: [
                      GestureDetector(
                        onTap: () =>
                            appState.toggleFavourite(watch['id'] as String),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isFav
                                ? Colors.red.withAlpha(51)
                                : const Color(0xFF163527).withAlpha(230),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isFav
                                  ? Colors.red.withAlpha(128)
                                  : const Color(0xFF2D6A4F).withAlpha(102),
                            ),
                          ),
                          child: Icon(
                            isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFav ? Colors.red : Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomImageWidget(
                            imageUrl: watch['imageUrl'] as String,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            semanticLabel:
                                watch['semanticLabel'] as String? ?? name,
                          ),
                          // Gradient overlay
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF0A1F14).withAlpha(200),
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                          // Brand badge
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color(
                                  watch['badgeColor'] as int? ?? 0xFF1B4332,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                brand,
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
                  ),
                  // Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name & Price row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: GoogleFonts.outfit(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      brand,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFA8C5B5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(0)}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    appState.t('per piece', 'بۆ هەر دانەیەک'),
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      color: const Color(0xFFA8C5B5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Rating row
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  i < 4
                                      ? Icons.star_rounded
                                      : Icons.star_half_rounded,
                                  color: const Color(0xFFD4A017),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '4.8',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '(128 ${appState.t('reviews', 'پێداچوونەوە')})',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFFA8C5B5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Divider
                          Divider(color: const Color(0xFF2D6A4F).withAlpha(77)),
                          const SizedBox(height: 20),
                          // Description
                          Text(
                            appState.t('Description', 'وەسف'),
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              height: 1.6,
                              color: const Color(0xFFA8C5B5),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Specs row
                          _SpecsRow(
                            accentColor: accentColor,
                            appState: appState,
                          ),
                          const SizedBox(height: 32),
                          // Add to cart button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                appState.addToCart(watch);
                                setState(() => _addedToCart = true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      appState.t(
                                        'Added to basket!',
                                        'زیادکرا بۆ سەبەتە!',
                                      ),
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: accentColor,
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: inCart
                                    ? accentColor.withAlpha(180)
                                    : accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    inCart
                                        ? Icons.shopping_basket_rounded
                                        : Icons.add_shopping_cart_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    inCart
                                        ? appState.t(
                                            'Add More to Basket',
                                            'زیادکردنی زیاتر',
                                          )
                                        : appState.t(
                                            'Add to Basket',
                                            'زیادکردن بۆ سەبەتە',
                                          ),
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppNavigation(
            currentIndex: 0,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (r) => false,
                );
              } else if (index == 1) {
                Navigator.pushNamed(context, AppRoutes.basket);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.favourites);
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

class _SpecsRow extends StatelessWidget {
  final Color accentColor;
  final AppState appState;

  const _SpecsRow({required this.accentColor, required this.appState});

  @override
  Widget build(BuildContext context) {
    final specs = [
      {
        'icon': Icons.water_drop_rounded,
        'label': appState.t('Water Resist.', 'ئاوبەند'),
        'value': '300m',
      },
      {
        'icon': Icons.settings_rounded,
        'label': appState.t('Movement', 'جووڵان'),
        'value': 'Auto',
      },
      {
        'icon': Icons.circle_outlined,
        'label': appState.t('Case Size', 'قەبارە'),
        'value': '41mm',
      },
    ];

    return Row(
      children: specs.map((spec) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF163527),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2D6A4F).withAlpha(77)),
            ),
            child: Column(
              children: [
                Icon(spec['icon'] as IconData, color: accentColor, size: 20),
                const SizedBox(height: 6),
                Text(
                  spec['value'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  spec['label'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: const Color(0xFFA8C5B5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
