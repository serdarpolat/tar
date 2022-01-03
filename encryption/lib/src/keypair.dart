import 'package:encryption/encryption.dart';

abstract class Keypair {
  /// Bir [PrivateKey] kullanarak anahtar çifti oluşturuyoruz
  Keypair(PrivateKey privateKey);

  /// Random olarak anahtar çifti oluşturuyoruz
  Keypair.fromRandom();

  /// [PrivateKey] ile ilişkili [PublicKey] çek
  PublicKey get publicKey =>
      throw UnimplementedError('publicKey is not implemented yet!');

  /// [PublicKey] ile ilişkili [PrivateKey] çek
  PrivateKey get privateKey =>
      throw UnimplementedError('privateKey is not implemented yet!');
}
