import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/constants/app_strings.dart';
import 'hive_registrar.g.dart';

// Import models for Hive boxes
import 'features/home/data/models/mood_entry_model.dart';
import 'features/home/data/models/activity_entry_model.dart';
import 'features/wellness/data/models/quote_model.dart';
import 'features/wellness/data/models/gratitude_entry_model.dart';
import 'features/wellness/data/models/sound_model.dart';
import 'features/settings/data/models/user_settings_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapters();

  // Open Hive boxes
  await Future.wait([
    Hive.openBox<MoodEntryModel>('moods'),
    Hive.openBox<ActivityEntryModel>('activities'),
    Hive.openBox<QuoteModel>('quotes'),
    Hive.openBox<GratitudeEntryModel>('gratitude'),
    Hive.openBox<SoundModel>('sounds'),
    Hive.openBox<UserSettingsModel>('settings'),
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF151A19),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const ProviderScope(child: MoodHolderApp()));
}

class MoodHolderApp extends StatelessWidget {
  const MoodHolderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
