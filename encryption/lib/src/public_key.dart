import 'dart:typed_data';

import 'package:pointycastle/export.dart' as pointy;

abstract class PublicKey {
  PublicKey();

  /// Verilen String diziden [PublicKey] oluşturuyoruz
  PublicKey.fromString(String publicKeyString);

  /// [PrivateKey] ile imzalanmış verilen mesajın imzasını doğruluyoruz.
  @Deprecated(
      'SHA256 imza doğrulaması için verifySHA256Signature metodunu kullanın')
  bool verifySignature(String message, String signature) =>
      throw UnimplementedError('verifySignature() henüz uygulanmamış');

  /// [PrivateKey] ile imzalanmış verilen SHA256 bazlı mesajının imzasını doğruluyoruz.
  bool verifySHA256Signature(Uint8List message, Uint8List signature) =>
      throw UnimplementedError('verifySHA256Signature() henüz uygulanmamış');

  /// [PrivateKey] ile imzalanmış verilen SHA512 bazlı mesajının imzasını doğruluyoruz.
  bool verifySHA512Signature(Uint8List message, Uint8List signature) =>
      throw UnimplementedError('verifySHA512Signature() henüz uygulanmamış');

  /// [PublicKey] 'imizi PointyCastle public key olarak dışa aktarıyoruz
  pointy.PublicKey get asPointyCastle =>
      throw UnimplementedError('asPointyCastle() henüz uygulanmamış');

  /// [PublicKey] 'imizi [PublicKey.fromString] ile String olarak dışa aktarıyoruz
  @override
  String toString() => super.toString();
}
