# Backend Service Capability

## Overview

The Backend Service provides an abstracted interface for all database operations, enabling the app to swap between different backend implementations (Supabase, Hive, Firebase, etc.) without modifying data source code.

---

## ADDED Requirements

### Requirement: App SHALL provide abstract BackendService interface

The app SHALL provide an abstract `BackendService` interface that defines standard CRUD operations for all data persistence.

#### Scenario: BackendService interface exists
- **Given** a developer needs to implement a new backend
- **When** they look at the core services
- **Then** they find a `BackendService` abstract class
- **And** it defines methods: `getAll`, `getById`, `insert`, `update`, `delete`, `query`

#### Scenario: BackendService supports generic queries
- **Given** a data source needs to filter records
- **When** it calls `query` with filter parameters
- **Then** the BackendService returns filtered results
- **And** supports equality, greater-than, less-than filters

---

### Requirement: App SHALL implement SupabaseService

The app SHALL implement a `SupabaseService` class that implements `BackendService` using Supabase as the backend.

#### Scenario: SupabaseService performs CRUD operations
- **Given** the app is configured to use SupabaseService
- **When** a data source calls `insert` with mood data
- **Then** the data is stored in the Supabase `moods` table
- **And** the created record is returned with its ID

#### Scenario: SupabaseService handles connection errors
- **Given** the Supabase server is unreachable
- **When** a data source attempts an operation
- **Then** the SupabaseService throws a meaningful exception
- **And** the calling code can handle the failure gracefully

---

### Requirement: App SHALL implement HiveBackendService

The app SHALL implement a `HiveBackendService` class that implements `BackendService` using Hive for offline storage.

#### Scenario: HiveBackendService works offline
- **Given** the device has no network connection
- **And** the app is configured to use HiveBackendService
- **When** a data source calls `getAll` for moods
- **Then** the locally stored moods are returned

#### Scenario: HiveBackendService maintains data compatibility
- **Given** the app has existing Hive data from before this change
- **When** HiveBackendService reads the data
- **Then** all existing records are accessible
- **And** the data format is preserved

---

### Requirement: Remote data sources SHALL use injected BackendService

All remote data source implementations SHALL receive a `BackendService` via dependency injection rather than directly accessing Hive or Supabase.

#### Scenario: MoodRemoteDataSource uses BackendService
- **Given** a `MoodRemoteDataSourceImpl` instance
- **When** it is constructed
- **Then** it receives a `BackendService` parameter
- **And** all database operations go through that service

#### Scenario: Switching backends requires no data source changes
- **Given** the app is using SupabaseService
- **When** a developer changes the provider to return HiveBackendService
- **Then** all data sources continue to work
- **And** no data source code needs modification

---

### Requirement: App SHALL initialize Supabase on startup

The app SHALL initialize the Supabase client in `main.dart` before running the app.

#### Scenario: Supabase initializes successfully
- **Given** valid Supabase URL and anon key are configured
- **When** the app starts
- **Then** `Supabase.initialize()` completes without errors
- **And** `Supabase.instance.client` is available for use

#### Scenario: App handles Supabase initialization failure
- **Given** invalid Supabase credentials
- **When** the app starts
- **Then** the initialization fails gracefully
- **And** the app can fall back to offline mode (future enhancement)

---

## Cross-References

- **Related:** All feature data sources (mood, activity, gratitude, quotes, sounds, settings)
- **Depends on:** `supabase_flutter` package
- **Enables:** Future authentication, real-time sync, cloud backup features
