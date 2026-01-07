# Core Infrastructure Specification

## ADDED Requirements

### Requirement: App Shell with Bottom Navigation

The app SHALL provide a persistent bottom navigation bar with four tabs: Home, Insights, Wellness, and Settings.

#### Scenario: User navigates between tabs
- **WHEN** user taps a navigation tab
- **THEN** the corresponding screen is displayed
- **AND** the selected tab is visually highlighted

#### Scenario: Navigation state preserved
- **WHEN** user switches from Home to Insights and back to Home
- **THEN** the Home screen state (scroll position, input) is preserved

### Requirement: Dark Glassmorphism Theme

The app SHALL implement a dark theme with glassmorphism visual effects using the sage/teal color palette.

#### Scenario: Theme applied consistently
- **WHEN** the app launches
- **THEN** dark background (0xFF151A19) is displayed
- **AND** glass panels have backdrop blur effect
- **AND** text uses sage color variants for hierarchy

#### Scenario: Glass panel styling
- **WHEN** a GlassPanel widget is rendered
- **THEN** it displays with 55% opacity background
- **AND** 16px backdrop blur
- **AND** 1px border at 8% white opacity

### Requirement: Riverpod State Management Setup

The app SHALL use Riverpod 3.0 with code generation for all state management.

#### Scenario: Provider scope initialized
- **WHEN** the app starts
- **THEN** ProviderScope wraps the entire widget tree
- **AND** all providers are accessible via ref.watch/read

#### Scenario: Generated code compilation
- **WHEN** developer runs build_runner
- **THEN** all @riverpod annotated classes generate corresponding providers
- **AND** no compile-time errors occur

### Requirement: Hive Local Storage Initialization

The app SHALL initialize Hive storage on startup and register all type adapters.

#### Scenario: Hive boxes opened on launch
- **WHEN** the app starts
- **THEN** Hive is initialized with app documents directory
- **AND** all required boxes (moods, activities, quotes, settings) are opened
- **AND** type adapters for custom models are registered

#### Scenario: Data persists across app restarts
- **WHEN** user logs a mood and restarts the app
- **THEN** the mood entry is still available after restart

### Requirement: GoRouter Navigation Configuration

The app SHALL use GoRouter for declarative navigation with a shell route for the bottom navigation.

#### Scenario: Deep linking support
- **WHEN** app receives a deep link to /insights
- **THEN** the Insights screen is displayed
- **AND** bottom navigation shows Insights tab selected

#### Scenario: Initial route
- **WHEN** app launches without deep link
- **THEN** Home screen is displayed as the initial route

### Requirement: Core Enums Definition

The app SHALL define enums for all fixed-value types to ensure type safety.

#### Scenario: MoodScore enum
- **WHEN** user selects a mood
- **THEN** mood is stored as MoodScore enum (awful=1, bad=2, okay=3, good=4, great=5)

#### Scenario: ActivityType enum
- **WHEN** user logs an activity
- **THEN** activity type is stored as ActivityType enum (walking, running, yoga, gym, cycling)
