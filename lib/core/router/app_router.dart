import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/insights/presentation/screens/insights_screen.dart';
import '../../features/wellness/presentation/screens/wellness_screen.dart';
import '../../features/wellness/presentation/screens/breathe_screen.dart';
import '../../features/wellness/presentation/screens/quotes_screen.dart';
import '../../features/wellness/presentation/screens/gratitude_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/insights',
          name: 'insights',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: InsightsScreen(),
          ),
        ),
        GoRoute(
          path: '/wellness',
          name: 'wellness',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: WellnessScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
    // Full-screen routes (outside shell)
    GoRoute(
      path: '/breathe',
      name: 'breathe',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BreatheScreen(),
    ),
    GoRoute(
      path: '/quotes',
      name: 'quotes',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const QuotesScreen(),
    ),
    GoRoute(
      path: '/gratitude',
      name: 'gratitude',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const GratitudeScreen(),
    ),
  ],
);
