import 'package:encrypted_messaging/services/auth/auth_service.dart';

class IAuthService {
  final _auth = AuthService();

  Future<String> register(String email, String password) async =>
      _auth.register(email, password);

  Future<String> signIn(String email, String password) async =>
      _auth.signIn(email, password);
  Future signOut() async => _auth.signOut();
}
