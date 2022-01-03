import 'dart:typed_data';

import 'package:encryption/encryption.dart';
import 'package:pointycastle/export.dart' as pointy;

abstract class PrivateKey {
  PrivateKey();

  /// CVerieln String'e göre [PrivateKey] oluşturuyoruz.
  PrivateKey.fromString(String privateKeyString);

  /// Verilen mesajımızı [PublicKey] ile imzalıyoruz
  @Deprecated(
      'SHA-256 imzaları oluşturmak için createSHA256Signature metodunu kullanın')
  String createSignature(String message) =>
      throw UnimplementedError('createSignature() henüz oluşturulmamış');

  /// Verilen message String'ine göre bi tane SHA-256 oluşturuyoruz
  Uint8List createSHA256Signature(Uint8List message) =>
      throw UnimplementedError('createSHA256Signature() henüz oluşturulmamış');

  /// Verilen message String'ine göre bi tane SHA-512 oluşturuyoruz
  Uint8List createSHA512Signature(Uint8List message) =>
      throw UnimplementedError('createSHA512Signature() henüz oluşturulmamış');

  /// [PrivateKey]'e ait [PublicKey] 'i çağırıyoruz
  PublicKey get publicKey =>
      throw UnimplementedError('publicKey henüz oluşturulmamış');

  /// [PrivateKey] 'i PointyCastle PrivateKey olarak dışa aktarıyoruz
  pointy.PrivateKey get asPointyCastle =>
      throw UnimplementedError('asPointyCastle henüz oluşturulmamış');

  /// [PrivateKey.fromString] 'i kullanarak [PrivateKey] dışa aktarıyoruz.
  @override
  String toString() => super.toString();
}
