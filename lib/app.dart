import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/onboarding_screen.dart';
import 'providers/app_state.dart';
import 'shared/widgets/app_shell.dart';

class LockedInApp extends StatelessWidget {
  const LockedInApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'LOCKED IN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF101412),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF16C784),
            brightness: Brightness.dark,
          ).copyWith(
            primary: const Color(0xFF16C784),
            secondary: const Color(0xFFE8B949),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF18201C),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF18201C),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        home: Consumer<AppState>(
          builder: (context, state, _) {
            if (!state.isReady) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (state.profile == null) return const OnboardingScreen();
            return const AppShell();
          },
        ),
      );
}
