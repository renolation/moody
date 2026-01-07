# Flutter Mobile App - Mood Holder (Mindfulness & Wellness) Expert Guidelines

## 🎯 App Overview

A minimalist mental health ecosystem designed to bridge the gap between reflection and action. **"Mood Holder"** combines mood tracking, micro-journaling, and habit correlation (exercise, sleep, water) with immediate relief tools like breathing exercises and sleep sounds.

### 🎯 Main Objectives

- **Reflective Tracking:** Friction-free logging of mood and "Micro-Diary" notes.
- **Actionable Insights:** Correlating physical habits (exercise, sleep) with emotional states.
- **Immediate Relief:** "Calm"-style tools (Breathe Bubble, Sleep Sounds) for instant stress reduction.
- **Sustainable Growth:** VIP analytics and "Monthly Wrap" reports to foster long-term mental health.

### 👥 Target Users

- **Mindfulness Seekers:** People wanting to understand their emotional patterns.
- **Self-Improvers:** Users trying to build better habits (sleep, hydration, movement).
- **Anxiety/Stress Management:** Users needing immediate grounding tools.

---

## 📁 Reference Materials

The `design/` folder (conceptual) contains UI/UX reference mockups based on the "Glassmorphism" and "Calm" aesthetic.

- **Primary Style:** Minimalist, Soft Sage/Teal Palette, Rounded Corners (24px), Translucent "Frosted Glass" elements.

### 📝 Code Examples

All Dart code examples, patterns, and snippets are maintained in `CODE_EXAMPLES.md`. Refer to that document for:

- Best practices (Hive, Riverpod 3.0, Flutter Hooks)
- UI/UX components (Glassmorphism cards, Bento grids)
- State management patterns (@riverpod, Notifier, AsyncNotifier)
- Animation controllers (Breathe Bubble)
- Local Notification scheduling

### 🎨 App Settings & Theme

See `APP_SETTINGS.md` for:

- ThemeData configuration (Light/Dark/Sage)
- AppPalette (Teal, Cream, Soft Green)
- Typography (Inter or San Francisco)

---

## 🤖 SUBAGENT DELEGATION SYSTEM

> **CRITICAL: BE PROACTIVE WITH SUBAGENTS! YOU HAVE SPECIALIZED EXPERTS AVAILABLE!**

### 🚨 DELEGATION MINDSET

Instead of thinking *"I'll handle this myself"* → Think: *"Which specialist is BEST suited for this task?"*

### 📋 AVAILABLE SPECIALISTS

You have access to these expert subagents - **USE THEM PROACTIVELY:**

#### 🎨 flutter-widget-expert

- **MUST BE USED for:** Mood selector (emoji slider), Breathe Bubble animation, Bento grid layout, Glassmorphism cards, Charts (fl_chart), Sleep player UI.
- **Triggers:** "create widget", "build UI", "animation", "layout", "glassmorphism", "chart", "player"

#### 📊 riverpod-expert

- **MUST BE USED for:** Riverpod 3.0 Generator, Ref logic, Notifier/AsyncNotifier, Side-effects, VIP subscription status, Cross-feature data aggregation.
- **Triggers:** "state management", "provider", "riverpod", "generator", "annotation", "ref.watch", "async value"

#### 🗄️ hive-expert

- **MUST BE USED for:** Storing daily logs offline, caching quotes, user preferences, local settings.
- **Triggers:** "database", "cache", "hive", "local storage", "persistence", "box", "offline"

#### 🌐 api-integration-expert

- **MUST BE USED for:** NestJS backend sync, RevenueCat (Subscriptions), Push Notifications, Cloud Backup.
- **Triggers:** "API", "HTTP", "dio", "backend", "sync", "subscription", "revenuecat"

#### 🏗️ architecture-expert

- **MUST BE USED for:** Feature-first folder structure, Repository pattern, Clean Architecture (Domain/Data/Presentation).
- **Triggers:** "architecture", "structure", "clean code", "dependency injection", "folder structure"

### 🎯 DELEGATION STRATEGY

**BEFORE starting ANY task, ASK YOURSELF:**

1. "Which of my specialists could handle this better?"
2. "Should I break this into parts for different specialists?"

### 🔧 HOW TO DELEGATE

```text
# Explicit delegation examples:
> Use the flutter-widget-expert to create the animated Breathe Bubble widget
> Have the riverpod-expert design the "Mood vs Exercise" Notifier using @riverpod
> Ask the hive-expert to create the local schema for storing Sleep Logs
> Use the api-integration-expert to implement the RevenueCat webhook handler
```

---

## Flutter Best Practices

- **Flutter 3.x & Material 3:** Use latest features but override visual style for custom "Soft UI".

- **Riverpod 3.0 (Code Generation):**
    - **Annotation:** Strictly use `@riverpod` for all providers.
    - **Class-Based:** Use `Notifier` and `AsyncNotifier` instead of `StateNotifier` or `ChangeNotifier`.
    - **Functional:** Use functional providers (`@riverpod FutureOr<Type> functionName(Ref ref)`) for simple read-only data.
    - **Ref:** Pass `Ref` explicitly where needed.

- **Feature-First Structure:** Organize code by feature (`features/mood`, `features/sleep`), not by type (`screens`, `widgets`).

- **Offline-First:** App must function 100% without internet (using Hive), syncing to NestJS only when active.

- **Strict Typing:** Use Enums for all fixed types (`Mood`, `ExerciseActivity`, `Weather`).

### AppBar & Scaffold Standardization

**Standard Pattern:**

- **Background:** Scaffold background is usually a soft gradient or off-white/cream.
- **AppBar:** Transparent or Frosted Glass (`ClipRRect` with `BackdropFilter`).
- **Titles:** Large, bold, left-aligned (e.g., "Good Morning, Alex").

### Currency & Subscription Formatting

- **VIP Pricing:** Display as "$1/month" or "$1.00 Lifetime" (depending on current strategy).
- **Format:** Use simple string interpolation for small amounts, e.g., `"\$${price}"`.

---

## App Context - Mood Holder

### About This App

**"Mood Holder"** is a comprehensive wellness application. It is not just a tracker; it is a **"Digital Sanctuary."** It moves users from *"How do I feel?"* to *"What can I do about it?"* using data insights and mindfulness tools.

### Design System: "Calm Minimalist"

- **Visuals:** Glassmorphism cards, extensive use of negative space, soft pastel colors.
- **Interaction:** Micro-haptics on button taps (e.g., when selecting a mood).
- **Typography:** Clean Sans-Serif (Inter/SF Pro).

---

## Core Features

### 🏠 Home Screen (The Hub)

**Purpose:** The central dashboard for daily check-ins and quick actions.

#### Key Features

**Daily Inspiration Card:**
- Displays the notification quote of the day.
- Background: Soft nature photography with overlay.

**Mood Logger (Hero Section):**
- Question: "How is your heart today?"
- Input: 5 custom line-art Emojis (Awful -> Great).
- Micro-Diary: Hidden text field expands upon selection.

**Quick-Log Activity Bar:**
- Horizontal scroll of circular buttons: Walk, Run, Yoga, Water.
- One-Tap Logic: Tapping "Walk" logs default (30 mins) instantly. Long-press to edit.

**Today's Journey:**
- Vertical timeline showing logs chronologically (e.g., "8:00 AM - 😊 Happy", "12:00 PM - 🏃 30m Run").

**State Management:** `home_view_model.dart` (Riverpod AsyncNotifier) aggregates data from Mood, Exercise, and Quote repositories.

---

### 📚 Features Tab (Wellness Library)

**Purpose:** A marketplace of tools for relief and self-improvement.

**Layout:** Bento Grid (Staggered Grid View).

#### Modules

**Breathe Bubble:**
- UI: Large pulsing circle animation.
- Logic: 4-7-8 breathing pattern (Inhale 4s, Hold 7s, Exhale 8s).
- Haptics: Vibrate on inhale/exhale transition.

**Sleep Sounds (Ambience):**
- Content: High-quality loops (Rain, Forest, White Noise - CC0/NCS).
- Player: Mini-player at bottom of screen when active.
- Timer: "Stop playing in 30 mins" slider.

**Gratitude Jar:**
- Simple list of "3 things I'm grateful for."

---

### 📊 Stats Tab (Insights & Analytics)

**Purpose:** The "Why" behind the mood. (Free vs. VIP split).

#### Free Features

- **Mood Heatmap:** Calendar view colored by daily average mood.
- **Basic Counts:** "You logged 5 moods this week."

#### VIP Features ($1/month)

- **Correlation Charts:** Dual-axis chart (Line = Mood, Bar = Exercise/Sleep).
- **Deep Insights:** "You are 20% happier on days you Walk."
- **Monthly Wrap:** "Your Month in Review" infographic card.
- **PDF Export:** Full data dump for therapy/medical use.

**Tech Stack:** `fl_chart` package for all graphs.

---

### ⚙️ Settings & VIP

**Purpose:** Configuration and Subscription Management.

#### Features

- **Health Sync:** Toggle for Apple Health / Google Health Connect (via `health` package).
- **Notifications:** "Daily Quote" time picker.
- **Theme:** Light / Dark / Sage (VIP).
- **VIP Purchase Card:**
    - "Support the Dev & Unlock Insights - $1/month".
    - Uses `revenue_cat` for processing.

---

## Technical Architecture

### State Management (Riverpod 3.0)

#### Feature-First Providers

- **MoodNotifier:** `@riverpod` class managing `List<MoodEntry>`.
- **ExerciseNotifier:** `@riverpod` class managing `ExerciseEntry` and Apple Health sync.
- **AudioPlayerNotifier:** Global state for the Sleep Sound player (continues playing across screens).
- **UserSettingsNotifier:** Holds `isVip` status and theme preferences.

#### Usage Rules

- **No StateNotifier:** Use `Notifier` or `AsyncNotifier`.
- **Code Gen:** Always use `part 'filename.g.dart';` and `@riverpod`.
- **Access:** Use `ref.watch(provider)` inside build methods of `ConsumerWidget` or `HookConsumerWidget`.

---

### Domain Entities & Data Models

The app uses **PostgreSQL** (NestJS backend) and **Hive** (Local).

#### Domain Entities (`lib/features/*/domain/entities/`)

**Activity Log (Unified)** - Instead of separate tables, we often view logs as a unified stream in the UI.

`activity_log.dart`:

| Field | Type | Description |
|-------|------|-------------|
| `id` | UUID | Unique identifier |
| `type` | Enum | mood, exercise, water, sleep, journal |
| `valueNumeric` | double | score, minutes, ml |
| `valueString` | String | label, activity name |
| `metadata` | Map<String, dynamic> | tags, intensity, specific sound name |
| `timestamp` | DateTime | When the activity occurred |

#### Hive Data Models (`lib/features/*/data/models/`)

Adapters for offline storage:

- **MoodEntryModel:** HiveObject with `score` (1-5), `note`, `tags`.
- **ExerciseEntryModel:** HiveObject with `activityType`, `duration`, `intensity`.
- **QuoteModel:** Cached daily quotes.

#### Enums (`lib/core/enums/`)

- **ActivityType:** `walking`, `running`, `yoga`, `gym`, `cycling`.
- **MoodScore:** `awful(1)`, `bad(2)`, `okay(3)`, `good(4)`, `great(5)`.
- **SubscriptionTier:** `free`, `vip`.

---

## Monetization Strategy (Silent VIP)

**Philosophy:** No interstitial ads. No interruptions.

**Model:** Freemium with a low-cost VIP tier ($1/month).

### VIP Benefits

- **Deep Analytics:** Correlation charts & "Why" insights.
- **Cloud Backup:** Secure sync to NestJS backend.
- **Full Sound Library:** Access to premium ambient tracks.
- **Custom Themes:** Aesthetic upgrades.
- **Monthly Report:** PDF generation.

### Implementation

- **Free Users:** See banners in "Stats" tab (native, non-intrusive).
- **VIP Users:** `isVip = true` removes banners and unlocks the `CorrelationChartWidget`.

---

## Development Workflow

### Feature Development Process

1. **Define Domain:** Create Entity and Hive Model.
2. **Build Repository:** Create Repository class handling Hive (cache) and API (sync).
3. **Create Provider:** Use `@riverpod` generator to create `Notifier` / `AsyncNotifier`.
4. **Build UI:**
    - Use `flutter-widget-expert` for complex layouts.
    - Implement "Glassmorphism" styles.
5. **Integrate:** Connect UI to Provider using `ConsumerWidget` or `HookConsumerWidget`.

### Code Review Checklist

- [ ] Follows "Calm/Minimalist" design specs.
- [ ] Offline-first (works without internet).
- [ ] Riverpod 3.0: No deprecated providers used; strictly `@riverpod`.
- [ ] Haptics implemented on interactive elements.
- [ ] VIP logic checks (`if (!ref.watch(isVipProvider)) ...`) are secure.

---

## Remember: ALWAYS DELEGATE TO SPECIALISTS!

| Task Type | Delegate To |
|-----------|-------------|
| Complex UI (Bento Grid, Charts) | → `flutter-widget-expert` |
| Logic (Correlations, Sync) | → `riverpod-expert` |
| Storage (Logs, Cache) | → `hive-expert` |
| Backend (NestJS, Auth) | → `api-integration-expert` |

> **Think delegation first, implementation second!**

<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->