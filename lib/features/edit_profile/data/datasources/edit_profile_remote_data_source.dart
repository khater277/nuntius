import 'package:nuntius_/core/firebase/firestore/users_database.dart';

abstract class EditProfileRemoteDataSource {
  Future<void> updateProfileData({required Map<String, dynamic> data});
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final UsersDatabase usersDatabase;

  EditProfileRemoteDataSourceImpl({required this.usersDatabase});
  @override
  Future<void> updateProfileData({required Map<String, dynamic> data}) {
    return usersDatabase.updateUserData(data: data);
  }
}
