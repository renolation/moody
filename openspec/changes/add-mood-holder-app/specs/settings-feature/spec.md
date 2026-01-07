# Settings Feature Specification

## ADDED Requirements

### Requirement: Settings Header with Back Navigation

The Settings screen SHALL display a header with back button and "Settings" title.

#### Scenario: Header display
- **WHEN** user navigates to Settings screen
- **THEN** "Settings" title is displayed
- **AND** back arrow button is visible on the left

#### Scenario: Back navigation
- **WHEN** user taps back button
- **THEN** user returns to previous screen

### Requirement: User Profile Card

The Settings screen SHALL display a user profile card with avatar and account info.

#### Scenario: Profile display
- **WHEN** Settings screen loads
- **THEN** user avatar (or default icon) is displayed
- **AND** user name and email are shown
- **AND** edit indicator is visible on avatar

#### Scenario: Profile editing
- **WHEN** user taps profile card
- **THEN** profile edit screen opens
- **AND** user can update name and avatar

### Requirement: Health Integration Toggle

The Settings screen SHALL provide a toggle for Apple Health / Google Fit integration.

#### Scenario: Integration toggle display
- **WHEN** viewing Integrations section
- **THEN** "Apple Health / Google Fit" option is displayed
- **AND** a toggle switch shows current status
- **AND** heart icon indicates health data

#### Scenario: Enabling health sync
- **WHEN** user enables health integration toggle
- **THEN** permission request is shown
- **AND** upon approval, health data sync begins
- **AND** toggle shows enabled state

#### Scenario: Disabling health sync
- **WHEN** user disables health integration toggle
- **THEN** health data sync stops
- **AND** local data is preserved

### Requirement: Notification Scheduling

The Settings screen SHALL allow users to configure notification times.

#### Scenario: Daily Quote notification time
- **WHEN** user views Notifications section
- **THEN** "Daily Quote Time" option shows current time (e.g., "08:00 AM")
- **AND** quote icon indicates the setting

#### Scenario: Mood Reminder notification time
- **WHEN** user views Notifications section
- **THEN** "Mood Reminder" option shows current time (e.g., "09:00 PM")
- **AND** mood icon indicates the setting

#### Scenario: Time picker interaction
- **WHEN** user taps a notification time setting
- **THEN** time picker dialog opens
- **AND** user can select hour and minute
- **AND** selected time is saved and notification rescheduled

### Requirement: Data Export

The Settings screen SHALL allow users to export their data as CSV.

#### Scenario: Export option display
- **WHEN** viewing Data & Privacy section
- **THEN** "Export Data (CSV)" option is displayed
- **AND** download icon indicates the action

#### Scenario: Data export execution
- **WHEN** user taps export option
- **THEN** CSV file is generated with all mood and activity data
- **AND** share sheet opens to save or send the file

### Requirement: Clear Local Cache

The Settings screen SHALL allow users to clear cached data.

#### Scenario: Cache info display
- **WHEN** viewing Data & Privacy section
- **THEN** "Clear Local Cache" option is displayed
- **AND** current cache size is shown (e.g., "14 MB")

#### Scenario: Cache clearing
- **WHEN** user taps clear cache option
- **THEN** confirmation dialog appears
- **AND** upon confirmation, cache is cleared
- **AND** cache size updates to reflect cleared state

### Requirement: App Version Display

The Settings screen SHALL display the current app version.

#### Scenario: Version display
- **WHEN** user scrolls to bottom of Settings
- **THEN** "Mood Holder v{version}" is displayed
- **AND** text is styled in muted color
