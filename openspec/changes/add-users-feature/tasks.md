# Tasks: Add Users Feature

## Phase 1: Domain Layer

- [x] **1.1** Create `features/user/` directory structure
  - `domain/entities/`, `domain/repositories/`
  - `data/models/`, `data/datasources/`, `data/repositories/`
  - `presentation/providers/`
  - Verify: Directories created

- [x] **1.2** Create `User` entity
  - File: `features/user/domain/entities/user.dart`
  - Fields: id, email, name, avatarUrl, createdAt
  - Implement Equatable
  - Add fromJson/toJson for persistence
  - Verify: Entity compiles

- [x] **1.3** Create `UserRepository` interface
  - File: `features/user/domain/repositories/user_repository.dart`
  - Methods: getCurrentUser, getUserById, createUser, updateUser, deleteUser
  - Verify: Interface compiles

## Phase 2: Data Layer

- [x] **2.1** Create `UserModel` with Hive adapter
  - File: `features/user/data/models/user_model.dart`
  - HiveType(typeId: 6)
  - Include fromJson, toJson, toEntity, fromEntity
  - Verify: Model compiles

- [x] **2.2** Create `UserRemoteDataSource`
  - File: `features/user/data/datasources/user_remote_data_source.dart`
  - Inject BackendService
  - Implement CRUD operations
  - Verify: DataSource compiles

- [x] **2.3** Create `UserRepositoryImpl`
  - File: `features/user/data/repositories/user_repository_impl.dart`
  - Implement all repository methods
  - Verify: Repository compiles

## Phase 3: Presentation Layer

- [x] **3.1** Create user providers
  - File: `features/user/presentation/providers/user_provider.dart`
  - userRemoteDataSourceProvider
  - userRepositoryProvider
  - currentUserProvider (AsyncNotifier with login/logout)
  - Verify: Providers generate correctly

- [x] **3.2** Update `backendServiceProvider` for offline-first
  - File: `core/services/backend_service_provider.dart`
  - Check currentUser state
  - Return HiveBackendService if no user (default)
  - Return SupabaseService if user logged in
  - Verify: Backend switches correctly

## Phase 4: Hive Setup

- [x] **4.1** Register UserModel Hive adapter
  - Update `main.dart` to open 'users' box
  - Verify: App starts without errors

- [x] **4.2** Update HiveBackendService for users table
  - Add users table mapping
  - Verify: Local user storage works

- [x] **4.3** Run `dart run build_runner build`
  - Generate Hive adapters and Riverpod providers
  - Verify: No build errors

## Phase 5: Database Setup

- [x] **5.1** Create Supabase `users` table
  - Add SQL to `supabase/migrations/003_add_users_table.sql`
  - Include RLS policies
  - Verify: SQL is valid

- [x] **5.2** Update `supabase/setup_all.sql`
  - Add users table to complete setup script
  - Verify: Script runs without errors

## Phase 6: Validation

- [x] **6.1** Run `flutter analyze`
  - Fix any warnings or errors
  - Verify: No issues found

- [ ] **6.2** Test offline mode (default)
  - App starts with no user
  - Data stored in Hive
  - Verify: Full functionality without login

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 1.2, 1.3 | 1.1 |
| 2.1, 2.2, 2.3 | 1.2, 1.3 |
| 3.1 | 2.3 |
| 3.2 | 3.1 |
| 4.1, 4.2, 4.3 | 2.1 |
| 5.1, 5.2 | (parallel) |
| 6.1, 6.2 | 3.2, 4.3 |

## Parallelizable Work

- Tasks 2.1, 2.2, 2.3 can run in parallel after domain layer
- Tasks 5.1, 5.2 can run in parallel with app code
- Phase 4 and Phase 5 can run in parallel
