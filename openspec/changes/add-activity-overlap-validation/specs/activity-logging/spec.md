## ADDED Requirements

### Requirement: Activity Overlap Prevention

The system SHALL prevent users from logging a new activity when a previous activity's time window has not yet elapsed.

#### Scenario: User attempts to log activity during ongoing activity

- **GIVEN** user logged a 30-minute walking activity at 10:00 AM
- **WHEN** user attempts to log another activity at 10:10 AM
- **THEN** the system SHALL reject the new activity
- **AND** display a message indicating an activity is still in progress with remaining time

#### Scenario: User logs activity after previous activity completes

- **GIVEN** user logged a 30-minute walking activity at 10:00 AM
- **WHEN** user attempts to log another activity at 10:35 AM
- **THEN** the system SHALL accept and save the new activity

#### Scenario: User logs first activity of the day

- **GIVEN** no activities have been logged today
- **WHEN** user logs a new activity
- **THEN** the system SHALL accept and save the activity without overlap checks

### Requirement: Overlap Error Feedback

The system SHALL provide clear, actionable feedback when an activity overlap is detected.

#### Scenario: Display remaining time in error message

- **GIVEN** user has an ongoing 30-minute activity that started at 10:00 AM
- **WHEN** user attempts to log at 10:15 AM
- **THEN** the system SHALL display "Activity in progress (15m remaining)"

#### Scenario: Haptic feedback on rejection

- **WHEN** a new activity is rejected due to overlap
- **THEN** the system SHALL provide haptic feedback indicating the rejection
