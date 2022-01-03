import 'package:encrypted_messaging/services/encryption/encryption_service.dart';

class IEncryptionService {
  final _encService = EncryptionService();

  String encrypt(String pubKey, String message) =>
      _encService.encrypt(pubKey, message);
  String decrypt(String myPrivateKey, String message) =>
      _encService.decrypt(myPrivateKey, message);
}
