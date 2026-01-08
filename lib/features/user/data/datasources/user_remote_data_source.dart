import '../../../../core/services/backend_service.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUserById(String id);
  Future<UserModel?> getUserByEmail(String email);
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  static const String tableName = 'users';

  final BackendService _backend;

  UserRemoteDataSourceImpl(this._backend);

  @override
  Future<UserModel?> getUserById(String id) async {
    final data = await _backend.getById(tableName, id);
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final data = await _backend.query(
      tableName,
      equalFilters: {'email': email},
      limit: 1,
    );
    if (data.isEmpty) return null;
    return UserModel.fromJson(data.first);
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final data = await _backend.insert(tableName, user.toJson());
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    final data = await _backend.update(tableName, user.id, user.toJson());
    return UserModel.fromJson(data);
  }

  @override
  Future<void> deleteUser(String id) async {
    await _backend.delete(tableName, id);
  }
}
