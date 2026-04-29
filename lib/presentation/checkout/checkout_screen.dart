import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../core/app_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  int _selectedAddress = 0;
  bool _isPlacingOrder = false;

  final List<Map<String, String>> _addresses = [
    {
      'name': 'Robert Fox',
      'address': '2972 Westheimer Rd.',
      'city': 'Santa Ana, Illinois 85486',
    },
    {
      'name': 'Robert Fox',
      'address': '1901 Thornridge Cir.',
      'city': 'Shiloh, Hawaii 81063',
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'card',
      'label': 'Visa',
      'detail': '**** **** **** 4242',
      'icon': Icons.credit_card_rounded,
    },
    {
      'type': 'card',
      'label': 'Mastercard',
      'detail': '**** **** **** 8888',
      'icon': Icons.credit_card_rounded,
    },
    {
      'type': 'cash',
      'label': 'Cash on Delivery',
      'detail': 'Pay when delivered',
      'icon': Icons.payments_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final accentColor = appState.accentColor;
        final cartItems = appState.cartItems;
        final subtotal = appState.cartTotal;
        const shipping = 15.0;
        final total = subtotal + shipping;

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
                      Text(
                        appState.t('Checkout', 'پارەدان'),
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order Summary
                        _SectionTitle(
                          title: appState.t('Order Summary', 'پوختەی داواکاری'),
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF163527),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2D6A4F).withAlpha(77),
                            ),
                          ),
                          child: Column(
                            children: [
                              ...cartItems.asMap().entries.map((entry) {
                                final i = entry.key;
                                final item = entry.value;
                                final isLast = i == cartItems.length - 1;
                                return _OrderItem(
                                  item: item,
                                  accentColor: accentColor,
                                  isLast: isLast,
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Delivery Address
                        _SectionTitle(
                          title: appState.t(
                            'Delivery Address',
                            'ناونیشانی گەیاندن',
                          ),
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        ..._addresses.asMap().entries.map((entry) {
                          final i = entry.key;
                          final addr = entry.value;
                          return _AddressCard(
                            address: addr,
                            isSelected: _selectedAddress == i,
                            accentColor: accentColor,
                            onTap: () => setState(() => _selectedAddress = i),
                          );
                        }),
                        const SizedBox(height: 20),
                        // Payment Method
                        _SectionTitle(
                          title: appState.t('Payment Method', 'شێوازی پارەدان'),
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        ..._paymentMethods.asMap().entries.map((entry) {
                          final i = entry.key;
                          final method = entry.value;
                          return _PaymentCard(
                            method: method,
                            isSelected: _selectedPayment == i,
                            accentColor: accentColor,
                            onTap: () => setState(() => _selectedPayment = i),
                            appState: appState,
                          );
                        }),
                        const SizedBox(height: 20),
                        // Price Breakdown
                        _SectionTitle(
                          title: appState.t('Price Details', 'وردەکاری نرخ'),
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF163527),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2D6A4F).withAlpha(77),
                            ),
                          ),
                          child: Column(
                            children: [
                              _PriceRow(
                                label: appState.t(
                                  'Subtotal',
                                  'کۆی بەرپێش داشکاندن',
                                ),
                                value: '\$${subtotal.toStringAsFixed(0)}',
                                accentColor: accentColor,
                              ),
                              const SizedBox(height: 10),
                              _PriceRow(
                                label: appState.t('Shipping', 'کرێی گەیاندن'),
                                value: '\$${shipping.toStringAsFixed(0)}',
                                accentColor: accentColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Divider(
                                  color: const Color(0xFF2D6A4F).withAlpha(77),
                                  height: 1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    appState.t('Total', 'کۆی گشتی'),
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '\$${total.toStringAsFixed(0)}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Place Order Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isPlacingOrder
                                ? null
                                : () => _placeOrder(
                                    context,
                                    appState,
                                    accentColor,
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              disabledBackgroundColor: accentColor.withAlpha(
                                128,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isPlacingOrder
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    appState.t(
                                      'Place Order',
                                      'داواکاری تۆمار بکە',
                                    ),
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _placeOrder(
    BuildContext context,
    AppState appState,
    Color accentColor,
  ) async {
    setState(() => _isPlacingOrder = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isPlacingOrder = false);

    // Clear cart
    for (final item in List.from(appState.cartItems)) {
      appState.removeFromCart(item['id'] as String);
    }

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF163527),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: accentColor.withAlpha(31),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: accentColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              appState.t('Order Placed!', 'داواکاری تۆمارکرا!'),
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              appState.t(
                'Your order has been placed successfully. We\'ll notify you when it ships.',
                'داواکارییەکەت بەسەرکەوتوویی تۆمارکرا. ئاگادارت دەکەینەوە کاتێک دەنێردرێت.',
              ),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: const Color(0xFFA8C5B5),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (r) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  appState.t('Back to Home', 'گەڕانەوە بۆ ماڵەوە'),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color accentColor;

  const _SectionTitle({required this.title, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final Color accentColor;
  final bool isLast;

  const _OrderItem({
    required this.item,
    required this.accentColor,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final name = item['name'] as String;
    final brand = item['brand'] as String;
    final price = item['price'] as double;
    final qty = item['quantity'] as int;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: const Color(0xFF2D6A4F).withAlpha(77),
                ),
              ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomImageWidget(
              imageUrl: item['imageUrl'] as String,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              semanticLabel: item['semanticLabel'] as String? ?? name,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  brand,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
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
                '\$${(price * qty).toStringAsFixed(0)}',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
              Text(
                'x$qty',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: const Color(0xFFA8C5B5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Map<String, String> address;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _AddressCard({
    required this.address,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withAlpha(26)
              : const Color(0xFF163527),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? accentColor
                : const Color(0xFF2D6A4F).withAlpha(77),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? accentColor : const Color(0xFF4A7C59),
                  width: 2,
                ),
                color: isSelected ? accentColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['name']!,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${address['address']}, ${address['city']}',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: const Color(0xFFA8C5B5),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.location_on_rounded,
              color: isSelected ? accentColor : const Color(0xFF4A7C59),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final Map<String, dynamic> method;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;
  final AppState appState;

  const _PaymentCard({
    required this.method,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final isCash = method['type'] == 'cash';
    final label = method['label'] as String;
    final detail = method['detail'] as String;
    final icon = method['icon'] as IconData;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withAlpha(26)
              : const Color(0xFF163527),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? accentColor
                : const Color(0xFF2D6A4F).withAlpha(77),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? accentColor : const Color(0xFF4A7C59),
                  width: 2,
                ),
                color: isSelected ? accentColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCash
                    ? const Color(0xFFD4A017).withAlpha(31)
                    : accentColor.withAlpha(31),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isCash ? const Color(0xFFD4A017) : accentColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCash
                        ? appState.t('Cash on Delivery', 'پارەدان لە گەیاندن')
                        : label,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isCash
                        ? appState.t(
                            'Pay when delivered',
                            'پارەبدە کاتێک گەیشت',
                          )
                        : detail,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: const Color(0xFFA8C5B5),
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

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _PriceRow({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: const Color(0xFFA8C5B5),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
