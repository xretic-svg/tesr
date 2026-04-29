import '../../core/app_export.dart';
import '../../core/app_state.dart';
import './widgets/morph_blob_widget.dart';
import './widgets/onboarding_content_widget.dart';

class SplashOnboardingScreen extends StatefulWidget {
  const SplashOnboardingScreen({super.key});

  @override
  State<SplashOnboardingScreen> createState() => _SplashOnboardingScreenState();
}

class _SplashOnboardingScreenState extends State<SplashOnboardingScreen>
    with TickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  late AnimationController _blobController;
  late AnimationController _contentController;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;
  int _currentPage = 0;

  List<Map<String, String>> _pages(AppState appState) => [
    {
      'image': 'https://images.unsplash.com/photo-1584208124193-df98a65afaf6',
      'semanticLabel':
          'Elegant man in white shirt showcasing a luxury green dial watch on his wrist',
      'title': appState.t(
        'Discover Luxury\nTop Brands Watch',
        'کەشف بکە لوکس\nکاتژمێری براندە سەرەکیەکان',
      ),
      'subtitle': appState.t(
        'Explore an exclusive collection of classic luxury and smart watches all in one place',
        'کۆمەڵەیەکی تایبەت لە کاتژمێری کلاسیکی لوکس و زیرەک لە یەک شوێندا بگەڕێ',
      ),
    },
    {
      'image':
          'https://images.unsplash.com/photo-1641217206315-a834ded02991',
      'semanticLabel':
          'Close-up of a premium gold and silver luxury wristwatch on dark background',
      'title': appState.t(
        'Timeless Elegance\nFor Every Occasion',
        'جوانی بێ کاتی\nبۆ هەر بۆنەیەک',
      ),
      'subtitle': appState.t(
        'Curated timepieces from the world\'s most prestigious watchmakers delivered to you',
        'کاتژمێرە هەڵبژێردراوەکان لە بەناوبانگترین کاتژمێرسازانی جیهان دەگەنە بەردەستت',
      ),
    },
    {
      'image': 'https://images.unsplash.com/photo-1634567735936-cdc24efc709e',
      'semanticLabel':
          'Luxury chronograph watch with green dial and leather strap on wooden surface',
      'title': appState.t(
        'Wear Your\nDistinction',
        'جلی\nتایبەتمەندییەکەت بپۆش',
      ),
      'subtitle': appState.t(
        'From Rolex to Patek Philippe — find your perfect statement piece with LuxWatch',
        'لە رۆلێکس تا پاتێک فیلیپ — پارچەی کامڵی خۆت بدۆزەرەوە لەگەڵ لوکس واچ',
      ),
    },
  ];

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _contentFade = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    );

    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _contentController,
            curve: Curves.easeOutCubic,
          ),
        );

    _contentController.forward();
  }

  @override
  void dispose() {
    _blobController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (index < 0 || index >= _pages(AppState()).length) return;
    _contentController.reverse().then((_) {
      setState(() {
        _currentPage = index;
      });
      _contentController.forward();
    });
  }

  void _getStarted() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final pages = _pages(appState);

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          body: Stack(
            children: [
              // Full-screen hero image
              Positioned.fill(
                child: CustomImageWidget(
                  imageUrl: pages[_currentPage]['image']!,
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  semanticLabel: pages[_currentPage]['semanticLabel'] ?? '',
                ),
              ),
              // Dark gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF0A1F14).withAlpha(102),
                        const Color(0xFF0A1F14).withAlpha(217),
                        const Color(0xFF0A1F14),
                      ],
                      stops: const [0.0, 0.35, 0.6, 0.78],
                    ),
                  ),
                ),
              ),
              // Animated blobs
              MorphBlobWidget(controller: _blobController),
              // Content
              SafeArea(
                child: Column(
                  children: [
                    const Spacer(),
                    FadeTransition(
                      opacity: _contentFade,
                      child: SlideTransition(
                        position: _contentSlide,
                        child: OnboardingContentWidget(
                          title: pages[_currentPage]['title']!,
                          subtitle: pages[_currentPage]['subtitle']!,
                          currentPage: _currentPage,
                          totalPages: pages.length,
                          isTablet: isTablet,
                          onPrev: () => _goToPage(_currentPage - 1),
                          onNext: () => _goToPage(_currentPage + 1),
                          onGetStarted: _getStarted,
                          getStartedLabel: appState.t(
                            'Get Started',
                            'دەستپێبکە',
                          ),
                          accentColor: appState.accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
