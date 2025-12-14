abstract class AuthRepo {
  Future<void> login({required String phone, required String password});
}
