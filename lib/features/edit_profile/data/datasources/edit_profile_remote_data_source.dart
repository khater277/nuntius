import 'package:nuntius/core/firebase/firestore/users_database.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';

abstract class EditProfileRemoteDataSource {
  Future<void> updateProfileData({required Map<String, dynamic> data});
  Future<void> deleteAccount();
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final UsersDatabase _usersDatabase;
  final UserStorage _userStorage;

  EditProfileRemoteDataSourceImpl(
      {required UsersDatabase usersDatabase, required UserStorage userStorage})
      : _usersDatabase = usersDatabase,
        _userStorage = userStorage;

  @override
  Future<void> updateProfileData({required Map<String, dynamic> data}) {
    return _usersDatabase.updateUserData(
        phoneNumber: _userStorage.getUser()!.phone!, data: data);
  }

  @override
  Future<void> deleteAccount() {
    return _usersDatabase.deleteUserAccount();
  }
}
