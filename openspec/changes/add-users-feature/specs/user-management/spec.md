# User Management Capability

## Overview

The User Management capability provides optional user accounts for cloud sync. The app works fully offline by default using Hive. Users only need to login if they want to sync data across devices.

---

## ADDED Requirements

### Requirement: App SHALL work offline by default

The app SHALL function fully without user login, storing all data locally in Hive.

#### Scenario: New user uses app without account
- **Given** a user opens the app for the first time
- **When** they have not logged in
- **Then** the app works with full functionality
- **And** all data is stored locally in Hive
- **And** no network connection is required

#### Scenario: Backend defaults to Hive
- **Given** no user is logged in
- **When** backendServiceProvider is accessed
- **Then** it returns HiveBackendService
- **And** all data operations use local storage

---

### Requirement: App SHALL provide User entity

The app SHALL provide a `User` entity that represents a user profile for cloud sync.

#### Scenario: User entity contains required fields
- **Given** a developer needs to work with user data
- **When** they access the User entity
- **Then** it contains: id (String), email (String), name (String), avatarUrl (String?), createdAt (DateTime)
- **And** it implements Equatable for value comparison

---

### Requirement: App SHALL switch backend based on login state

The app SHALL use Supabase when logged in and Hive when not logged in.

#### Scenario: Logged in user uses Supabase
- **Given** a user is logged in
- **When** backendServiceProvider is accessed
- **Then** it returns SupabaseService
- **And** all data syncs to cloud

#### Scenario: Logged out user uses Hive
- **Given** a user logs out
- **When** backendServiceProvider is accessed
- **Then** it returns HiveBackendService
- **And** data operations use local storage only

---

### Requirement: App SHALL provide UserRepository interface

The app SHALL provide a `UserRepository` interface for user data operations.

#### Scenario: UserRepository defines operations
- **Given** a developer needs to manage users
- **When** they look at UserRepository
- **Then** it defines: getCurrentUser, getUserById, createUser, updateUser, deleteUser
- **And** operations work with both Hive and Supabase backends

---

### Requirement: App SHALL store users in Supabase

The app SHALL store user profiles in a Supabase `users` table when syncing to cloud.

#### Scenario: Users table exists in Supabase
- **Given** the Supabase project is configured
- **When** the database is set up
- **Then** a `users` table exists with columns: id (UUID), email, name, avatarUrl, createdAt
- **And** email has a unique constraint

#### Scenario: Users table has RLS policies
- **Given** Row Level Security is enabled
- **When** users access the table
- **Then** appropriate policies control access
- **And** data is protected from unauthorized access

---

### Requirement: App SHALL persist login state

The app SHALL remember if a user was logged in across app restarts.

#### Scenario: Login persists after restart
- **Given** a user logged in previously
- **When** they restart the app
- **Then** they remain logged in
- **And** data continues syncing to cloud

#### Scenario: Logout clears persisted state
- **Given** a user logs out
- **When** they restart the app
- **Then** they are not logged in
- **And** app uses Hive for local storage

---

## Cross-References

- **Related:** Settings feature (user preferences stored separately)
- **Depends on:** BackendService abstraction from integrate-supabase-backend
- **Enables:** Future authentication UI, data migration, multi-device sync
