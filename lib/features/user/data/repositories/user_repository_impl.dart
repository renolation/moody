import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> getCurrentUser() async {
    // Current user is now managed by AuthService
    return null;
  }

  @override
  Future<User?> getUserById(String id) async {
    final model = await _remoteDataSource.getUserById(id);
    return model?.toEntity();
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final model = await _remoteDataSource.getUserByEmail(email);
    return model?.toEntity();
  }

  @override
  Future<User> createUser(User user) async {
    final model = UserModel.fromEntity(user);
    final created = await _remoteDataSource.createUser(model);
    return created.toEntity();
  }

  @override
  Future<User> updateUser(User user) async {
    final model = UserModel.fromEntity(user);
    final updated = await _remoteDataSource.updateUser(model);
    return updated.toEntity();
  }

  @override
  Future<void> deleteUser(String id) async {
    await _remoteDataSource.deleteUser(id);
  }
}
