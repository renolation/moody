# Spec: Configurable Activity Defaults

## Overview
Activity type default durations are stored per-user in the settings table. New users automatically get a settings row with all defaults configured.

## ADDED Requirements

### Requirement: Settings table stores activity durations
The system MUST store per-user activity duration defaults in the settings table with columns for walking, running, yoga, gym, and cycling durations.

#### Scenario: Settings row contains activity durations
- **Given** a user has a settings row
- **When** the settings are fetched
- **Then** the response includes walking_duration, running_duration, yoga_duration, gym_duration, and cycling_duration fields

### Requirement: Quick-log uses user's configured duration
The system MUST use the user's configured duration from settings when quick-logging an activity.

#### Scenario: Quick-log walking with user's duration
- **Given** user has walking_duration set to 45 in settings
- **When** user quick-logs a walking activity
- **Then** activity is created with duration of 45 minutes

#### Scenario: Quick-log gym with default duration
- **Given** user has gym_duration set to 45 (default) in settings
- **When** user quick-logs a gym activity
- **Then** activity is created with duration of 45 minutes

### Requirement: Default settings created for new users
The system MUST automatically create a settings row with all default values when a new user is created in the users table.

#### Scenario: New user gets complete settings row
- **Given** a new user is created in the users table
- **When** the database trigger executes
- **Then** a settings row is created with user_id matching the new user
- **And** walking_duration defaults to 30
- **And** running_duration defaults to 30
- **And** yoga_duration defaults to 30
- **And** gym_duration defaults to 45
- **And** cycling_duration defaults to 30
- **And** daily_quote_hour defaults to 8
- **And** mood_reminder_hour defaults to 21
- **And** theme defaults to 'dark'

### Requirement: Users can customize activity durations
The system MUST allow users to update their activity duration settings.

#### Scenario: User updates walking duration
- **Given** user has settings with walking_duration of 30
- **When** user updates walking_duration to 60
- **Then** settings are saved with walking_duration of 60
- **And** subsequent quick-logs use 60 minutes for walking

### Requirement: Fallback to defaults when settings unavailable
The system MUST fall back to hardcoded defaults when user settings are unavailable (offline/error).

#### Scenario: Offline quick-log uses enum default
- **Given** user settings cannot be fetched (network error)
- **When** user quick-logs a walking activity
- **Then** activity is created using the hardcoded enum default (30 minutes)
