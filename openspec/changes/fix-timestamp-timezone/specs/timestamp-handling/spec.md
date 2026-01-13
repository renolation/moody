## ADDED Requirements

### Requirement: Timestamps Include Timezone Offset

The system SHALL serialize timestamps with the device's local timezone offset when sending to the backend.

#### Scenario: Timestamp serialization includes timezone

- **GIVEN** user's device is in GMT+7 timezone
- **WHEN** an activity is logged at 10:00 AM local time
- **THEN** the timestamp SHALL be serialized as `2024-01-13T10:00:00+07:00`

#### Scenario: Timestamp serialization for negative offset

- **GIVEN** user's device is in GMT-5 timezone
- **WHEN** an activity is logged at 10:00 AM local time
- **THEN** the timestamp SHALL be serialized as `2024-01-13T10:00:00-05:00`

### Requirement: Timestamps Converted to Local on Parse

The system SHALL convert timestamps to local time when parsing from the backend.

#### Scenario: UTC timestamp converted to local

- **GIVEN** backend returns timestamp `2024-01-13T03:00:00Z`
- **AND** user's device is in GMT+7 timezone
- **WHEN** the timestamp is parsed
- **THEN** the resulting DateTime SHALL represent 10:00 AM local time

#### Scenario: Offset timestamp converted to local

- **GIVEN** backend returns timestamp `2024-01-13T10:00:00+07:00`
- **AND** user's device is in GMT+7 timezone
- **WHEN** the timestamp is parsed
- **THEN** the resulting DateTime SHALL represent 10:00 AM local time

### Requirement: Date Filtering Uses Local Time

The system SHALL use local time boundaries when filtering entries by date.

#### Scenario: Filter today's activities in positive timezone

- **GIVEN** user's device is in GMT+7 timezone
- **AND** current local date is January 13, 2024
- **WHEN** filtering activities for today
- **THEN** the system SHALL query for timestamps between `2024-01-12T17:00:00Z` and `2024-01-13T17:00:00Z`
