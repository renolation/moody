# Home Feature Specification

## ADDED Requirements

### Requirement: Personalized Greeting Header

The Home screen SHALL display a personalized greeting with the user's name and a notification bell icon.

#### Scenario: Time-based greeting
- **WHEN** user opens the app in the morning (5AM-12PM)
- **THEN** greeting displays "Good morning, {name}"
- **WHEN** user opens the app in the afternoon (12PM-5PM)
- **THEN** greeting displays "Good afternoon, {name}"
- **WHEN** user opens the app in the evening (5PM-9PM)
- **THEN** greeting displays "Good evening, {name}"
- **WHEN** user opens the app at night (9PM-5AM)
- **THEN** greeting displays "Good night, {name}"

#### Scenario: Notification indicator
- **WHEN** there are unread notifications
- **THEN** an orange dot badge appears on the notification bell

### Requirement: Daily Inspiration Card

The Home screen SHALL display a daily inspirational quote in a glass panel card.

#### Scenario: Quote display
- **WHEN** Home screen loads
- **THEN** a motivational quote is displayed in italic styling
- **AND** the card has a gradient background with sage colors
- **AND** a "DAILY INSPIRATION" label appears above the quote

#### Scenario: Quote rotation
- **WHEN** a new day begins
- **THEN** a different quote is displayed from the quotes collection

### Requirement: Mood Logger with Emoji Selector

The Home screen SHALL provide a 5-level emoji mood selector for logging current emotional state.

#### Scenario: Mood selection
- **WHEN** user views the mood logger section
- **THEN** 5 emoji buttons are displayed (Awful, Bad, Okay, Good, Great)
- **AND** the question "How are you feeling?" is shown above

#### Scenario: Mood selected feedback
- **WHEN** user taps a mood emoji
- **THEN** the selected emoji is highlighted with a background circle
- **AND** haptic feedback is triggered
- **AND** a text input field expands for optional notes

#### Scenario: Mood with note submission
- **WHEN** user selects a mood and enters a note
- **AND** taps the submit arrow button
- **THEN** the mood entry is saved with timestamp and note
- **AND** the input field clears
- **AND** the entry appears in Today's Journey

### Requirement: Quick Log Activity Bar

The Home screen SHALL provide quick-access buttons for logging common activities.

#### Scenario: Activity buttons display
- **WHEN** Home screen loads
- **THEN** 4 activity buttons are displayed: Walk, Run, Yoga, Gym
- **AND** each button shows an icon and label

#### Scenario: Quick activity logging
- **WHEN** user taps an activity button (e.g., Walk)
- **THEN** a default 30-minute activity entry is logged
- **AND** haptic feedback confirms the action
- **AND** the entry appears in Today's Journey

#### Scenario: Long press for custom duration
- **WHEN** user long-presses an activity button
- **THEN** a duration picker dialog appears
- **AND** user can select custom duration before logging

### Requirement: Today's Journey Timeline

The Home screen SHALL display a vertical timeline of all logs from the current day.

#### Scenario: Timeline display
- **WHEN** user has logged moods and activities today
- **THEN** entries appear in chronological order
- **AND** each entry shows time, icon, and description
- **AND** a vertical line connects the entries

#### Scenario: Empty state
- **WHEN** user has no logs for today
- **THEN** a friendly empty state message is displayed
- **AND** user is encouraged to log their first mood

#### Scenario: Entry types differentiation
- **WHEN** timeline contains mixed entry types
- **THEN** mood entries show emoji icons
- **AND** activity entries show activity-specific icons (walk, run, etc.)
