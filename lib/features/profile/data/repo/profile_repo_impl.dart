import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/features/auth/data/models/user_data.dart';
import 'package:wallets/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ApiService api;

  ProfileRepoImpl(this.api);

  @override
  Future<User> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProfilePicture() {
    // TODO: implement deleteProfilePicture
    throw UnimplementedError();
  }

  @override
  @override
  Future<User> getProfile() async {
    final rep = await api.get('${ApiConstants.baseApiUrl}/api/v1/auth/me');
    if (rep is Map<String, dynamic>) {
      final userMap = rep['user'] ?? rep['data']?['user'] ?? rep['data'];
      if (userMap is Map<String, dynamic>) {
        return User.fromJson(userMap);
      }
    }
    throw Exception('Invalid profile response');
  }

  @override
  Future<User> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> uploadProfilePicture({required String filePath}) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
