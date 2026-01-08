# Spec: User Data Mapping

## ADDED Requirements

### Requirement: User-scoped data storage
All user-generated data MUST be associated with a user ID when the user is authenticated.

#### Scenario: Authenticated user creates mood entry
- Given a user is logged in with ID "user-123"
- When the user creates a mood entry
- Then the mood entry is stored with `userId = "user-123"`

#### Scenario: Anonymous user creates mood entry
- Given no user is logged in
- When the user creates a mood entry
- Then the mood entry is stored with `userId = null`

### Requirement: User-scoped data retrieval
Data queries MUST filter by the current user's ID.

#### Scenario: Authenticated user views moods
- Given a user is logged in with ID "user-123"
- And moods exist for "user-123" and "user-456"
- When the user views their moods
- Then only moods with `userId = "user-123"` are returned

#### Scenario: Anonymous user views moods
- Given no user is logged in
- And moods exist with `userId = null` and `userId = "user-123"`
- When the user views their moods
- Then only moods with `userId = null` are returned

### Requirement: Entity userId field
All user-owned entities MUST include an optional `userId` field.

#### Scenario: MoodEntry has userId
- Given the MoodEntry entity
- Then it includes `final String? userId` field
- And `userId` is included in `props` for equality
- And `copyWith` supports `userId` parameter

#### Scenario: ActivityEntry has userId
- Given the ActivityEntry entity
- Then it includes `final String? userId` field

#### Scenario: GratitudeEntry has userId
- Given the GratitudeEntry entity
- Then it includes `final String? userId` field

### Requirement: Model serialization includes userId
Models MUST serialize/deserialize the `userId` field correctly.

#### Scenario: MoodEntryModel JSON serialization
- Given a MoodEntryModel with `userId = "user-123"`
- When converted to JSON
- Then the output includes `"user_id": "user-123"`

#### Scenario: MoodEntryModel JSON deserialization
- Given JSON with `"user_id": "user-456"`
- When parsed to MoodEntryModel
- Then `model.userId == "user-456"`

#### Scenario: MoodEntryModel Hive serialization
- Given the MoodEntryModel class
- Then `userId` is annotated with `@HiveField(n)` where n is unique

## MODIFIED Requirements

### Requirement: Data source methods accept userId
All data source query and insert methods MUST accept an optional `userId` parameter.

#### Scenario: getMoods filters by userId
- Given `getMoods(userId: "user-123")` is called
- Then the backend query includes `user_id = "user-123"` filter

#### Scenario: addMood includes userId
- Given `addMood(model, userId: "user-123")` is called
- Then the inserted record has `user_id = "user-123"`

### Requirement: Repository passes userId from auth
Repositories MUST obtain the current user ID from providers and pass to data sources.

#### Scenario: MoodRepositoryImpl uses userId
- Given a user with ID "user-123" is authenticated
- When `getMoods()` is called on the repository
- Then it calls `dataSource.getMoods(userId: "user-123")`

### Requirement: Settings linked to user
UserSettings MUST be scoped to the authenticated user.

#### Scenario: Authenticated user settings
- Given a user is logged in
- When settings are loaded
- Then settings for that user's ID are retrieved
- And changes are saved with that user's ID
