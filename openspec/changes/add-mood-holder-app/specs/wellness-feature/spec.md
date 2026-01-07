# Wellness Feature Specification

## ADDED Requirements

### Requirement: Wellness Library Header

The Wellness screen SHALL display a header with "Wellness Library" title and search functionality.

#### Scenario: Header display
- **WHEN** user navigates to Wellness screen
- **THEN** "Wellness Library" title is displayed in large font
- **AND** a search icon button is visible

#### Scenario: Search functionality
- **WHEN** user taps the search icon
- **THEN** a search input field appears
- **AND** user can filter wellness content by name

### Requirement: Bento Grid Layout for Tools

The Wellness screen SHALL display wellness tools in an asymmetric bento grid layout.

#### Scenario: Grid display
- **WHEN** Wellness screen loads
- **THEN** tools are displayed in a 2-column bento grid
- **AND** Breathe Bubble card spans 2 rows on the left
- **AND** Daily Quotes and Gratitude Journal are stacked on the right

#### Scenario: Card interaction
- **WHEN** user taps a tool card
- **THEN** the card shows subtle hover/press feedback
- **AND** navigates to the tool's detail screen

### Requirement: Breathe Bubble Breathing Exercise

The app SHALL provide an animated breathing exercise with the 4-7-8 pattern.

#### Scenario: Breathe Bubble display
- **WHEN** user views the Breathe Bubble card
- **THEN** an animated pulsing circle is displayed
- **AND** "Breathe Bubble" title and "3 min session" subtitle are shown
- **AND** wind/air icon indicates the feature

#### Scenario: Breathing exercise flow
- **WHEN** user taps to start breathing exercise
- **THEN** circle expands for 4 seconds (Inhale)
- **AND** circle holds for 7 seconds (Hold)
- **AND** circle contracts for 8 seconds (Exhale)
- **AND** text prompts guide the user through each phase

#### Scenario: Haptic feedback during breathing
- **WHEN** breathing phase transitions occur
- **THEN** subtle haptic feedback is triggered
- **AND** different haptic patterns distinguish inhale/exhale

#### Scenario: Session completion
- **WHEN** 3-minute session completes
- **THEN** completion message is displayed
- **AND** user can restart or exit

### Requirement: Daily Quotes Gallery

The app SHALL provide a gallery of inspirational quotes.

#### Scenario: Quotes gallery display
- **WHEN** user taps Daily Quotes card
- **THEN** a scrollable list of quotes is displayed
- **AND** each quote shows text and author

#### Scenario: Quote favoriting
- **WHEN** user taps heart icon on a quote
- **THEN** quote is marked as favorite
- **AND** favorite status persists in local storage

### Requirement: Gratitude Journal

The app SHALL provide a simple gratitude journaling feature.

#### Scenario: Journal entry creation
- **WHEN** user taps Gratitude Journal card
- **THEN** a journal entry screen opens
- **AND** 3 text fields are displayed for gratitude items
- **AND** today's date is shown

#### Scenario: Journal entry saving
- **WHEN** user fills in gratitude items and saves
- **THEN** entry is stored in local database
- **AND** confirmation feedback is shown

#### Scenario: Historical entries
- **WHEN** user has previous journal entries
- **THEN** they can scroll to view past entries by date

### Requirement: Sleep Sounds and Ambience Player

The app SHALL provide ambient sound playback for relaxation and sleep.

#### Scenario: Sound list display
- **WHEN** user views Sleep Sounds section
- **THEN** available sounds are listed with play buttons
- **AND** each sound shows name, duration, and category
- **AND** currently playing sound shows animated equalizer bars

#### Scenario: Sound playback
- **WHEN** user taps play on a sound
- **THEN** audio begins playing
- **AND** play button changes to pause
- **AND** audio continues when navigating to other screens

#### Scenario: Playback controls
- **WHEN** sound is playing
- **THEN** user can pause/resume with tap
- **AND** mini-player appears at bottom of screen
- **AND** user can set a sleep timer

#### Scenario: Sleep timer
- **WHEN** user sets a 30-minute sleep timer
- **THEN** audio automatically stops after 30 minutes
- **AND** timer countdown is displayed
