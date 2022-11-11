// ignore_for_file: avoid_print

class AuthRepository {
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(const Duration(seconds: 3));
    print('logged in');
    throw Exception('failed log in');
  }
}
