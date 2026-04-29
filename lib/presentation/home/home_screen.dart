import '../../core/app_export.dart';
import '../../core/app_state.dart';
import '../../widgets/app_navigation.dart';
import './widgets/home_banner_widget.dart';
import './widgets/home_category_filter_widget.dart';
import './widgets/home_header_widget.dart';
import './widgets/home_product_grid_widget.dart';
import './widgets/home_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  String _searchQuery = '';

  final List<String> _categoryKeys = ['All', 'Man', 'Woman', 'Child'];

  List<String> _localizedCategories(AppState appState) => [
    appState.t('All', 'هەمووی'),
    appState.t('Man', 'پیاو'),
    appState.t('Woman', 'ژن'),
    appState.t('Child', 'منداڵ'),
  ];

  List<Map<String, dynamic>> _filteredWatches(AppState appState) {
    return appState.allWatches.where((w) {
      final matchesCategory =
          _selectedCategory == 0 ||
          w['category'] == _categoryKeys[_selectedCategory];
      final matchesSearch =
          _searchQuery.isEmpty ||
          (w['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (w['brand'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _onNavTap(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.basket);
    } else if (index == 2) {
      Navigator.pushNamed(context, AppRoutes.favourites);
    } else if (index == 3) {
      Navigator.pushNamed(context, AppRoutes.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final accentColor = appState.accentColor;

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                HomeHeaderWidget(accentColor: accentColor),
                HomeSearchWidget(
                  onChanged: (q) => setState(() => _searchQuery = q),
                  accentColor: accentColor,
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomeBannerWidget(accentColor: accentColor),
                      ),
                      SliverToBoxAdapter(
                        child: HomeCategoryFilterWidget(
                          categories: _localizedCategories(appState),
                          selectedIndex: _selectedCategory,
                          accentColor: accentColor,
                          onSelect: (i) =>
                              setState(() => _selectedCategory = i),
                        ),
                      ),
                      HomeProductGridWidget(
                        watches: _filteredWatches(appState),
                        isTablet: isTablet,
                        accentColor: accentColor,
                        onToggleFavorite: (id) => appState.toggleFavourite(id),
                        onAddToCart: (watch) => appState.addToCart(watch),
                        favouriteIds: appState.favouriteIds,
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: AppNavigation(
            currentIndex: 0,
            onTap: _onNavTap,
            accentColor: accentColor,
          ),
        );
      },
    );
  }
}
