# Authentication Capability

## Overview

The Authentication capability provides secure email/password authentication using Supabase Auth. Users can sign up, sign in, sign out, and reset their password. Auth state is managed automatically via streams.

---

## ADDED Requirements

### Requirement: App SHALL provide AuthService interface

The app SHALL provide an `AuthService` interface for authentication operations.

#### Scenario: AuthService defines auth operations
- **Given** a developer needs to implement authentication
- **When** they look at AuthService
- **Then** it defines: authStateChanges (Stream), currentUser, signInWithEmail, signUpWithEmail, signOut, resetPassword
- **And** it can be implemented with different providers (Supabase, Firebase, etc.)

---

### Requirement: App SHALL authenticate with Supabase Auth

The app SHALL use Supabase Auth for email/password authentication.

#### Scenario: User signs in with email and password
- **Given** a user has an existing account
- **When** they enter valid email and password
- **And** tap "Log In"
- **Then** Supabase validates credentials
- **And** returns a session with JWT tokens
- **And** user is redirected back to settings

#### Scenario: User signs in with invalid credentials
- **Given** a user enters wrong email or password
- **When** they tap "Log In"
- **Then** Supabase returns an error
- **And** app shows "Invalid email or password" message
- **And** user remains on auth screen

---

### Requirement: App SHALL allow user registration

The app SHALL allow new users to create accounts with email, password, and name.

#### Scenario: User creates new account
- **Given** a user does not have an account
- **When** they enter email, password, and name
- **And** tap "Create Account"
- **Then** Supabase creates the account
- **And** stores name in user metadata
- **And** user is automatically signed in

#### Scenario: User tries to register with existing email
- **Given** an account exists with email "test@example.com"
- **When** a user tries to sign up with "test@example.com"
- **Then** Supabase returns an error
- **And** app shows "An account with this email already exists" message

---

### Requirement: App SHALL allow password reset

The app SHALL allow users to reset their password via email.

#### Scenario: User requests password reset
- **Given** a user forgot their password
- **When** they tap "Forgot Password"
- **And** enter their email address
- **Then** Supabase sends a password reset email
- **And** app shows "Password reset email sent" message

---

### Requirement: App SHALL manage auth state reactively

The app SHALL listen to auth state changes via stream and update UI automatically.

#### Scenario: Auth state updates on sign in
- **Given** a user is not signed in
- **When** they successfully sign in
- **Then** authStateChanges stream emits new User
- **And** currentUserProvider state updates automatically
- **And** backendServiceProvider switches to Supabase
- **And** settings screen shows user profile

#### Scenario: Auth state updates on sign out
- **Given** a user is signed in
- **When** they sign out
- **Then** authStateChanges stream emits null
- **And** currentUserProvider state updates to null
- **And** backendServiceProvider switches to Hive
- **And** settings screen shows "Sign in to sync"

#### Scenario: Auth state persists across restarts
- **Given** a user signed in previously
- **When** they restart the app
- **Then** Supabase restores the session automatically
- **And** currentUserProvider emits the user
- **And** app uses Supabase backend

---

### Requirement: App SHALL handle auth errors gracefully

The app SHALL display user-friendly error messages for authentication failures.

#### Scenario: Network error during sign in
- **Given** the device has no network connection
- **When** user tries to sign in
- **Then** app shows "Unable to connect. Please check your internet connection"

#### Scenario: Weak password during sign up
- **Given** user enters a password less than 6 characters
- **When** they try to create account
- **Then** app shows "Password must be at least 6 characters"

---

## Cross-References

- **Related:** User Management (user entity, user provider)
- **Depends on:** Supabase Backend Integration (Supabase client initialized)
- **Enables:** Future OAuth providers, email verification, two-factor auth
