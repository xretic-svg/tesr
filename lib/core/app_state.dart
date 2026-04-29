import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // Accent color
  Color _accentColor = AppTheme.accentGreen;
  Color get accentColor => _accentColor;

  // Language
  bool _isKurdish = false;
  bool get isKurdish => _isKurdish;

  // Cart items: list of watch maps
  final List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  // Favourites: set of watch ids
  final Set<String> _favouriteIds = {};
  Set<String> get favouriteIds => Set.unmodifiable(_favouriteIds);

  // All watches data (shared source of truth)
  final List<Map<String, dynamic>> _allWatches = [
    {
      'id': '1',
      'name': 'Submariner',
      'brand': 'Rolex',
      'price': 299.0,
      'category': 'Man',
      'imageUrl':
          'https://images.unsplash.com/photo-1526383226452-9fc7021264be',
      'semanticLabel':
          'Rolex Submariner with black dial and stainless steel bracelet on cream background',
      'badgeColor': 0xFF1B4332,
      'description':
          'The Rolex Submariner is the reference among divers\' watches. Water-resistant to 300 metres, it features a unidirectional rotatable bezel with a 60-minute graduated Cerachrom insert in ceramic.',
    },
    {
      'id': '2',
      'name': 'Sea-Dweller',
      'brand': 'Rolex',
      'price': 299.0,
      'category': 'Man',
      'imageUrl':
          'https://images.unsplash.com/photo-1698801426428-e307a3cf53ed',
      'semanticLabel':
          'Rolex Sea-Dweller with green dial and jubilee bracelet on light background',
      'badgeColor': 0xFF1B4332,
      'description':
          'The Rolex Sea-Dweller is a professional diving watch with a helium escape valve, water-resistant to 1,220 metres. Its Oyster case houses the Calibre 3235 movement.',
    },
    {
      'id': '3',
      'name': 'Datejust 36',
      'brand': 'Rolex',
      'price': 399.0,
      'category': 'Woman',
      'imageUrl':
          'https://images.unsplash.com/photo-1600003014755-ba31aa59c4b6',
      'semanticLabel':
          'Rolex Datejust 36 with silver dial and diamond bezel on white surface',
      'badgeColor': 0xFF4A2C17,
      'description':
          'The Rolex Datejust 36 is the archetype of the classic watch. Its timeless design, with the iconic date window at 3 o\'clock, is complemented by a diamond-set bezel.',
    },
    {
      'id': '4',
      'name': 'Milgauss',
      'brand': 'Rolex',
      'price': 349.0,
      'category': 'Man',
      'imageUrl':
          'https://images.unsplash.com/photo-1730757679771-b53e798846cf',
      'semanticLabel':
          'Rolex Milgauss with blue dial and anti-magnetic case on dark background',
      'badgeColor': 0xFF1A5276,
      'description':
          'The Rolex Milgauss was designed for scientists and engineers working in environments with strong magnetic fields. It can withstand magnetic fields of up to 1,000 gauss.',
    },
    {
      'id': '5',
      'name': 'Lady-Datejust',
      'brand': 'Rolex',
      'price': 449.0,
      'category': 'Woman',
      'imageUrl':
          'https://images.unsplash.com/photo-1600003014755-ba31aa59c4b6',
      'semanticLabel':
          'Rolex Lady-Datejust with pink dial and diamond hour markers on cream background',
      'badgeColor': 0xFF4A235A,
      'description':
          'The Rolex Lady-Datejust is the quintessential women\'s watch. Elegant and refined, it features a 28mm Oyster case with a fluted bezel and a diamond-set dial.',
    },
    {
      'id': '6',
      'name': 'Oyster Perpetual',
      'brand': 'Rolex',
      'price': 199.0,
      'category': 'Child',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_12c50d80e-1777418796488.png',
      'semanticLabel':
          'Rolex Oyster Perpetual with turquoise dial in compact size for youth',
      'badgeColor': 0xFF1B4332,
      'description':
          'The Rolex Oyster Perpetual is the purest expression of the Oyster concept. A watch of essential values, it features a 41mm Oyster case and a self-winding mechanical movement.',
    },
    {
      'id': '7',
      'name': 'Explorer II',
      'brand': 'Rolex',
      'price': 379.0,
      'category': 'Man',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_130ab6d62-1768695193352.png',
      'semanticLabel':
          'Rolex Explorer II with white dial and orange GMT hand on Oystersteel bracelet',
      'badgeColor': 0xFF7B241C,
      'description':
          'The Rolex Explorer II was designed for cavers, polar explorers and volcanologists. It features a fixed 24-hour graduated bezel and a large orange hand to distinguish day from night.',
    },
    {
      'id': '8',
      'name': 'GMT-Master II',
      'brand': 'Rolex',
      'price': 499.0,
      'category': 'Man',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_104326b53-1772225240167.png',
      'semanticLabel':
          'Rolex GMT-Master II with Pepsi bezel in red and blue on jubilee bracelet',
      'badgeColor': 0xFF1B4332,
      'description':
          'The Rolex GMT-Master II was designed to meet the needs of professional travellers. It displays two time zones simultaneously thanks to its bidirectional rotatable bezel with a 24-hour graduated Cerachrom insert.',
    },
  ];

  List<Map<String, dynamic>> get allWatches => List.unmodifiable(_allWatches);

  // Initialise from SharedPreferences
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isKurdish = prefs.getBool('isKurdish') ?? false;
    final colorValue =
        prefs.getInt('accentColor') ?? AppTheme.accentGreen.value;
    _accentColor = Color(colorValue);
    final favIds = prefs.getStringList('favouriteIds') ?? [];
    _favouriteIds.addAll(favIds);
    notifyListeners();
  }

  // Accent color
  Future<void> setAccentColor(Color color) async {
    _accentColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentColor', color.value);
  }

  // Language
  Future<void> setLanguage(bool isKurdish) async {
    _isKurdish = isKurdish;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isKurdish', isKurdish);
  }

  // Favourites
  bool isFavourite(String id) => _favouriteIds.contains(id);

  Future<void> toggleFavourite(String id) async {
    if (_favouriteIds.contains(id)) {
      _favouriteIds.remove(id);
    } else {
      _favouriteIds.add(id);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favouriteIds', _favouriteIds.toList());
  }

  List<Map<String, dynamic>> get favouriteWatches => _allWatches
      .where((w) => _favouriteIds.contains(w['id'] as String))
      .toList();

  // Cart
  bool isInCart(String id) => _cartItems.any((w) => w['id'] == id);

  void addToCart(Map<String, dynamic> watch) {
    if (!isInCart(watch['id'] as String)) {
      _cartItems.add({...watch, 'quantity': 1});
    } else {
      final idx = _cartItems.indexWhere((w) => w['id'] == watch['id']);
      if (idx != -1) {
        _cartItems[idx] = {
          ..._cartItems[idx],
          'quantity': (_cartItems[idx]['quantity'] as int) + 1,
        };
      }
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((w) => w['id'] == id);
    notifyListeners();
  }

  void updateCartQuantity(String id, int quantity) {
    if (quantity <= 0) {
      removeFromCart(id);
      return;
    }
    final idx = _cartItems.indexWhere((w) => w['id'] == id);
    if (idx != -1) {
      _cartItems[idx] = {..._cartItems[idx], 'quantity': quantity};
      notifyListeners();
    }
  }

  double get cartTotal => _cartItems.fold(
    0.0,
    (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
  );

  int get cartCount =>
      _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  String t(String en, String ku) => _isKurdish ? ku : en;
}
