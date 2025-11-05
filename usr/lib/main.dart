import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/dashboard_screen.dart';
import 'screens/brand_generator/brand_input_screen.dart';
import 'screens/brand_generator/brand_results_screen.dart';
import 'screens/logo_generator/logo_generator_screen.dart';
import 'screens/content_generator/content_generator_screen.dart';
import 'screens/brand_kit/brand_kit_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/subscription/subscription_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/brand_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const BrandVaultApp());
}

class BrandVaultApp extends StatelessWidget {
  const BrandVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BrandProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'BrandVault',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF2196F3),
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.interTextTheme(),
              cardTheme: CardTheme(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              '/dashboard': (context) => const DashboardScreen(),
              '/brand-input': (context) => const BrandInputScreen(),
              '/brand-results': (context) => const BrandResultsScreen(),
              '/logo-generator': (context) => const LogoGeneratorScreen(),
              '/content-generator': (context) => const ContentGeneratorScreen(),
              '/brand-kit': (context) => const BrandKitScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/subscription': (context) => const SubscriptionScreen(),
            },
          );
        },
      ),
    );
  }
}
