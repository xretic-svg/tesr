import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../core/app_state.dart';
import '../../widgets/app_navigation.dart';
import '../checkout_screen/checkout_screen.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final accentColor = appState.accentColor;
        final cartItems = appState.cartItems;

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          body: SafeArea(
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
                          appState.t('My Basket', 'سەبەتەکەم'),
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (cartItems.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: accentColor.withAlpha(128),
                            ),
                          ),
                          child: Text(
                            '${appState.cartCount} ${appState.t('items', 'دانە')}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: cartItems.isEmpty
                      ? _EmptyBasket(
                          accentColor: accentColor,
                          appState: appState,
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return _CartItemCard(
                              item: cartItems[index],
                              accentColor: accentColor,
                              appState: appState,
                            );
                          },
                        ),
                ),
                // Bottom total + checkout (above nav bar)
                if (cartItems.isNotEmpty)
                  _CheckoutBar(accentColor: accentColor, appState: appState),
              ],
            ),
          ),
          bottomNavigationBar: AppNavigation(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (r) => false,
                );
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

class _CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Color accentColor;
  final AppState appState;

  const _CartItemCard({
    required this.item,
    required this.accentColor,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = item['quantity'] as int;
    final price = item['price'] as double;
    final name = item['name'] as String;
    final brand = item['brand'] as String;
    final id = item['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF163527),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2D6A4F).withAlpha(77)),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CustomImageWidget(
              imageUrl: item['imageUrl'] as String,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              semanticLabel: item['semanticLabel'] as String? ?? name,
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  brand,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: const Color(0xFFA8C5B5),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${(price * quantity).toStringAsFixed(0)}',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Column(
            children: [
              // Remove button
              GestureDetector(
                onTap: () => appState.removeFromCart(id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC0392B).withAlpha(31),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFC0392B).withAlpha(77),
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFC0392B),
                    size: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Quantity row
              Row(
                children: [
                  _QtyButton(
                    icon: Icons.remove_rounded,
                    onTap: () => appState.updateCartQuantity(id, quantity - 1),
                    accentColor: accentColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '$quantity',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _QtyButton(
                    icon: Icons.add_rounded,
                    onTap: () => appState.updateCartQuantity(id, quantity + 1),
                    accentColor: accentColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: accentColor.withAlpha(51),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accentColor.withAlpha(128)),
        ),
        child: Icon(icon, color: accentColor, size: 14),
      ),
    );
  }
}

class _EmptyBasket extends StatelessWidget {
  final Color accentColor;
  final AppState appState;

  const _EmptyBasket({required this.accentColor, required this.appState});

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
              color: accentColor.withAlpha(31),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_basket_outlined,
              size: 44,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            appState.t('Your basket is empty', 'سەبەتەکەت بەتاڵە'),
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appState.t(
              'Add watches to get started',
              'کاتژمێر زیاد بکە بۆ دەستپێکردن',
            ),
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: const Color(0xFFA8C5B5),
            ),
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

class _CheckoutBar extends StatelessWidget {
  final Color accentColor;
  final AppState appState;

  const _CheckoutBar({required this.accentColor, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF163527),
        border: Border(
          top: BorderSide(color: const Color(0xFF2D6A4F).withAlpha(77)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appState.t('Total', 'کۆی گشتی'),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFA8C5B5),
                ),
              ),
              Text(
                '\$${appState.cartTotal.toStringAsFixed(0)}',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                appState.t('Proceed to Checkout', 'بڕۆ بۆ پارەدان'),
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
