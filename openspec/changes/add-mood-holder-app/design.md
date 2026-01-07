# Design: Mood Holder App Architecture

## Context

Building a mental wellness Flutter app from scratch. The app must be offline-first, support a dark glassmorphism theme, and use modern Flutter patterns (Riverpod 3.0 with code generation). The UI designs are provided in `docs/ui/` showing a sophisticated dark theme with sage/teal accents.

### Stakeholders
- End users: Mindfulness seekers, self-improvers, anxiety management users
- Developer: Single developer maintaining the codebase

### Constraints
- Offline-first: App must work 100% without internet
- Modern Flutter: Use Flutter 3.x, Material 3, Riverpod 3.0
- Simple monetization: Freemium with $1/month VIP tier (no ads)

## Goals / Non-Goals

### Goals
- Build a fully functional mood tracking and wellness app
- Implement feature-first architecture for maintainability
- Create reusable glassmorphism UI components
- Support offline data persistence with Hive
- Enable mood-activity correlation insights

### Non-Goals
- Backend/cloud sync (future enhancement)
- Social features
- Complex AI/ML recommendations
- Multi-language support (initial release)

## Decisions

### 1. Feature-First Folder Structure

```
lib/
├── core/                    # Shared infrastructure
│   ├── constants/           # App colors, dimensions, strings
│   ├── enums/               # ActivityType, MoodScore, etc.
│   ├── extensions/          # DateTime, String extensions
│   ├── router/              # GoRouter configuration
│   ├── theme/               # ThemeData, AppPalette
│   └── widgets/             # Shared widgets (GlassPanel, etc.)
├── features/
│   ├── home/
│   │   ├── data/            # Repositories, Hive models
│   │   ├── domain/          # Entities, use cases
│   │   └── presentation/    # Screens, widgets, providers
│   ├── insights/
│   ├── wellness/
│   └── settings/
└── main.dart
```

**Rationale:** Feature-first structure keeps related code together, making features easier to understand, test, and modify independently.

### 2. State Management: Riverpod 3.0 with Code Generation

```dart
// Example: Mood Notifier
@riverpod
class MoodNotifier extends _$MoodNotifier {
  @override
  FutureOr<List<MoodEntry>> build() async {
    return _loadMoods();
  }

  Future<void> addMood(MoodEntry entry) async { ... }
}
```

**Rationale:**
- Type-safe, testable, and compile-time checked
- Code generation reduces boilerplate
- Better performance than Provider
- Official Riverpod recommendation

### 3. Local Storage: Hive

**Schema:**

| Box | Model | Fields |
|-----|-------|--------|
| `moods` | MoodEntryModel | id, score (1-5), note, tags, timestamp |
| `activities` | ActivityEntryModel | id, type, duration, intensity, timestamp |
| `quotes` | QuoteModel | id, text, author, isFavorite |
| `settings` | SettingsModel | theme, notificationTime, isVip |

**Rationale:**
- Fast, lightweight, no native dependencies
- Works offline without setup
- Type adapters for custom models

### 4. Navigation: GoRouter

```dart
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => HomeScreen()),
        GoRoute(path: '/insights', builder: (_, __) => InsightsScreen()),
        GoRoute(path: '/wellness', builder: (_, __) => WellnessScreen()),
        GoRoute(path: '/settings', builder: (_, __) => SettingsScreen()),
      ],
    ),
  ],
);
```

**Rationale:** Declarative routing with deep linking support, recommended by Flutter team.

### 5. Theme System: Dark Glassmorphism

**Color Palette:**
```dart
class AppPalette {
  // Dark theme (primary)
  static const darkBg = Color(0xFF151A19);
  static const sage50 = Color(0xFFF4F7F5);
  static const sage300 = Color(0xFFA8C3B3);
  static const sage600 = Color(0xFF52796F);
  static const sage800 = Color(0xFF2F3E46);
  static const primary = Color(0xFF13DAEC); // Teal accent for insights

  // Glassmorphism
  static const glassBackground = Color(0x8C1E282D); // 55% opacity
  static const glassBorder = Color(0x14FFFFFF); // 8% white
}
```

**Rationale:** Matches the provided UI designs, creates a calm, premium feel appropriate for a wellness app.

### 6. Widget Architecture

**Reusable Components:**
- `GlassPanel` - Frosted glass container with blur
- `MoodSelector` - 5-emoji horizontal selector
- `QuickLogButton` - Activity logging button with haptics
- `JourneyTimeline` - Vertical timeline of daily logs
- `MoodHeatmap` - Calendar with mood intensity colors
- `CorrelationChart` - Dual-axis line/bar chart
- `BreatheBubble` - Animated breathing circle
- `SoundTile` - Audio player list item

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| Hive schema migrations | Keep models simple; use version field for future migrations |
| Code generation build times | Use `build_runner watch` during development |
| Chart library limitations | fl_chart is flexible; fallback to custom painters if needed |
| Haptic feedback not on all devices | Graceful degradation with try-catch |

## Migration Plan

1. Delete default counter code in `lib/main.dart`
2. Add dependencies to `pubspec.yaml`
3. Run `flutter pub get` and `dart run build_runner build`
4. Create core infrastructure (theme, router, base widgets)
5. Implement features in order: Home → Insights → Wellness → Settings
6. Test on iOS and Android simulators

## Open Questions

- Q1: Should we implement VIP features now or stub them?
  - **Decision:** Stub VIP features with `isVip` checks; implement basic UI but disable premium features

- Q2: Should we include sound assets in the initial release?
  - **Decision:** Include 3 sample ambient sounds (Rain, Forest, Cafe) as placeholders; document asset sources
