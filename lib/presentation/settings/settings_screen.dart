import '../../core/app_export.dart';
import '../../core/app_state.dart';
import '../../widgets/app_navigation.dart';
import './widgets/settings_accent_color_widget.dart';
import './widgets/settings_credentials_widget.dart';
import './widgets/settings_language_widget.dart';
import './widgets/settings_menu_items_widget.dart';
import './widgets/settings_profile_header_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, _) {
        final appState = AppState();
        final accentColor = appState.accentColor;
        final isKurdish = appState.isKurdish;
        final size = MediaQuery.of(context).size;
        final isTablet = size.width >= 600;
        final maxWidth = isTablet ? 600.0 : double.infinity;

        return Scaffold(
          backgroundColor: const Color(0xFF0A1F14),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.home,
                          (route) => false,
                        ),
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
                        appState.t('Settings', 'ڕێکخستنەکان'),
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? (size.width - maxWidth) / 2 : 0,
                    ),
                    child: Column(
                      children: [
                        SettingsProfileHeaderWidget(
                          accentColor: accentColor,
                          isKurdish: isKurdish,
                        ),
                        const SizedBox(height: 16),
                        SettingsAccentColorWidget(
                          accentOptions: {
                            'green': AppTheme.accentGreen,
                            'blue': const Color(0xFF2196F3),
                            'purple': const Color(0xFF9C27B0),
                            'red': const Color(0xFFE53935),
                            'brown': const Color(0xFF795548),
                          },
                          selectedColor: accentColor,
                          onChanged: (color) => appState.setAccentColor(color),
                          isKurdish: isKurdish,
                        ),
                        const SizedBox(height: 12),
                        SettingsLanguageWidget(
                          isKurdish: isKurdish,
                          onToggle: (val) => appState.setLanguage(val),
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        SettingsCredentialsWidget(
                          accentColor: accentColor,
                          isKurdish: isKurdish,
                        ),
                        const SizedBox(height: 12),
                        SettingsMenuItemsWidget(
                          accentColor: accentColor,
                          isKurdish: isKurdish,
                        ),
                        const SizedBox(height: 12),
                        // Logout
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: const Color(0xFF163527),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Text(
                                    appState.t('Logout', 'دەرچوون'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  content: Text(
                                    appState.t(
                                      'Are you sure you want to logout?',
                                      'دڵنیایت دەتەوێت دەربچیت؟',
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFFA8C5B5),
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        appState.t('Cancel', 'پاشگەزبوونەوە'),
                                        style: TextStyle(
                                          color: accentColor,
                                          fontFamily: 'Outfit',
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.splashOnboarding,
                                          (route) => false,
                                        );
                                      },
                                      child: Text(
                                        appState.t('Logout', 'دەرچوون'),
                                        style: const TextStyle(
                                          color: Color(0xFFC0392B),
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC0392B).withAlpha(31),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFC0392B).withAlpha(102),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.logout_rounded,
                                    color: Color(0xFFC0392B),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    appState.t('Logout', 'دەرچوون'),
                                    style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFC0392B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: AppNavigation(
            currentIndex: 3,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              } else if (index == 1) {
                Navigator.pushNamed(context, AppRoutes.basket);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.favourites);
              }
            },
            accentColor: accentColor,
          ),
        );
      },
    );
  }
}
