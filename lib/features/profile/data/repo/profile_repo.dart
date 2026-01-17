import 'package:wallets/features/auth/data/models/user_data.dart';

abstract class ProfileRepo {
  Future<User> getProfile();
  Future<User> updateProfile({
    required String name,
    required String email,
    required String phone,
  });
  Future<User> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> uploadProfilePicture({
    required String filePath,
  });
  Future<void> deleteProfilePicture();

}