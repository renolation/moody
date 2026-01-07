# Implementation Tasks: Mood Holder App

## 1. Project Setup & Dependencies

- [ ] 1.1 Update `pubspec.yaml` with required dependencies:
  - flutter_riverpod, riverpod_annotation, riverpod_generator
  - hive, hive_flutter
  - fl_chart
  - go_router
  - build_runner, riverpod_lint (dev)
- [ ] 1.2 Run `flutter pub get` to install dependencies
- [ ] 1.3 Create feature-first folder structure under `lib/`
- [ ] 1.4 Configure `build.yaml` for Riverpod code generation

## 2. Core Infrastructure

- [ ] 2.1 Create `lib/core/constants/` with app colors, dimensions, strings
- [ ] 2.2 Create `lib/core/enums/` with MoodScore, ActivityType, SubscriptionTier
- [ ] 2.3 Create `lib/core/theme/` with AppPalette and ThemeData configuration
- [ ] 2.4 Create `lib/core/widgets/glass_panel.dart` reusable glassmorphism container
- [ ] 2.5 Create `lib/core/router/app_router.dart` with GoRouter configuration
- [ ] 2.6 Set up Hive initialization in `main.dart` with type adapters
- [ ] 2.7 Wrap app with ProviderScope for Riverpod
- [ ] 2.8 Create AppShell widget with bottom navigation bar
- [ ] 2.9 Run `dart run build_runner build` and verify code generation works

## 3. Home Feature

- [ ] 3.1 Create `lib/features/home/domain/entities/mood_entry.dart`
- [ ] 3.2 Create `lib/features/home/domain/entities/activity_entry.dart`
- [ ] 3.3 Create `lib/features/home/data/models/` Hive models with adapters
- [ ] 3.4 Create `lib/features/home/data/repositories/mood_repository.dart`
- [ ] 3.5 Create `lib/features/home/data/repositories/activity_repository.dart`
- [ ] 3.6 Create `lib/features/home/presentation/providers/home_provider.dart` (@riverpod)
- [ ] 3.7 Create `lib/features/home/presentation/widgets/greeting_header.dart`
- [ ] 3.8 Create `lib/features/home/presentation/widgets/daily_inspiration_card.dart`
- [ ] 3.9 Create `lib/features/home/presentation/widgets/mood_selector.dart` with 5 emojis
- [ ] 3.10 Create `lib/features/home/presentation/widgets/quick_log_bar.dart`
- [ ] 3.11 Create `lib/features/home/presentation/widgets/journey_timeline.dart`
- [ ] 3.12 Create `lib/features/home/presentation/screens/home_screen.dart`
- [ ] 3.13 Add haptic feedback to mood selection and quick log buttons
- [ ] 3.14 Test mood logging flow end-to-end

## 4. Insights Feature

- [ ] 4.1 Create `lib/features/insights/domain/entities/mood_stats.dart`
- [ ] 4.2 Create `lib/features/insights/data/repositories/stats_repository.dart`
- [ ] 4.3 Create `lib/features/insights/presentation/providers/insights_provider.dart` (@riverpod)
- [ ] 4.4 Create `lib/features/insights/presentation/widgets/insights_header.dart`
- [ ] 4.5 Create `lib/features/insights/presentation/widgets/mood_heatmap.dart` calendar grid
- [ ] 4.6 Create `lib/features/insights/presentation/widgets/correlation_chart.dart` using fl_chart
- [ ] 4.7 Create `lib/features/insights/presentation/widgets/key_insight_card.dart`
- [ ] 4.8 Create `lib/features/insights/presentation/widgets/vip_overlay.dart` for gating
- [ ] 4.9 Create `lib/features/insights/presentation/screens/insights_screen.dart`
- [ ] 4.10 Test heatmap with sample data
- [ ] 4.11 Test correlation chart with sample data

## 5. Wellness Feature

- [ ] 5.1 Create `lib/features/wellness/domain/entities/quote.dart`
- [ ] 5.2 Create `lib/features/wellness/domain/entities/gratitude_entry.dart`
- [ ] 5.3 Create `lib/features/wellness/domain/entities/sound.dart`
- [ ] 5.4 Create `lib/features/wellness/data/models/` Hive models
- [ ] 5.5 Create `lib/features/wellness/data/repositories/quote_repository.dart`
- [ ] 5.6 Create `lib/features/wellness/data/repositories/gratitude_repository.dart`
- [ ] 5.7 Create `lib/features/wellness/presentation/providers/wellness_provider.dart` (@riverpod)
- [ ] 5.8 Create `lib/features/wellness/presentation/providers/audio_player_provider.dart` (@riverpod)
- [ ] 5.9 Create `lib/features/wellness/presentation/widgets/bento_grid.dart` layout
- [ ] 5.10 Create `lib/features/wellness/presentation/widgets/breathe_bubble.dart` with animation
- [ ] 5.11 Create `lib/features/wellness/presentation/widgets/sound_tile.dart` player item
- [ ] 5.12 Create `lib/features/wellness/presentation/screens/wellness_screen.dart`
- [ ] 5.13 Create `lib/features/wellness/presentation/screens/breathe_screen.dart` full exercise
- [ ] 5.14 Create `lib/features/wellness/presentation/screens/quotes_screen.dart`
- [ ] 5.15 Create `lib/features/wellness/presentation/screens/gratitude_screen.dart`
- [ ] 5.16 Add placeholder audio assets to `assets/sounds/`
- [ ] 5.17 Test breathing animation timing (4-7-8 pattern)
- [ ] 5.18 Test audio playback and timer functionality

## 6. Settings Feature

- [ ] 6.1 Create `lib/features/settings/domain/entities/user_settings.dart`
- [ ] 6.2 Create `lib/features/settings/data/models/settings_model.dart` Hive model
- [ ] 6.3 Create `lib/features/settings/data/repositories/settings_repository.dart`
- [ ] 6.4 Create `lib/features/settings/presentation/providers/settings_provider.dart` (@riverpod)
- [ ] 6.5 Create `lib/features/settings/presentation/widgets/profile_card.dart`
- [ ] 6.6 Create `lib/features/settings/presentation/widgets/settings_section.dart` reusable
- [ ] 6.7 Create `lib/features/settings/presentation/widgets/settings_toggle.dart`
- [ ] 6.8 Create `lib/features/settings/presentation/widgets/settings_time_picker.dart`
- [ ] 6.9 Create `lib/features/settings/presentation/screens/settings_screen.dart`
- [ ] 6.10 Implement CSV export functionality
- [ ] 6.11 Implement cache clearing functionality
- [ ] 6.12 Test settings persistence

## 7. Integration & Polish

- [ ] 7.1 Verify all screens render correctly on iOS simulator
- [ ] 7.2 Verify all screens render correctly on Android emulator
- [ ] 7.3 Test offline functionality (airplane mode)
- [ ] 7.4 Verify data persists across app restarts
- [ ] 7.5 Test navigation between all screens
- [ ] 7.6 Run `flutter analyze` and fix any lint issues
- [ ] 7.7 Test build with `flutter build ios --debug` and `flutter build apk --debug`

## Dependencies

- Tasks 2.x must complete before 3.x-6.x can start
- Task 3.x (Home) can run in parallel with 4.x (Insights), 5.x (Wellness), 6.x (Settings) after core is done
- Task 7.x (Integration) requires all features to be complete

## Notes

- Use `dart run build_runner watch` during development for continuous code generation
- Test on both iOS and Android for glassmorphism blur effects (may vary by platform)
- Haptic feedback uses `HapticFeedback.lightImpact()` from flutter/services
