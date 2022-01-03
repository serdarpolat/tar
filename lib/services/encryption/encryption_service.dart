import 'package:encryption/encryption.dart';

class EncryptionService {
  String encrypt(String pubKey, String message) {
    RSAPublicKey publicKey = RSAPublicKey.fromString(pubKey);

    return publicKey.encrypt(message);
  }

  String decrypt(String myPrivateKey, String message) {
    RSAPrivateKey privateKey = RSAPrivateKey.fromString(myPrivateKey);

    return privateKey.decrypt(message);
  }
}
