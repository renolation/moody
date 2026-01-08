# Activity Screen Capability

## Overview

The Activity Screen provides users with a dedicated dashboard to view their physical activity progress, insights on mood correlation, and recent movement history.

---

## ADDED Requirements

### Requirement: App SHALL display Activity Tab in Navigation

The bottom navigation bar SHALL include an Activity tab between Home and Insights.

#### Scenario: User sees Activity tab in navigation
- **Given** the user is on any screen with bottom navigation
- **When** the navigation bar is visible
- **Then** 5 tabs are displayed: Home, Activity, Insights, Wellness, Settings
- **And** the Activity tab shows a running/directions icon

#### Scenario: User navigates to Activity screen
- **Given** the user is on the Home screen
- **When** the user taps the Activity tab
- **Then** the Activity screen is displayed
- **And** the Activity tab appears selected (highlighted)

---

### Requirement: Activity Screen SHALL display Progress Ring

The Activity screen SHALL display a circular progress ring showing today's movement minutes against the daily goal.

#### Scenario: User views progress ring with partial completion
- **Given** the user has logged 45 minutes of activity today
- **And** the daily goal is 60 minutes
- **When** the Activity screen loads
- **Then** a circular progress ring displays at 75% fill
- **And** the center shows "45" in large text with "min" label
- **And** below shows "OF 60 MIN GOAL"

#### Scenario: User views progress ring with no activity
- **Given** the user has logged 0 minutes of activity today
- **When** the Activity screen loads
- **Then** the progress ring displays at 0% (empty track only)
- **And** the center shows "0" with "min" label

#### Scenario: User exceeds daily goal
- **Given** the user has logged 75 minutes of activity today
- **And** the daily goal is 60 minutes
- **When** the Activity screen loads
- **Then** the progress ring displays at 100% fill
- **And** the center shows "75" in large text

---

### Requirement: Activity Screen SHALL display Top Activity Card

The Activity screen SHALL display a card showing the user's most frequent activity type.

#### Scenario: User views top activity breakdown
- **Given** the user has logged activities this week: Walking (5x), Yoga (2x), Running (1x)
- **When** the Activity screen loads
- **Then** the Top Activity card displays "Walking"
- **And** a progress bar shows approximately 62% fill (5/8)

#### Scenario: User has no activities this week
- **Given** the user has not logged any activities this week
- **When** the Activity screen loads
- **Then** the Top Activity card displays "No activity yet"
- **And** the progress bar is empty

---

### Requirement: Activity Screen SHALL display Mood Lift Insight Card

The Activity screen SHALL display a glowing insight card showing the correlation between exercise and mood improvement.

#### Scenario: User views positive mood correlation
- **Given** the user's average mood on exercise days is 4.2
- **And** the user's average mood on non-exercise days is 3.5
- **When** the Activity screen loads
- **Then** the Mood Lift card displays "Mood Lift: +20%"
- **And** the card has a yellow/gold glowing border effect
- **And** an "INSIGHT" badge is visible

#### Scenario: Insufficient data for correlation
- **Given** the user has fewer than 3 exercise days recorded
- **When** the Activity screen loads
- **Then** the Mood Lift card displays "Keep logging to see insights"
- **And** the glow effect is dimmed

---

### Requirement: Activity Screen SHALL display Recent Movement List

The Activity screen SHALL display a list of recently logged activities.

#### Scenario: User views recent activities
- **Given** the user has logged multiple activities
- **When** the Activity screen loads
- **Then** up to 5 recent activities are displayed
- **And** each item shows: activity icon, name, duration, category, and timestamp
- **And** a "SEE ALL" button is visible in the header

#### Scenario: User has no recent activities
- **Given** the user has not logged any activities
- **When** the Activity screen loads
- **Then** an empty state message displays "Start moving to see your activity here"

---

## Cross-References

- **Related:** Home Screen - Quick Log Activity Bar (logs activities)
- **Related:** Insights Screen - Correlation Charts (VIP detailed analytics)
- **Depends on:** ActivityRepository, MoodRepository
