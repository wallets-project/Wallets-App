abstract class AuthRepo {
  Future<void> login({required String email, required String password});
}
