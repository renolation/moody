# Change: Build Complete Mood Holder App

## Why

The project currently has only a default Flutter counter template. We need to build the complete "Mood Holder" mental wellness app that enables users to track their mood, log activities, access mindfulness tools, and gain insights into their emotional patterns. This app will serve as a "Digital Sanctuary" bridging reflection and action through data-driven wellness features.

## What Changes

### New Capabilities

- **Core Infrastructure:** App shell with navigation, theme system (dark glassmorphism), Riverpod 3.0 setup, Hive local storage
- **Home Feature:** Daily mood logging with 5-level emoji selector, micro-diary notes, quick activity logging (Walk, Run, Yoga, Gym), daily journey timeline, inspirational quotes
- **Insights Feature:** Monthly mood heatmap calendar, mood-exercise correlation charts (VIP), key AI-generated insights, data export
- **Wellness Feature:** Breathe Bubble (4-7-8 breathing animation), Sleep Sounds player with timer, Daily Quotes gallery, Gratitude Journal
- **Settings Feature:** User profile, health integrations toggle (Apple Health/Google Fit), notification scheduling, data export/clear cache

### Technical Stack

- Flutter 3.x with Material 3
- Riverpod 3.0 with code generation (`@riverpod`)
- Hive for offline-first local storage
- fl_chart for visualization
- Feature-first folder architecture

## Impact

- Affected specs: All new (core-infrastructure, home-feature, insights-feature, wellness-feature, settings-feature)
- Affected code: Complete rewrite of `lib/` with feature-first structure
- Dependencies: New packages (flutter_riverpod, riverpod_annotation, hive, hive_flutter, fl_chart, go_router, etc.)
