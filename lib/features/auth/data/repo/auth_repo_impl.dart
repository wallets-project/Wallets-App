import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/core/storage/token_storage.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService api;
  final TokenStorage tokenStorage;

  AuthRepoImpl({required this.api, required this.tokenStorage});

  @override
  Future<void> login({required String phone, required String password}) async {
    final res = await api.post(
      '${ApiConstants.baseApiUrl}/api/v1/auth/login',
      data: {'phone': phone, 'password': password},
    );

    // عدّل المفاتيح حسب Response عندك
    final String token = (res['token'] ?? res['data']?['token']) as String;

    await tokenStorage.saveToken(token);
  }
}
